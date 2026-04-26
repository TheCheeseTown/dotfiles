# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Load dotfiles
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Zsh completion
autoload -Uz compinit && compinit
