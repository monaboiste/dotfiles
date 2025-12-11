#!/usr/bin/zsh

# Init completion system and and load plugins in turbo mode
ZINIT[ZCOMPDUMP_PATH]="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
ZINIT[COMPINIT_OPTS]="-C"

zinit wait lucid for \
  atinit"zpcompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    Aloxaf/fzf-tab \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Completion for sdkman
zinit ice as"completion" wait lucid
zinit snippet OMZP::sdk

# Completion for fd
zinit ice as"completion" wait lucid
zinit snippet https://raw.githubusercontent.com/sharkdp/fd/refs/heads/master/contrib/completion/_fd

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Completion styling
zstyle ':completion:*' cache-path "${ZINIT[ZCOMPDUMP_PATH]}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Ignore case
zstyle ':completion:*' menu no                         # Disable default zsh completion menu - we're using fzf
zstyle ':fzf-tab:*' fzf-flags --color=marker:#bac2de,pointer:#bac2de
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
