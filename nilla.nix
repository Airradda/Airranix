let
  pins = import ./npins;
  nilla = import pins.nilla;
in
  nilla.create({config}:
  {
    includes = [
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
