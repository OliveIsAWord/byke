# With help from https://jordankaye.dev/posts/rust-wasm-nix
{
  description = "An interactive character sheet for Kids on Bikes";

  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    fenix,
    nixpkgs,
  }: let
    supportedSystems = nixpkgs.lib.systems.flakeExposed;
    allSystems = output:
      nixpkgs.lib.genAttrs supportedSystems
      (system: output nixpkgs.legacyPackages.${system});
  in {
    packages = allSystems (pkgs: {
      default = pkgs.rustPlatform.buildRustPackage {
        pname = "Byke";
        version = "0.1.0";
        src = self;
        cargoLock.lockFile = ./Cargo.lock;
      };
    });

    devShells = allSystems (pkgs: let
      f = with fenix.packages.${pkgs.system};
        combine [
          stable.toolchain
          targets.wasm32-unknown-unknown.stable.rust-std
        ];
    in {
      default = pkgs.mkShell {
        inherit
          (self.outputs.packages.${pkgs.system}.default)
          nativeBuildInputs
          buildInputs
          ;
        packages = with pkgs; [
          f
          trunk
          leptosfmt
          llvmPackages.bintools # lld
        ];
        RUST_BACKTRACE = 1;
        CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld";
      };
    });

    formatter = allSystems (pkgs: pkgs.alejandra);
  };
}
