{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        installInstructions = ''
          mkdir -p $out/share/fonts/freetype
          cp $src/*/*.ttf $out/share/fonts/freetype
        '';
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "bahij-fonts-0.0.1";
          src = ./bahij;
          installPhase = installInstructions;
          meta = { description = "A Bahij Fonts Family derivation."; };
        };
      });
}
