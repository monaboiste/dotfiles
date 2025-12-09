# Dotfiles

My dotfiles configurations managed by stow.

Install:

```sh
brew install stow
```

Symlink to parent directory:

```sh
stow .
```

Include git settings in `~/.config/git/config`:

```ini
[include]
  path = settings
```

Sample `.ssh/config`:

```ini
Include config.d/*.conf

Host github.com
  AddKeysToAgent yes
  IdentitiesOnly yes
  IdentityFile ~/.ssh/id_rsa

Host github.com:<USERNAME>
  Host github.com
  AddKeysToAgent yes
  IdentitiesOnly yes
  IdentityFile ~/.ssh/id_ed25519_<USERNAME>
```
Setup themes:
```sh
ya pkg add yazi-rs/flavors:catppuccin-macchiato
fast-theme XDG:catppuccin-mocha
```
