#!/usr/bin/zsh

# Auto-Dedupe PATH
typeset -U path

# MacOS specific - make home brew apps available on PATH
# eval "$(/opt/homebrew/bin/brew shellenv)"
# workaround of above to avoid permission issues
/opt/homebrew/bin/brew shellenv > /dev/null

path=(
  "/opt/homebrew/bin"
  $path
)

export PATH

[ -f "$XDG_CONFIG_HOME"/zsh/binding.zsh ] && source "$XDG_CONFIG_HOME"/zsh/binding.zsh
[ -f "$XDG_CONFIG_HOME"/zsh/alias.zsh ] && source "$XDG_CONFIG_HOME"/zsh/alias.zsh
[ -f "$XDG_CONFIG_HOME"/zsh/zinit/zinit.zsh ] && source "$XDG_CONFIG_HOME"/zsh/zinit/zinit.zsh
[ -f "$XDG_CONFIG_HOME"/zsh/zinit/complete.zsh ] && source "$XDG_CONFIG_HOME"/zsh/zinit/complete.zsh
[ -f "$XDG_CONFIG_HOME"/zsh/prompt.zsh ] && source "$XDG_CONFIG_HOME"/zsh/prompt.zsh
source $XDG_CONFIG_HOME/zsh/devtool/*.zsh(N)

# History
HISTSIZE=5000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

