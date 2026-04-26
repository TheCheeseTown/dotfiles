#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew's installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Useful packages
brew install neovim
brew install --cask kitty
brew install tmux
brew install git
brew install tree-sitter
brew install lazygit
brew install fastfetch
brew install python@3
brew install iperf
brew install gcc
brew install --cask font-jetbrains-mono-nerd-font
brew install mas
brew install dockutil
brew install --cask visual-studio-code
brew install arduino-cli
brew install --cask obsidian
brew install --cask zed

# Remove outdated versions from the cellar.
brew cleanup
