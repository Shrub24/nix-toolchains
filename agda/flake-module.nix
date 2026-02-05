{ inputs, ... }: {
  flake.templates.agda = {
    path = ./template;
    description = "Standard Agda setup with Just and Cornelis";
  };

  flake.lib.agda = {
    mkShell = { pkgs, agda ? pkgs.agda, extraPackages ? [] }: pkgs.mkShell {
      name = "agda-shell";
      packages = [
        (agda.withPackages (p: [ p.standard-library ]))
        pkgs.haskellPackages.cornelis
        pkgs.just
        pkgs.entr
      ] ++ extraPackages;
    };
  };

  perSystem = { config, self', inputs', pkgs, system, ... }: {
    devShells.agda = inputs.self.lib.agda.mkShell { inherit pkgs; };
  };
}
