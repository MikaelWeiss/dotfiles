# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let
unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in {
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "America/Denver";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mikaelweiss = {
    isNormalUser = true;
    description = "Mikael Weiss";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  security.sudo.wheelNeedsPassword = false;

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
# vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
# wget
    gcc
      neovim
      git
      oh-my-zsh
      unstable.tailscale
      lazygit
      zoxide
      zsh-powerlevel10k
      meslo-lgs-nf
      fzf
      btop
      yazi
      restic
      ghostty
      elixir 
      erlang
      postgresql
      ripgrep
      tree-sitter
      elixir-ls
      vscode-langservers-extracted
      unzip
      ];

  environment.variables = {
    TERM = "xterm-256color";
    EDITOR = "nvim";
  };

  programs = {
    nano.enable = false;
    neovim.enable = true;
  };

  programs.zsh = {
    enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "rsync" "systemd" ];
    };
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        email = "campingmikael@icloud.com";
        name = "Mikael Weiss";
      };
    };
  };

  programs.neovim = {
    configure = {
      packages.all.start = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  services.postgresql = {
    enable = true;
  };

  services.tailscale.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
    system.autoUpgrade = {
      enable = true;
      dates = "daily";
      allowReboot = true;
    };

}
