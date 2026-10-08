#!/usr/bin/env python3

import json
import re
import subprocess
import sys
import urllib.request
from pathlib import Path

PROJECT = "chess-analyzer-tui"
FORMULA = Path("Formula") / f"{PROJECT}.rb"
PYPI_JSON = f"https://pypi.org/pypi/{PROJECT}/json"


def main() -> None:
    if len(sys.argv) > 2:
        raise SystemExit(f"usage: {sys.argv[0]} [version]")

    requested_version = sys.argv[1].removeprefix("v") if len(sys.argv) == 2 else None
    with urllib.request.urlopen(PYPI_JSON) as response:
        data = json.load(response)

    version = requested_version or data["info"]["version"]
    try:
        release = json.load(urllib.request.urlopen(f"https://pypi.org/pypi/{PROJECT}/{version}/json"))
    except Exception as exc:
        raise SystemExit(f"could not fetch PyPI release {version}: {exc}") from exc

    sdists = [item for item in release["urls"] if item["packagetype"] == "sdist"]
    if len(sdists) != 1:
        raise SystemExit(f"expected one source distribution for {version}, found {len(sdists)}")
    sdist = sdists[0]
    formula = FORMULA.read_text()
    formula, url_count = re.subn(r'(?m)^  url "https://files\.pythonhosted\.org/[^\"]+"$',
                                 f'  url "{sdist["url"]}"', formula, count=1)
    formula, sha_count = re.subn(r'(?m)^  sha256 "[0-9a-f]{64}"$',
                                 f'  sha256 "{sdist["digests"]["sha256"]}"', formula, count=1)
    if url_count != 1 or sha_count != 1:
        raise SystemExit(f"could not update source URL and SHA-256 in {FORMULA}")
    FORMULA.write_text(formula)

    tapped_formula = Path(subprocess.check_output(
        ["brew", "--repository", "leolaurindo/tap"], text=True
    ).strip()) / FORMULA
    tapped_formula.write_text(formula)
    subprocess.run([
        "brew", "update-python-resources", "--ignore-main-package-cooldown",
        f"leolaurindo/tap/{PROJECT}",
    ], check=True)
    FORMULA.write_text(tapped_formula.read_text())
    print(f"Updated {FORMULA} to {version}")


if __name__ == "__main__":
    main()
