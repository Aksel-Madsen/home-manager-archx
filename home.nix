{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      spotify
    ];

    username = "archo";
    homeDirectory = "/home/archo";

    stateVersion = "25.11";
  };
  programs.emacs = {
  extraConfig = ''(setq standard-indent 2)'';
  };
}
