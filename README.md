# MVE510 Flake

Nix flake for the course MVE510 Introduction to bioinformatics.

Includes [R](https://www.r-project.org) and [RStudio](https://posit.co/products/open-source/rstudio).

## Installation

1. Add the flake input to your `flake.nix`:

    ```nix
    {
      inputs.mve510 = {
        url = "github:LinuxAtChalmers/mve510-flake";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    }
    ```

2. Import the system module in `configuration.nix` which will install the packages:

    ```nix
    {inputs, ... }: {
      imports = [
        inputs.mve510.nixosModules.default
      ];
    }
    ```

> [!NOTE]
> This requires that you pass in `inputs` through `specialArgs`.

3. Rebuild your system.
