{ config, pkgs, lib, ... }:
let
  cfg = config.Settings;
in
{
  options.Settings = with lib; {
    enable = mkEnableOption "Settings module.";
    DeviceType = mkOption {
      description = "Set the device type. This will change the size and position of windows to better fit the screen real estate.";
      type = types.enum [ "Desktop" "Laptop" ];
    };
    DefaultBrowser = mkPackageOption pkgs "vivaldi" {}; 
    DefaultEditor = mkPackageOption pkgs "helix" {}; 
    DefaultImageViewer = mkPackageOption pkgs "oculante" {}; 
    DefaultMediaPlayer = mkPackageOption pkgs "oculante" {}; 
    DefaultPDFViewer = mkPackageOption pkgs "sioyek" {}; 
    DefaultResourceMonitor = mkPackageOption pkgs "btop" {}; 
    DefaultTerminal = mkPackageOption pkgs "ghostty" {}; 
    Font = {
      Size = mkOption {
        description = "Set the default font size";
        default = 11;
        type = types.int;
      }; 
      FloatSize = mkOption {
        description = "Set the default font float size";
        default = 11.0;
        type = types.float;
      }; 
    };
    Keybinds = {
      AltKey = mkOption  {
        description = "Set the KeySym of the Alt key";
        default = "Mod1";
        type = types.str;
      };
      MainMod = mkOption  {
        description = "Set the main modifier key";
        default = "SUPER";
        type = types.str;
      };
      ModKey = mkOption  {
        description = "Set the KeySym of the Mod key";
        default = "Mod4";
        type = types.str;
      };
    };
    Theme = {
      Cursor = {
        Name = mkOption  {
          description = "Set the Cursor name";
          default = "mochaRed";
          type = types.str;
        };
        Package = mkPackageOption pkgs "catppuccin-cursors" {};
        Size = mkOption  {
          description = "Set the Cursor size";
          default = 32;
          type = types.int;
        };
      };
    };
    WindowSize = {
      PercentWidth = mkOption {
        description = "Set PercentWidth window size";
        default = if cfg.DeviceType == "Laptop" then "90" else "50";
        type = types.str;
      };
      PercentSize = mkOption {
        description = "Set PercentSize window size";
        default = "${cfg.WindowSize.PercentWidth}% 90%";
        type = types.str;
      };
      Sidebar = mkOption {
        description = "Set Sidebar window size";
        default = "25% 100%";
        type = types.str;
      };
      MainWindow = mkOption {
        description = "Set MainWindow window size";
        default = if cfg.DeviceType == "Laptop" then "90% 90%" else "50% 100%";
        type = types.str;
      };
      SmallWindow = mkOption {
        description = "Set SmallWindow window size";
        default = if cfg.DeviceType == "Laptop" then "33% 28%" else "25% 50%";
        type = types.str;
      };
    };
    WindowPosition = {
      TopLeft = mkOption {
        description = "Set TopLeft window position";
        default = if cfg.DeviceType == "Laptop" then "67% 0%" else "75% 0%";
        type = types.str;
      };
      TopRight = mkOption {
        description = "Set TopRight window position";
        default = if cfg.DeviceType == "Laptop" then "0% 67%" else "0% 50%";
        type = types.str;
      };
      BottomLeft = mkOption {
        description = "Set BottomLeft window position";
        default = if cfg.DeviceType == "Laptop" then "67% 72%" else "75% 50%";
        type = types.str;
      };
      BottomRight = mkOption {
        description = "Set BottomRight window position";
        default = if cfg.DeviceType == "Laptop" then "67% 72%" else "75% 50%";
        type = types.str;
      };
      LeftSide = mkOption {
        description = "Set LeftSide window position";
        default = "0% 5%";
        type = types.str;
      };
    };
    Wallpaper = mkOption  {
      description = "Set the wallpaper";
      default = "/home/airradda/Sync/System/Flake/ConfigFiles/Wallpapers/blobgirl-black.png";
      type = types.str;
    };
  };
  config = {
    assertions = [
      {
        assertion = cfg.DeviceType != null;
        message = "Settings.DeviceType must be set";
      }
    ];
    xdg.mime = {
      defaultApplications = {
        "application/json" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "application/pdf" = [ "${lib.toSentenceCase cfg.DefaultPDFViewer.pname}.desktop" ];
        "application/epub+zip" = [ "${lib.toSentenceCase cfg.DefaultPDFViewer.pname}.desktop" ];
        "application/rdf+xml" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/rss+xml" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/xhtml+xml" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/xhtml_xml" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/xml" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/x-wine-extension-ini" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "image/gif" = [ "${lib.toSentenceCase cfg.DefaultMediaPlayer.pname}.desktop" ];
        "image/jpeg" = [ "${lib.toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/png" = [ "${lib.toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/svg+xml" = [ "${lib.toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/webp" = [ "${lib.toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/jxl" = [ "${lib.toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "text/css"  =  [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/html" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "text/markdown" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/plain" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/xml" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/x-opml+xml" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/x-python" = [ "${lib.toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "x-scheme-handler/http" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "x-scheme-handler/https" = [ "${lib.toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
      };
    };
  };
}
