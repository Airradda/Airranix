let
  pins = import ./npins;
  nilla = import pins.nilla;
in
  nilla.create({config}:
  {
    includes = [
      "${pins.nilla-nixos}/modules/nixos.nix"
    ];
    config = {
      inputs = config.lib.attrs.mergeRecursive {
        nixpkgs = {
          src = pins.nixpkgs;
          settings = {
            configuration.allowUnfree = true;
            overlays = [];
          };
        };
      } (builtins.mapAttrs (name: value: { src = value; }) pins);
    };
  })
