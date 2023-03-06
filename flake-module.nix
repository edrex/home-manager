{ config, lib, flake-parts-lib, ... }:
let
  inherit (lib)
    mkOption
    types
    literalExpression
    ;
  inherit (flake-parts-lib)
    mkSubmoduleOptions
    ;
in
{
  options = {
    flake = mkSubmoduleOptions {
      homeConfigurations = mkOption {
        type = types.lazyAttrsOf types.raw;
        default = { };
        description = ''
          Instantiated Home-Manager configurations. Used by `home-manager` command.
          `homeConfigurations` is for specific machines. If you want to expose
          reusable configurations, add them to [`homeModules`](#opt-flake.homeModules)
          in the form of modules (no `lib.nixosSystem`), so that you can reference
          them in this or another flake's `homeConfigurations`.
        '';
        example = literalExpression ''
          {
            jane = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./home.nix ];
            };
          }
        '';
      };
    };
  };
}