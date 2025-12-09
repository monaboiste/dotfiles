#!/usr/bin/zsh

export FNM_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}/fnm"

eval "$(fnm env --use-on-cd)"

local node_versions=("$FNM_DIR"/node-versions/*(N))
if (( ${#node_versions} == 0 )); then
  echo "No Node.js versions found. Installing latest LTS..."
  fnm install --lts
fi
