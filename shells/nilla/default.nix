{config}: {
      config.shells.default = {
          systems = [ "x86_64-linux" ];
          shell = { mkShell, pkgs }:
            mkShell {
              packages = with pkgs; [
                npins
                config.inputs.nilla-cli.result.packages.nilla-cli.result.x86_64-linux
              ];
            };
          settings = {
            pkgs = config.inputs.nixpkgs.result;
          };
        };
}
