{config, pkgs, ...}:

let
  nord = import ./nord.nix;
in
{
  fonts.fontconfig.enable = true;

  # Add sway config specific pkgs here
  home.packages = with pkgs; [
    # Helpers
    swaylock
    swayidle
    wl-clipboard
    mako
    alacritty
    j4-dmenu-desktop

    # Fonts
    go-font
  ];

  # Hint firefox to use wayland
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "Go Mono";
      font.bold.family = "Go Mono";
      font.italic.family = "Go Mono";
      font.bold_italic.family = "Go Mono";
    };
  };
  
  programs.i3status = {
    enable  = true;
    general = {
      colors = true;
      color_good = nord.nord14;
      color_degraded = nord.nord13;
      color_bad = nord.nord11;
      interval = 5;
    };
  };

  # Enable kanshi for dynamic display configuration
  services.kanshi.enable = true;
  
  # Enable mako for notifications
  programs.mako = {
    enable = true;
    backgroundColor = nord.nord1;
    borderColor = nord.nord4;
    textColor = nord.nord13;
    font = "Go Mono";
  };

  # Enable rofi as a dmenu replacement
  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";
  };
  
  wayland.windowManager.sway = {
    enable = true;
    config = {
      colors = {
        background = nord.nord0;
        
        focused = {
          background = nord.nord0;
          border = nord.nord7;
          childBorder = nord.nord7;
          indicator = nord.nord10;
          text = nord.nord5;
        };

        focusedInactive = {
          background = nord.nord0;
          border = nord.nord3;
          childBorder = nord.nord3;
          indicator = nord.nord3;
          text = nord.nord5;
        };
          
        placeholder = {
          background = nord.nord0;
          border = nord.nord1;
          childBorder = nord.nord1;
          indicator = nord.nord1;
          text = nord.nord5;
        };
          
        unfocused = {
          background = nord.nord0;
          border = nord.nord1;
          childBorder = nord.nord1;
          indicator = nord.nord1;
          text = nord.nord5;
        };
        
        urgent = {
          background = nord.nord0;
          border = nord.nord11;
          childBorder = nord.nord11;
          indicator = nord.nord11;
          text = nord.nord5;
        };

      };

      bars = [ {
        command = "${pkgs.sway}/bin/swaybar";
        statusCommand = "${pkgs.i3status}/bin/i3status";

        fonts = [ "Go Mono 8" ];
        
        colors = {
          background = nord.nord0;
          separator = nord.nord1;
          statusline = nord.nord9;

          focusedWorkspace = {
            border = nord.nord10;
            background = nord.nord3;
            text = nord.nord6;
          };

          activeWorkspace = {
            border = nord.nord1;
            background = nord.nord1;
            text = nord.nord4;
          };
          
          inactiveWorkspace = {
            border = nord.nord1;
            background = nord.nord0;
            text = nord.nord4;
          };

          urgentWorkspace = {
            border = nord.nord11;
            background = nord.nord0;
            text = nord.nord4;
          };

        };
      } ];
      
      #menu = "${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop";
      menu = "${pkgs.rofi}/bin/rofi -show drun";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      modifier = "Mod4";
      input = {
        # Make CapsLk be Ctrl and swap Alt/Super on internal keyboard
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_options = "ctrl:nocaps,altwin:swap_alt_win";
        };
      
        "type:touchpad" = {
          natural_scroll = "enabled";
        };
      };

      startup = [
        {
          # Configure swayidle to lock screen after 5 minutes
          command = "swayidle -w timeout 300 'physlock'";
        }
      ];
    };
  };
}
