# Dotfiles

This is a place for all things config.
From here I will be able run a script and set up my computer with everything I need.

To install, run the following command:

``` git clone https://github.com/MikaelWeiss/dotfiles.git && stow .```

## Nix

One flake in `nix/` covers every machine. `nix-config` opens
`nix/shared.nix`, the file for anything that should exist everywhere:
packages, and global npm packages under `npm.globalPackages`. Mac-only
things (homebrew) live in `nix/darwin/common.nix`, and one machine's
extras live in `nix/darwin/hosts/` or `nix/nixos/hosts/`. `nix-rebuild`
applies it.
