{
  fetchurl,
  appimageTools,
  makeDesktopItem,
  symlinkJoin,
}: let
  version = "1.0.0";

  src = fetchurl {
    url = "https://gitlab.com/mission-center-devs/mission-center/-/jobs/9906491703/artifacts/raw/MissionCenter_v${version}-x86_64.AppImage";
    sha256 = "sha256-L2N3saNeJDdji/IzC2Zi0Iixc/pPNSUpz07egywx+4U=";
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
    # extraPkgs = pkgs: with pkgs; [libsodium fuse];
  };

  desktopItem = makeDesktopItem {
    name = "Mission-Center";
    desktopName = "Mission-Center";
    icon = "${extracted}/Mission-Center.png";
    comment = "Mission-Center";
    exec = "${wrapped}/bin/mission-center";
    categories = ["Task Manager"];
  };
in
  symlinkJoin {
    name = "mission-center-${version}";
    paths = [
      wrapped
      desktopItem
    ];
  }
