{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
        vim # Vim
        yazi # File browser
        tmux # Terminal window/session manager
        flyctl # CLI for Fly.io
        fzf # Fuzy find files
        gh # GitHub CLI
        imagemagick # Not sure
        lazygit # Git, but Lazy
        neovim # Vim, but epic
        nushell # Cool concept
        pandoc # Change files to other file types
        pyenv # Py environment manager
        restic # Backup manager
        ripgrep # Better grep
        rustup # For Rust
        tldr # Read docs faster
        cloudflared # Cloudflare daemon
        cmake # Build system generator
        cocoapods # Manage dependancies for your Xcode projects
        dust # Du, but better
        ffmpeg
        nodejs_20
        javaPackages.compiler.openjdk21 # Java
        javaPackages.compiler.openjdk17 # Java
        swiftformat # Swift formatter
        swiftlint # Swift linter
        tree # See the directories
        wget # wget files from http, https, and ftp
        xcbeautify # Beautifier tool for Xcode
        xcodegen # Swift CLI for generating Xcode projects
        zoxide # Better cd
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Mikaels-MacBook-Air
    darwinConfigurations."Mikaels-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
