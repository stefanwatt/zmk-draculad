{
  description = "ZMK firmware environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      zmkFlake = import ./zmk-flake.nix;
      zmkOutputs = zmkFlake.outputs { inherit self nixpkgs; };
    in {
      devShells.x86_64-linux = {
        default = zmkOutputs.lib.devShell { system = "x86_64-linux"; };
      };

      # Optional: Also include the build function
      packages.x86_64-linux = {
        default = zmkOutputs.lib.firmwarePackage {
          system = "x86_64-linux";
          board = "nice_nano_v2"; # Adjust this for your board
          shields = [
            "skeletyl_left"
            "skeletyl_right"
            "skeletyl_dongle"
          ]; # Adjust these for your keyboard
          config = ./config; # Path to your ZMK config directory
        };
      };
    };
}
