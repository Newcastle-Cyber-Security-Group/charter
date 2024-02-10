{
  description = "NixOS/Darwin configurations";

  inputs = {
    flake-compat = {
      flake = false;
      url = "github:edolstra/flake-compat";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    pre-commit-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/pre-commit-hooks.nix";
    };
  };

  outputs = { self, flake-utils, nixpkgs, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # The below packages are included in the ephemeral shell 
        # for convenience of the user.
        packages = with pkgs; [
          deadnix
          nil
          nixfmt
          nodePackages.prettier
          statix
          typos
        ];
      in {
        # Pre-commit hooks to enforce formatting, lining, find 
        # antipatterns and ensure they don't reach upstream
        checks.pre-commit = pre-commit-hooks.lib.${system}.run {
          src = self;
          hooks = {
            # Builtin hooks
            actionlint.enable = true;
            deadnix.enable = true;
            nixfmt.enable = true;
            prettier.enable = true;
            statix.enable = true;
            typos.enable = true;

            # Custom hooks
            statix-write = {
              enable = true;
              entry = "${pkgs.statix}/bin/statix fix";
              files = "\\.nix$";
              language = "system";
              name = "Statix Write";
              pass_filenames = false;
            };
          };

          # Settings for builtin hooks, see also: https://github.com/cachix/pre-commit-hooks.nix/blob/master/modules/hooks.nix
          settings = {
            deadnix.edit = true;
            nixfmt.width = 80;
            prettier.write = true;
            typos.locale = "en-au";
          };
        };

        # Shell environments (applied to both nix develop and nix-shell via
        # shell.nix in top level directory)
        devShells.default = pkgs.mkShell {
          name = "development-shell";
          inherit packages;
          inherit (self.checks.${system}.pre-commit) shellHook;
        };
      });
}
