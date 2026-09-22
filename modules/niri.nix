{ inputs, lib, pkgs, ... }:
let
  niriNoctaliaParcel = (
    (inputs.nix-parcels.plib.mkParcel [
      inputs.nix-parcels.parcels.niri-noctalia
      {
        name = "niri-noctalia-parcel";
        session = {
          sessionName = "niri-noctalia-parcel";
          displayName = lib.mkForce "niri-noctalia-parcel";
        };
      }
    ]).extend { inherit pkgs; }
  ).package;
in
{
  programs.niri = {
    enable = true;
  };

  # For wrapper niri
  services.displayManager.sessionPackages = [
    inputs.xalaynix-wrappers.packages.${pkgs.system}.niri-noctalia
    niriNoctaliaParcel
    # inputs.nix-jacket.packages.${pkgs.system}.niri-noctalia-container
  ];
  systemd.packages = [
    inputs.xalaynix-wrappers.packages.${pkgs.system}.niri-noctalia
    niriNoctaliaParcel
  ];

  imports = [ inputs.nix-jacket.nixosModules.niri-noctalia ];
}
