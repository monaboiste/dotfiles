#!/usr/bin/zsh

# SDKMAN
#
export SDKMAN_DIR="${XDG_BIN_HOME:-$HOME/.sdkman}/sdkman"
if [[ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
  curl -s "https://get.sdkman.io" | bash
fi
source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Node
#
export NVM_DIR="${XDG_BIN_HOME:-$HOME/.nvm}/nvm"
source $(brew --prefix nvm)/nvm.sh

if ! (( $+commands[npm] )); then
  echo "Installing latest Node.js LTS via nvm..."
  nvm install --lts >/dev/null
fi
