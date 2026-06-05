{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    xalaynix-wrappers.url = "github:alex-kumpula/xalaynix-wrappers";
    nix-jacket.url = "github:xalayn/nix-jacket";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
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
        ];
      };
    };
  };
}
