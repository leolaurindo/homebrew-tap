#!/bin/sh

set -eu

if [ "$#" -gt 2 ]; then
	printf 'usage: %s [project|all] [version]\n' "$0" >&2
	exit 2
fi

project=${1:-all}
version=${2:-}
if [ -n "$version" ] && [ "$project" != "chess-analyzer-tui" ]; then
	printf '%s\n' 'error: version can only be specified for chess-analyzer-tui' >&2
	exit 2
fi
command -v gh >/dev/null 2>&1 || {
	printf '%s\n' 'error: GitHub CLI (gh) is required' >&2
	exit 1
}

gh auth status --hostname github.com >/dev/null
if [ -n "$version" ]; then
	exec gh workflow run update-formula.yml \
		--repo leolaurindo/homebrew-tap \
		-f "project=$project" \
		-f "version=$version"
fi
exec gh workflow run update-formula.yml \
	--repo leolaurindo/homebrew-tap \
	-f "project=$project"
