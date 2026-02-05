{ inputs, ... }: {
  flake.templates.agda = {
    path = ./template;
    description = "Standard Agda setup with Just and Cornelis";
  };

  perSystem = { config, self', inputs', pkgs, system, ... }: {
    devShells.agda = pkgs.mkShell {
      name = "agda-shell";
      packages = [
        (pkgs.agda.withPackages (p: [ p.standard-library ]))
        pkgs.haskellPackages.cornelis
        pkgs.just
        pkgs.entr
      ];
    };
  };
}
