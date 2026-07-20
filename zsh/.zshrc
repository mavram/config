export GPG_TTY="$(tty)"
export EDITOR=nvim
export VISUAL=nvim

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_STATE_HOME}"

# Aliases
alias ll='ls -la'
alias vim='nvim'
alias vi='nvim'
alias python='python3'
alias pip='pip3'

# History
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "${HISTFILE:h}"
touch "$HISTFILE"

export HISTSIZE=10000
export SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Use vi-style command-line editing.
bindkey -v
KEYTIMEOUT=1

# Show zsh's current vi editing mode with the cursor shape.
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne '\e[2 q' ;; # block cursor
    *)     echo -ne '\e[6 q' ;; # line cursor
  esac
}

zle -N zle-line-init
zle -N zle-keymap-select

# Shell behaviour
setopt AUTO_CD
setopt NO_BEEP
setopt NUMERIC_GLOB_SORT
