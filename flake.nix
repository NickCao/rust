{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; }; in
        with pkgs; rec{
          devShell = mkShell {
            nativeBuildInputs = [ python3 cmake ninja ];
            NIX_LDFLAGS = [ "-L${glibc}/lib" "-L${glibc.static}/lib" ];
          };
        });
}
