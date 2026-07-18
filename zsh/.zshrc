export GPG_TTY="$(tty)"

alias ll='ls -la'
alias ch='cd ~'
alias vim='nvim'
alias vi='nvim'

# Disable zsh's audible bell.
unsetopt beep

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
