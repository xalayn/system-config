# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;

  gnome = import ./gnome.nix;
  niri = import ./niri.nix;
  alacritty = import ./alacritty.nix;
  git = import ./git.nix;
  gdm = import ./gdm.nix;
  xwayland-satellite = import ./xwayland-satellite.nix;
  nix-ld = import ./nix-ld.nix;
  steam = import ./steam.nix;
  blueberry = import ./blueberry.nix;
  wl-mirror = import ./wl-mirror.nix;
  evremap = import ./evremap.nix;
  qbittorrent = import ./qbittorrent.nix;
  virtualbox = import ./virtualbox.nix;
  cuda = import ./cuda.nix;
  ssh-agent = import ./ssh-agent.nix;
  sshfs = import ./sshfs.nix;
  virt-manager = import ./virt-manager.nix;
  flatpak = import ./flatpak.nix;
  winboat = import ./winboat.nix;
  xfce = import ./xfce.nix;
  driftwm = import ./driftwm.nix;
  hyprland = import ./hyprland.nix;
}
