{
  description = "Agda project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-toolchains.url = "github:Shrub24/nix-toolchains";
  };

  outputs = { self, nixpkgs, nix-toolchains }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = nix-toolchains.lib.agda.mkShell { inherit pkgs; };
        });
    };
}
