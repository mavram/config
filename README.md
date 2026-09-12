# config

Machine Configuration

## Requirements

- Zsh 5.9 or newer
- Neovim 0.12 or newer (`vim.pack` is used for plugins)
- Git and curl
- Optional: fzf, language servers, and the formatters referenced in
  `nvim/init.lua`

Homebrew is detected automatically on Apple Silicon macOS, Intel macOS, and
Linux. The shell configuration also works without Homebrew or fzf.

## Installation

Clone the repository outside `~/.config`, which may already contain
application-managed files, and link only the configurations needed by the
machine:

```sh
git clone git@github.com:mavram/config.git "$HOME/.dotfiles"
ln -s "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
ln -s "$HOME/.dotfiles/git" "$HOME/.config/git"
```

Zsh does not discover `~/.config/zsh` by itself. Link its startup files:

```sh
ln -s "$HOME/.dotfiles/zsh/.zprofile" "$HOME/.zprofile"
ln -s "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
```

SSH commit signing is machine-specific. To enable it, create
`~/.config/git/config.local`; this file is ignored by Git:

```ini
[user]
    signingkey = ~/.ssh/github.pub
[gpg]
    format = ssh
[commit]
    gpgsign = true
```
