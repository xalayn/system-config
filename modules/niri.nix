{ inputs, pkgs, ... }:
{
  programs.niri.enable = true;

  # For wrapper niri
  services.displayManager.sessionPackages = [ 
    inputs.xalaynix-wrappers.packages.${pkgs.system}.niri-noctalia
    # inputs.nix-jacket.packages.${pkgs.system}.niri-noctalia-container
  ];
  systemd.packages = [ inputs.xalaynix-wrappers.packages.${pkgs.system}.niri-noctalia ];

  imports = [ inputs.nix-jacket.nixosModules.niri-noctalia ];
}