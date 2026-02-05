{ inputs, ... }: {
  flake.templates.agda = {
    path = let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      upstreamGitignore = "${inputs.agda-upstream}/.gitignore";
    in pkgs.runCommand "agda-template" {} ''
      mkdir -p $out
      cp -r ${./template}/* $out/
      
      # Append our custom ignores to the upstream gitignore
      cat ${upstreamGitignore} > $out/.gitignore
      echo "" >> $out/.gitignore
      echo "# Toolchain specific ignores" >> $out/.gitignore
      echo ".direnv/" >> $out/.gitignore
      echo "result" >> $out/.gitignore
    '';
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
