let
  pins = import ./npins;
  nilla = import pins.nilla;
in
  nilla.create({config}:
  {
    includes = [
      ./modules/Settings.nix
    ];
    config = {
      inputs = {
        nilla-cli = {
          src = pins.nilla-cli;
        };
        nixpkgs = {
          src = pins.nixpkgs;
          settings = {
            configuration.allowUnfree = true;
            overlays = [];
          };
        };
      };
    };
  })
