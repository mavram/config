# Homebrew is installed in different locations on Apple Silicon, Intel macOS,
# and Linux. Only initialize it when it is available.
for brew_prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
    if [[ -x "$brew_prefix/bin/brew" ]]; then
        eval "$("$brew_prefix/bin/brew" shellenv zsh)"
        break
    fi
done
unset brew_prefix

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
typeset -U path PATH
