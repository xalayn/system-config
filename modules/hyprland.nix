{ pkgs-hyprland, ... }:
{
  # Installs Hyprland, adds its session to the display manager,
  # and sets up xdg-desktop-portal-hyprland + XWayland.
  programs.hyprland = {
    enable = true;
    # Pinned to 0.56.2 (see nixpkgs-hyprland in flake.nix) so the Phantomat
    # plugin built by home-config matches it exactly.
    package = pkgs-hyprland.hyprland;
    portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
  };
}
