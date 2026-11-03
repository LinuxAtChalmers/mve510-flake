{
  description = "Flake for MVE510 Introduction to bioinformatics";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosModules.default = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        R
        rstudio
      ];
    };
  };
}
