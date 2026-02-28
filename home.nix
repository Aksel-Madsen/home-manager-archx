{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      spotify
    ];

    username = "archo";
    homeDirectory = "/home/archo";

    stateVersion = "25.11";
    file = {
      ".emacs.d/init.el" = {
       text = 
          ''
          This is the emacs init file with a line break
          This is line number 2
          '';
      };
    };
  };
  programs = {
    zsh = import ./programs/zsh;
  };
}
