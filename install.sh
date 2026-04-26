#!/usr/bin/env bash

scriptpath="$PWD"
cd "$scriptpath"

#!/bin/bash

printf 'Do you want to install XCode? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	printf "Installing XCode\n"
	xcode-select --install
fi

printf 'Do you want to change macos behaviour? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	printf "Setting up macos\n"
	source .macos --no-restart
fi

printf 'Do you want to install Homebrew? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	cd "$scriptpath"
	printf "Installing homebrew\n"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

printf 'Do you want to install Homebrew packages? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	source brew.sh
fi

printf 'Do you want to bootstrap dotfiles? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	source bootstrap.sh
fi

printf 'Do you want to generate an SSH key? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	if [[ -f ~/.ssh/id_ed25519 ]]; then
		printf "SSH key already exists at ~/.ssh/id_ed25519, skipping.\n"
	else
		printf "Enter your email for the SSH key: "
		read ssh_email
		ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/id_ed25519
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_ed25519
		printf "\nAdd this public key to GitHub (https://github.com/settings/keys):\n\n"
		cat ~/.ssh/id_ed25519.pub
	fi
fi

printf 'Do you want to install AstroNVIM config for neovim? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	printf "Installing astro NVIM\n"

	git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
	rm -rf ~/.config/nvim/.git
fi

printf 'Do you want to install macos apps from app Store? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	printf "Installing MacOS applications\n"
	macosappstoinstall=()
	macosappstoinstall=("${macosappstoinstall[@]}" "441258766") #Magnet
	for macapp in "${macosappstoinstall[@]}"; do
		mas install $macapp
	done
fi

printf 'Do you want to Change the dock? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	printf "Removing dock apps\n"
	dockappstoremove=()
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/TV.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Podcasts.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Safari.app")
	#dockappstoremove=("${dockappstoremove[@]}" /Applications/"Mail.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/FaceTime.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Messages.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Maps.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Photos.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Contacts.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Calendar.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Reminders.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Notes.app")
	#dockappstoremove=("${dockappstoremove[@]}" "/Applications/Music.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/News.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/'App Store'.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Pages.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Numbers.app")
	dockappstoremove=("${dockappstoremove[@]}" "/Applications/Keynote.app")
	#dockappstoremove=("${dockappstoremove[@]}" "/Applications/Freeform.app")
	for docapp in "${dockappstoremove[@]}"; do
		dockutil -r $docapp
	done

	printf "Adding dock apps\n"
	dockappstoadd=()
	dockappstoadd=("${dockappstoadd[@]}" "/Applications/Alacritty.app")
	dockappstoadd=("${dockappstoadd[@]}" "/Applications/Visual Studio Code.app")
	for docapp in "${dockappstoadd[@]}"; do
		dockutil -a $docapp
	done
fi

printf "Finished setting up the mac!"
