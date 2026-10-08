# leolaurindo Homebrew tap

Homebrew formulae for command-line tools by [Leolaurindo](https://github.com/leolaurindo).

## Install

Install a formula with:

```sh
brew install leolaurindo/tap/gixt
brew install leolaurindo/tap/chess-analyzer-tui
```

This tap currently provides:

- [gixt](https://github.com/leolaurindo/gixt) — a command-line tool for working with GitHub Gists.
- [chess-analyzer-tui](https://github.com/leolaurindo/chess-analyzer-tui) — terminal chess analysis with Stockfish. The formula installs Stockfish and the Python runtime. On Linux, clipboard support is optional; install `wl-clipboard` for Wayland or `xclip` / `xsel` for X11 if needed.

## Updating formulae

Run the **Actions → Update Homebrew formulae → Run workflow** workflow and choose `all` or a project. For `chess-analyzer-tui`, optionally enter a PyPI release version; leaving it blank selects the latest published version. From a terminal, use:

```sh
./scripts/update-formula.sh                         # update all formulae
./scripts/update-formula.sh gixt                    # update only gixt
./scripts/update-formula.sh chess-analyzer-tui 0.2.0 # update a specific PyPI release
```

The workflow updates the formula and Python dependency resources, validates and tests the formula, then opens a pull request. Review and merge the PR to publish the update. Enable **Settings → Actions → General → Allow GitHub Actions to create and approve pull requests** so the workflow can open pull requests.

Binary formulae use the release archive/checksum updater in `scripts/update-formula.py`. The Python formula uses PyPI metadata and `brew update-python-resources`; its PyPI release must be published before running the workflow.
