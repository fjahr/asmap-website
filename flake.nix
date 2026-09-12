{
  description = "ASmap website flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
  };

  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    rubypkgs = with pkgs.rubyPackages; [ webrick ];
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [ pkgs.ruby pkgs.jekyll pkgs.openssl pkgs.pkg-config ] ++ rubypkgs;
    };
  };
}
