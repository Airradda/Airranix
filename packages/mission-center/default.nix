{
  fetchurl,
  appimageTools,
  makeDesktopItem,
  symlinkJoin,
}: let
  version = "1.0.0";

  src = fetchurl {
    url = "https://gitlab.com/mission-center-devs/mission-center/-/jobs/9906491703/artifacts/raw/MissionCenter_v${version}-x86_64.AppImage";
    sha256 = "sha256-aw3+orqr9+PjT6QKKIez7Ry8w1oO7NAn02UpVuDt3hI=";
  };

  # Extract the appimage first so we can get the icon inside
  # for the desktop item
  extracted = appimageTools.extract {
    inherit src version;
    pname = "mission-center";
  };

  # Wrap appimage
  wrapped = appimageTools.wrapAppImage {
    name = "mission-center";
    src = extracted;
    extraPkgs = pkgs: with pkgs; [libsodium fuse libxcrypt-legacy];
  };

  desktopItem = makeDesktopItem {
    name = "Mission-Center";
    desktopName = "Mission-Center";
    icon = "${extracted}/Mission-Center.png";
    comment = "Mission-Center";
    exec = "${wrapped}/usr/bin/mission-center";
    categories = ["System" "Monitor"];
  };
in
  symlinkJoin {
    name = "mission-center-${version}";
    paths = [
      wrapped
      desktopItem
    ];
  }
