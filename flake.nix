{
  description = "Flake for racket development";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs"; };
  outputs = { self, nixpkgs } :
    let racketDevPkgs = pkgs : 
      pkgs.mkShell {
        buildInputs = 
          with pkgs;
            [ racket ];

        shellHook = ''
          raco pkg install --auto racket-langserver
        '';
      };
    in {
      devShell.x86_64-linux = racketDevPkgs nixpkgs.legacyPackages.x86_64-linux;
      devShell.x86_64-darwin = racketDevPkgs nixpkgs.legacyPackages.x86_64-darwin;
    };
}
