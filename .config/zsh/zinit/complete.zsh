#!/usr/bin/zsh

# Init completion system and and load plugins in turbo mode
local zsh_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
[[ -d "${zsh_compdump:h}" ]] || mkdir -p "${zsh_compdump:h}"

ZINIT[COMPINIT_OPTS]="-C -d ${zsh_compdump}"

zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
  zdharma-continuum/fast-syntax-highlighting \
  Aloxaf/fzf-tab \
  blockf \
  zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Completion styling
zstyle ':completion:*' cache-path "$zsh_compdump"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Ignore case
zstyle ':completion:*' menu no                         # Disable default zsh completion menu - we're using fzf
zstyle ':fzf-tab:*' fzf-flags --color=marker:#bac2de,pointer:#bac2de
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
