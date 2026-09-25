#!/bin/sh

set -eu

if [ "$#" -gt 1 ]; then
	printf 'usage: %s [project|all]\n' "$0" >&2
	exit 2
fi

project=${1:-all}
command -v gh >/dev/null 2>&1 || {
	printf '%s\n' 'error: GitHub CLI (gh) is required' >&2
	exit 1
}

gh auth status --hostname github.com >/dev/null
exec gh workflow run update-formula.yml \
	--repo leolaurindo/homebrew-tap \
	-f "project=$project"
