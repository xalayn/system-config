{ inputs, pkgs, ... }:
{
  programs.niri.enable = true;

  # For wrapper niri
  services.displayManager.sessionPackages = [ inputs.xalaynix-wrappers.packages.${pkgs.system}.niri-noctalia ];
  systemd.packages = [ inputs.xalaynix-wrappers.packages.${pkgs.system}.niri-noctalia ];
}