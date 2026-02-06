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
        pkgs.cornelis
        pkgs.just
        pkgs.entr
      ] ++ extraPackages;
    };
  };

  perSystem = { config, self', inputs', pkgs, system, ... }: {
    # Apply cornelis overlay to get the cornelis package
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.cornelis.overlays.cornelis ];
    };

    devShells.agda = inputs.self.lib.agda.mkShell { inherit pkgs; };
  };
}
