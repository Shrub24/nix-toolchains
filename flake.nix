{
  description = "Development Toolchains Monorepo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    
    # Upstream Agda repository for fetching standard .gitignore
    agda-upstream = {
      url = "github:agda/agda";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      imports = [
        ./agda/flake-module.nix
      ];
    };
}
