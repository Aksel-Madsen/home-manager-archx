{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig =
      ''
      exec-once = hyprpanel
      exec-once = wl-paste --watch cliphist -max-dedupe-search 0 -max-items 20 store 

      general {
        layout = master
      }

      master {
          new_status = slave
          mfact = 0.5
      }

      #############
      ### INPUT ###
      #############
      
      # https://wiki.hypr.land/Configuring/Variables/#input
      input {
          kb_layout = dk
      
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      
          touchpad {
              natural_scroll = false
          }
          accel_profile=flat
      }
      monitor = DP-2, 5120x1440@119.97, 0x0, 1
      $terminal = alacritty
      $launcher = rofi -show drun
      $mainMod = SUPER
      $clip_hist_command = cliphist list | rofi -dmenu | cliphist decode | wl-copy

      bind = $mainMod,       Q,      killactive
      bind = $mainMod SHIFT, RETURN, exec,       $terminal

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      bind = $mainMod,       d, exec           , $launcher
      bind = $mainMod SHIFT, F, fullscreen

      # Keybinds for master mode
      bind = $mainMod,        RETURN, layoutmsg,  swapwithmaster
      bind = $mainMod,        j,      layoutmsg,  cyclenext
      bind = $mainMod,        k,      layoutmsg,  cycleprev
      bind = $mainMod SHIFT,  j,      layoutmsg,  swapnext
      bind = $mainMod SHIFT,  k,      layoutmsg,  swapprev
      bind = $mainMod SHIFT,  l,      layoutmsg,  mfact +0.05
      bind = $mainMod SHIFT,  h,      layoutmsg,  mfact -0.05
      bind = $mainMod SHIFT,  Space,  layoutmsg,  focusmaster
      bind = $mainMod SHIFT,  Space,  layoutmsg,  focusmaster

      # Clipboard binds
      bind = $mainMod SHIFT,  s,  exec,  grim -g "$(slurp)" -| wl-copy
      bind = $mainMod SHIFT,  v,  exec,  $clip_hist_command 
      
      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
      '';
  };
  programs.hyprpanel = {
    enable = true;
    settings = {
      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };
    };
  };
}

