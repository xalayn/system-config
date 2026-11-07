{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Hyprland (0.57.1) comes from this pinned nixpkgs-unstable revision, so it
    # only changes when bumped on purpose: the ScrollOverview plugin built by
    # home-config must match it exactly and may need updating for a new
    # Hyprland. Keep this in sync with home-config/flake.nix.
    nixpkgs-hyprland.url = "github:nixos/nixpkgs/1d060086d60cb76a40cf37109f979d88a5bd6396";

    xalaynix-wrappers.url = "github:alex-kumpula/xalaynix-wrappers";
    nix-jacket.url = "git+https://github.com/xalayn/nix-jacket.git?ref=main";
    nix-parcels.url = "git+https://github.com/xalayn/nix-parcels.git?ref=enter-escape";

    driftwm.url = "github:malbiruk/driftwm";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    driftwm,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    mySpecialArgs = {
      inherit inputs outputs;
      # To use packages from nixpkgs-unstable,
      # we configure some parameters for it first
      #pkgs-stable = import nixpkgs-stable {
      # Refer to the `system` parameter from
      # the outer scope recursively
      #  inherit inputs;
      #  system = "x86_64-linux";
      #  config.allowUnfree = true;
      #};

      #pkgs-last-stable = import nixpkgs-last-stable {
      # Refer to the `system` parameter from
      # the outer scope recursively
      #  inherit inputs;
      #  system = "x86_64-linux";
      #  config.allowUnfree = true;
      #};

      pkgs-unstable = import nixpkgs-unstable {
        # Refer to the `system` parameter from
        # the outer scope recursively
        inherit inputs;
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      pkgs-hyprland = import inputs.nixpkgs-hyprland {
        system = "x86_64-linux";
      };

      #pkgs-pinned = import nixpkgs-pinned {
      #  inherit inputs;
      #  system = "x86_64-linux";
      #  config.allowUnfree = true;
      #};
    };
  in {
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME - DONE replace with your hostname
      vm-test-host = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/vm-test-host/configuration.nix
        ];
      };
      vm-test-host-efi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/vm-test-host-efi/configuration.nix
        ];
      };
      alex-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = mySpecialArgs;
        modules = [
          # > Our main nixos configuration file <
          ./hosts/alex-laptop/configuration.nix
          driftwm.nixosModules.default
        ];
      };
    };
  };
}
