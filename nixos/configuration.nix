# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "charmander"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Boise";

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
    shell = pkgs.zsh;
  };

  # Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   wget
   neovim
   gcc # Dependancy of LazyVim
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
   ripgrep
   unzip #Neovim dependancy
   claude-code
   tmux # Split screen and windows in the terminal
   tldr # Run tldr tmux to see the tldr for the tmux docs
   # Hyprland tools
   hyprland
   wofi
   waybar
   hyprpaper
   # Apps
   ghostty
   signal-desktop
   tailscale
   cockpit
   # Display manager
   sddm-astronaut
   # Websites
   elixir
   erlang
   postgresql
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable nix-ld to run generic Linux binaries
  # Needed for mix assets.deploy
  programs.nix-ld.enable = true;

  programs.git = {
    enable = true;
    config = {
      user = {
        email = "campingmikael@icloud.com";
        name = "Mikael Weiss";
      };
    };
  };

  programs.zsh = {
    enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "rsync" "systemd" ];
    };
  };

  programs.hyprland.enable = true;

  # Make it so that if you make new users, they default to zsh
  users.defaultUserShell = pkgs.zsh;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Cockpit
  services.cockpit = {
    enable = true;
    port = 9090;
    openFirewall = true;
    settings = {
      WebService = {
        AllowUnencrypted = true;
        Origins = lib.mkForce "https://localhost:9090 http://localhost:9090 https://elm:9090 http://elm:9090 https://100.81.131.90:9090 http://100.81.131.90:9090";
      };
    };
  };

  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
  };

  # Set up tailscale
  services.tailscale.enable = true;
  
  # Trust tailscale interface
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 4000 ];
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

  ## Website Service Configurations
  users.users.striveplanner = {
    isSystemUser = true;
    group = "striveplanner";
    home = "/var/lib/striveplanner";
    createHome = true;
    shell = pkgs.zsh;
  };
  users.groups.striveplanner = {};

  systemd.services.striveplanner = {
    description = "Website for Strive Planner";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "striveplanner";
      Group = "striveplanner";
      WorkingDirectory = "/var/lib/striveplanner";
      ExecStart = "/var/lib/striveplanner/_build/prod/rel/strive_planner/bin/strive_planner start";
      EnvironmentFile = "/etc/striveplanner/env";
      Restart = "on-failure";
    };
  };


  services.cloudflared = {
    enable = true;
    tunnels."YOUR-TUNNEL-ID" = {
      credentialsFile = "/var/lib/cloudflared/YOUR-TUNNEL-ID.json";
      ingress."striveplanner.org" = "http://localhost:4000";
      default = "http_status:404";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "striveplanner" ];
    ensureUsers = [{
      name = "striveplanner";
      ensureDBOwnership = true;
    }];
  };
}
