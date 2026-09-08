{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python311
  ];

  programs.zsh.interactiveShellInit = ''
    # LM Studio CLI
    export PATH="$PATH:/Users/mikaelweiss/.lmstudio/bin"
  '';

  homebrew.brews = [
    "tailscale"
  ];
}
