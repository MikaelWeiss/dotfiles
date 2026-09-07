{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python311
  ];

  # Clawdbot runs from these (see ~/Library/LaunchAgents/com.clawdbot.gateway.plist).
  npm.globalPackages = [
    "clawdbot"
    "clawdhub"
    "@askelephant/firebase-tools"
  ];

  programs.zsh.interactiveShellInit = ''
    # LM Studio CLI
    export PATH="$PATH:/Users/mikaelweiss/.lmstudio/bin"

    # Clawd Bot Stuff
    export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
    export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
  '';

  homebrew.brews = [
    "tailscale"
  ];
}
