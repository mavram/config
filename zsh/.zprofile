eval "$(/opt/homebrew/bin/brew shellenv zsh)"

mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
typeset -U path PATH
