#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull origin "$(git rev-parse --abbrev-ref HEAD)" 2>/dev/null || true

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "install.sh" \
		--exclude ".macos" \
		--exclude "CLAUDE.md" \
		--exclude "README.md" \
		-avh --no-perms . ~
	[[ -n "$ZSH_VERSION" ]] && source ~/.zshrc || true
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
