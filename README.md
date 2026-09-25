# leolaurindo Homebrew tap

Homebrew formulae for command-line tools by [Leolaurindo](https://github.com/leolaurindo).

## Install

Install gixt with:

```sh
brew install leolaurindo/tap/gixt
```

This tap currently provides:

- [gixt](https://github.com/leolaurindo/gixt) — a command-line tool for working with GitHub Gists.

## Updating formulae

Run the **Actions → Update Homebrew formulae → Run workflow** workflow and choose `all` or a project. From a terminal, use:

```sh
./scripts/update-formula.sh          # update all formulae
./scripts/update-formula.sh gixt     # update only gixt
```

The workflow opens a pull request with updated versions and macOS/Linux checksums. Review and merge it to publish the updates. Enable **Settings → Actions → General → Allow GitHub Actions to create and approve pull requests** so the workflow can open pull requests.

To add a CLI, add its formula under `Formula/`, add its name to `PROJECTS` in `scripts/update-formula.py` and to the workflow's `project` choices. Its release must provide `checksums.txt` and macOS/Linux archives named `<project>_v<version>_{darwin,linux}_{arm64,amd64}.tar.gz`.
