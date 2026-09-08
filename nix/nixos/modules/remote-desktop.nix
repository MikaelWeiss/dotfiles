# Stream the niri desktop to Moonlight clients. No monitor is attached, so
# vkms provides the display; niri's config sets its mode to match the client.
{ config, pkgs, inputs, ... }:

{
  boot.kernelModules = [ "vkms" ];

  # Sunshine on the stable channel crashes on connect (nixpkgs#475181).
  nixpkgs.overlays = [
    (final: prev: {
      sunshine = inputs.nixpkgs.legacyPackages.${prev.stdenv.hostPlatform.system}.sunshine;
    })
  ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    settings = {
      capture = "wlr";
      encoder = "vaapi";
    };
  };

  hardware.uinput.enable = true;
  users.users.mikaelweiss.extraGroups = [ "uinput" ];
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
}
