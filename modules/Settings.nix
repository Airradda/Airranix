{ config, pkgs, lib, ... }:
let
  cfg = config.Settings;
  inherit (lib.options) mkOption mkEnableOption mkPackageOption;
  inherit (lib) types toSentenceCase;
in
{
  options.Settings = {
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
        "application/json" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "application/pdf" = [ "${toSentenceCase cfg.DefaultPDFViewer.pname}.desktop" ];
        "application/epub+zip" = [ "${toSentenceCase cfg.DefaultPDFViewer.pname}.desktop" ];
        "application/rdf+xml" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/rss+xml" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/xhtml+xml" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/xhtml_xml" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/xml" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "application/x-wine-extension-ini" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "image/gif" = [ "${toSentenceCase cfg.DefaultMediaPlayer.pname}.desktop" ];
        "image/jpeg" = [ "${toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/png" = [ "${toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/svg+xml" = [ "${toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/webp" = [ "${toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "image/jxl" = [ "${toSentenceCase cfg.DefaultImageViewer.pname}.desktop" ];
        "text/css"  =  [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/html" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "text/markdown" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/plain" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/xml" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/x-opml+xml" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "text/x-python" = [ "${toSentenceCase cfg.DefaultEditor.pname}.desktop" ];
        "x-scheme-handler/http" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
        "x-scheme-handler/https" = [ "${toSentenceCase cfg.DefaultBrowser.pname}.desktop" ];
      };
    };
  };
}
