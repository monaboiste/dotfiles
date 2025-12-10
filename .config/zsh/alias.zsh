#!/usr/bin/zsh

# NOTE: use `type <alias>` to see what is assigned to an alias/fn/builtin/keyword
#       the use of `type` doesn't always work in Zsh so use `whence -c` instead
#       alternatively use the `list` alias to show all defined alias' from this file
#       the `alias` function itself with no arguments will actually print all too
#

alias python3=/opt/homebrew/bin/python3.14
alias ls='eza'
alias ll='eza -lg --icons'
alias la='eza -lag --icons'
alias lt='eza -lgT --icons'
alias lt1='eza -gT --icons --level=1'
alias lt2='eza -gT --icons --level=2'
alias lt3='eza -gT --icons --level=3'
alias lta='eza -agT --icons'
alias lta1='eza -agT --icons --level=1'
alias lta2='eza -agT --icons --level=2'
alias lta3='eza -agT --icons --level=3'
alias idea='open -n -g -a "IntelliJ IDEA.app" --args'

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# Helpers
zinit::update() {
  echo "🔄 Updating Zinit and plugins..."
  zinit self-update && zinit update --all
  echo "✅ All Zinit plugins updated!"
}

alias help::vim_tips='echo "$(cat <<-'EOF'
x Last line edit: G
x Multiline edit:
  - ctrl+v (visual mode)
  - select, c to delete, type your word (only first line will be visible)
  - double press esc
x Jump:
  - by a paragraph: shift+[ or shift+]
  - to the next parenthesis: %
  - to char: f
EOF
)"'

alias help::yazi_tips='echo "$(cat <<-'EOF'
x Search:
  - Search in current directory: /
  - Fuzzy find: Z
  - Filter files: f
  - Search for files: s
  - Search content: S
x Navigation:
  - Base navigating: g (e.g. gh or gc)
  - New Tab: t
  - Move between tabs: [ or ] or <N>
  - Close tab: <ctrl>+c
x Display:
  - Sort files: ,
  - Show directory size: ,s
  - Show meta: <tab>
  - Show hidden: .
  - Show tasks: w
x Actions:
  - Yank file: y
  - Cut file: x
  - Rename file: r
  - Copy filename/path/directory: c
  - Multiselect (Bulk edit): <space>
  - Select (tmux): enter copy mode - <prefix>+[
EOF
)"'

alias help::keychain='echo "$(cat <<-'\''EOF'\''
x Add secret: security add-generic-password -a $USER -s "MY_SECRET" -w "supersecret"
x Retrieve secret: export SECRET_KEY=$(security find-generic-password -s "MY_SECRET" -w)
EOF
)"'

alias help::zsh_perf='echo "$(cat <<-'\''EOF'\''
zmodload zsh/zprof
#... .zshrc
zprof
EOF
)"'

theme::toggle() {
  local config="$XDG_CONFIG_HOME"/alacritty/alacritty.toml
  local light_theme="theme-light"
  local dark_theme="theme-dark"

  # TODO: tmux:
  # source-file /home/go/.config/tmux/catppuccin-mocha.conf;
  # tmux source-file ~.config/tmux/tmux.conf
  # AND: yazi:

  if grep -q "$dark_theme" "$config"; then
    sed -i '' "s|$dark_theme|$light_theme|" "$config"
  elif grep -q "$light_theme" "$config"; then
    sed -i '' "s|$light_theme|$dark_theme|" "$config"
  else
    echo "No known theme found in $config"
    return 1
  fi
}
