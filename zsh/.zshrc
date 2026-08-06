if [[ -t 0 ]]; then
  export GPG_TTY="$(tty)"
fi
export EDITOR=nvim
export VISUAL=nvim

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Aliases
alias ll='ls -lahG'
alias vim='nvim'
alias vi='nvim'
alias python='python3'
alias pip='python3 -m pip'

# Extensions
alias -s md=nvim
alias -s txt=nvim
alias -s json=nvim
alias -s yaml=nvim
alias -s yml=nvim
alias -s lua=nvim
alias -s py=nvim
alias -s go=nvim
alias -s js=nvim
alias -s jsx=nvim
alias -s conf=nvim
alias -s plist=nvim

# History
export HISTFILE="$XDG_STATE_HOME/zsh/history"

mkdir -p "${HISTFILE:h}" "$XDG_CACHE_HOME/zsh"

export HISTSIZE=10000
export SAVEHIST=10000

setopt append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify

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

function zle-line-finish {
  print -n '\e[2 q'
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

# Shell behaviour
setopt auto_cd
setopt no_beep
setopt numeric_glob_sort

# Completion
# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# Fuzzy finder
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Prompt
PROMPT='%F{244}%1~%f : '

# Disable less history
export LESSHISTFILE=-

# Pager
# Use bat for man pages when the required commands are available
if (( $+commands[bat] && $+commands[col] )); then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Use a broadly compatible pager command, with color support and clean exits.
export PAGER=less
export GIT_PAGER=less
export BAT_PAGER='less -FRX'

# Optional: make less itself nicer when it is still used
export LESS="-FRX"
