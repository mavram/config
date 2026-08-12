# Environment
if [[ -t 0 ]]; then
    export GPG_TTY="$(tty)"
fi

export EDITOR=nvim
export VISUAL=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LESSHISTFILE=-
export PAGER=less
export LESS='-FRX'
export BAT_THEME='auto:system'
export BAT_THEME_DARK='Catppuccin Mocha'
export BAT_THEME_LIGHT='Catppuccin Latte'

# Aliases
alias ll='ls -lahG'
alias vi='nvim'

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

mkdir -p "${HISTFILE:h}" "$XDG_CACHE_HOME/zsh"

setopt share_history
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify

# Line editor
bindkey -v
KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    case $KEYMAP in
    vicmd) print -n '\e[2 q' ;;
    *) print -n '\e[6 q' ;;
    esac
}

function zle-line-finish {
    print -n '\e[2 q'
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

# Shell behavior
setopt auto_cd no_beep numeric_glob_sort

# Completion
autoload -Uz compinit
compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Fuzzy finder
if (($+commands[fzf])); then
    source <(fzf --zsh)
fi

# Prompt
PROMPT='%F{244}%1~%f : '

# Man pages
if (($+commands[bat] && $+commands[col])); then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
