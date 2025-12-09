#!/usr/bin/zsh

export SDKMAN_DIR="${XDG_BIN_HOME:-$HOME/.sdkman}/sdkman"

if [[ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
  curl -s "https://get.sdkman.io" | bash

  # Disable completions - these are handled by zinit/complete.zsh
  sed -i '' 's/^sdkman_auto_complete=.*/sdkman_auto_complete=false/' "$SDKMAN_DIR/etc/config"
fi

source "$SDKMAN_DIR/bin/sdkman-init.sh"
