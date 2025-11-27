#!/usr/bin/zsh

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Init completion system
autoload -Uz compinit && compinit
# Replay cached completions
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'                      # Ignore case
zstyle ':completion:*' menu no                                              # Disable default zsh completion menu - we're using fzf
zstyle ':fzf-tab:*' fzf-flags --color=marker:#bac2de,pointer:#bac2de
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"