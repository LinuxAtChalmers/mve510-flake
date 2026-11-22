{
  description = "Flake for MVE510 Introduction to bioinformatics";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
  }: let
    inherit (nixpkgs) lib;
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      pkgs-unstable = import nixpkgs-unstable {inherit system;};
    in rec {
      libgtextutils = pkgs.callPackage ./packages/libgtextutils.nix {};
      fastx-toolkit = pkgs.callPackage ./packages/fastx-toolkit.nix {inherit libgtextutils;};
    });

    nixosModules.default = {pkgs, ...}: {
      environment.systemPackages = with pkgs; let
        packages = with pkgs-unstable.rPackages; [
          MASS
        ];
      in [
        (pkgs-unstable.rWrapper.override {
          inherit packages;
        })
        (pkgs-unstable.rstudioWrapper.override {
          inherit packages;
          rstudio = pkgs-unstable.rstudio;
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
