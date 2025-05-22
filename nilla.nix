let
  pins = import ./npins;
  nilla = import pins.nilla;
in
  nilla.create({config}:  {
    includes = [
      "${pins.nilla-utils}/modules"
    ];
    config = {
      inputs = {
        nixpkgs.settings = {
          configuration.allowUnfree = true;
          overlays = [config.overlays.default];
        };
      };
      generators = {
        inputs.pins = pins;
        nixos = {
          folder = ./hosts;
          modules = [
            config.modules.nixos.default
          ];
        };
        overlays = {
          default.folder = ./packages;
        };
        packages = {
          folder = ./packages;
        };
        shells = {
          folder = ./shells;
        };
      };
      modules.nixos.default = ./modules/nixos;
    };
  })
