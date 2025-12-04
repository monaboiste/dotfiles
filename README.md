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

