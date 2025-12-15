# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:


{
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
    linger = true; # Auto-start before login
      autoSubUidGidRange = true; # For rootless containers
  };

  security.sudo.wheelNeedsPassword = false;

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Podman Quadlets
  virtualisation.quadlet.enable = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
# vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
# wget
    gcc
      neovim
      vim
      git
      oh-my-zsh # Better zsh
      lazygit # Better git
      zoxide # Better cd
      zsh-powerlevel10k # ZSH theme
      meslo-lgs-nf # Nerd font
      fzf # Fuzy find files
      btop # Visualization of hardware status
      yazi # File browser
      restic # Backup software
      ghostty
      elixir
      erlang
      postgresql
      ripgrep
      tree-sitter
      elixir-ls
      vscode-langservers-extracted # For Neovim LS support
      unzip #Neovim dependancy
      claude-code
      tmux # Split screen and windows in the terminal
      tldr # Run tldr tmux to see the tldr for the tmux docs
      # Hyprland tools
      hyprland
      wofi
      waybar
      hyprpaper
      sddm-astronaut # Themes packages
      # Apps
      signal-desktop
      ] ++ (with pkgs-unstable; [
        # Unstable packages
        tailscale
      ]);

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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.postgresql = {
    enable = true;
  };

  services.tailscale.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";

    settings.Theme = {
      Current = "sddm-astronaut-theme";
      ThemeVariant = "black_hole";
    };

    package = pkgs.kdePackages.sddm.override {
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtsvg
        qtvirtualkeyboard
      ];
    };
  };

# Enable Samba
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        workgroup = "SAMBA";
        security = "user";
        "server min protocol" = "SMB3";
        "smb encrypt" = "required";
        "hosts allow" = "192.168.0.0/24, 100.64.0.0/10 EXCEPT 192.168.0.103, 100.105.253.35";
        "hosts deny" = "ALL";
        "load printers" = "no";
        "printing" = "bsd";
        "printcap name" = "/dev/null";
        "disable spoolss" = "yes";
      };

      share = {
        path = "/home/mikaelweiss/share";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "mikaelweiss";
        "create mask" = "0644";
        "directory mask" = "0755";
        comment = "My Share";
      };
    };
  };

# Tailscale in trusted zone
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

# Minecraft server container
  virtualisation.quadlet.containers.minecraft-server = {
    autoStart = true;

    containerConfig = {
      image = "docker.io/itzg/minecraft-server:latest";
      publishPorts = [ "25565:25565" ];
      volumes = [ "/home/mikaelweiss/.minecraft-server/data:/data" ];
      environments = {
        EULA = "TRUE";
        TYPE = "FABRIC";
        MEMORY = "2G";
        VERSION = "1.21.10";
        UID = "1000";
        GID = "1000";
        REMOVE_OLD_MODS = "FALSE";
      };
      securityLabelDisable = true;
    };

    serviceConfig = {
      Restart = "always";
    };

    unitConfig = {
      After = "network-online.target";
      Wants = "network-online.target";
    };
  };

# Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 25565 ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
    system.autoUpgrade = {
      enable = true;
      dates = "daily";
      allowReboot = true;
    };

}
