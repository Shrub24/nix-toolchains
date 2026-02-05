{
  description = "Agda project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-toolchains.url = "github:Shrub24/nix-toolchains";
  };

  outputs = { self, nixpkgs, nix-toolchains }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = nix-toolchains.lib.agda.mkShell { inherit pkgs; };
        });
    };
}
