#!/usr/bin/env python3

import re
import subprocess
import sys
import urllib.request
from pathlib import Path

PROJECTS = ("gixt",)


def update_formula(project: str) -> None:
    repository = f"leolaurindo/{project}"
    tag = subprocess.check_output(
        ["gh", "release", "view", "--repo", repository, "--json", "tagName", "--jq", ".tagName"],
        text=True,
    ).strip()
    version = tag.removeprefix("v")
    checksum_url = f"https://github.com/{repository}/releases/download/{tag}/checksums.txt"
    with urllib.request.urlopen(checksum_url) as response:
        checksums = {
            asset: digest
            for digest, asset in (line.split() for line in response.read().decode().splitlines())
        }

    formula_path = Path("Formula") / f"{project}.rb"
    formula = formula_path.read_text()
    formula, count = re.subn(
        r'(?m)^  version "[^"]+"$', f'  version "{version}"', formula, count=1
    )
    if count != 1:
        raise SystemExit(f"could not update version in {formula_path}")

    for os_name, arch in (
        ("darwin", "arm64"),
        ("darwin", "amd64"),
        ("linux", "arm64"),
        ("linux", "amd64"),
    ):
        asset = f"{project}_{tag}_{os_name}_{arch}.tar.gz"
        try:
            digest = checksums[asset]
        except KeyError:
            raise SystemExit(f"missing {asset} in {repository} release checksums") from None
        if not re.fullmatch(r"[0-9a-f]{64}", digest):
            raise SystemExit(f"invalid SHA-256 for {asset}")

        formula, count = re.subn(
            rf'(url "[^"]*_{os_name}_{arch}\.tar\.gz"\n[ ]+sha256 ")[0-9a-f]{{64}}(")',
            rf"\g<1>{digest}\g<2>",
            formula,
            count=1,
        )
        if count != 1:
            raise SystemExit(f"could not update {os_name}/{arch} checksum in {formula_path}")

    formula_path.write_text(formula)
    print(f"Updated {formula_path} to {version}")


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: update-formula.py <project|all>")

    selected = sys.argv[1]
    projects = PROJECTS if selected == "all" else (selected,)
    unknown = sorted(set(projects) - set(PROJECTS))
    if unknown:
        raise SystemExit(f"unknown project(s): {', '.join(unknown)}")

    for project in projects:
        update_formula(project)


if __name__ == "__main__":
    main()
