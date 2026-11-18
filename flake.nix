{
  description = "Flake for MVE510 Introduction to bioinformatics";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in rec {
      libgtextutils = pkgs.callPackage ./packages/libgtextutils.nix {};
      fastx-toolkit = pkgs.callPackage ./packages/fastx-toolkit.nix {inherit libgtextutils;};
    });

    nixosModules.default = {pkgs, ...}: {
      environment.systemPackages = with pkgs; let
        packages = with rPackages; [
          MASS
        ];
      in [
        (rWrapper.override {
          inherit packages;
        })
        (rstudioWrapper.override {
          inherit packages;
        })
        fastqc
        self.packages.${pkgs.stdenv.hostPlatform.system}.fastx-toolkit
        bwa
        samtools
        igv
      ];
    };
  };
}
