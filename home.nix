{ lib, pkgs, ... }:
{
  imports = [
    ./modules/doom
  ];
  home = {
    packages = with pkgs; [
      spotify
    ];

    username = "archo";
    homeDirectory = "/home/archo";

    stateVersion = "25.11";
  };
  programs = {
    zsh = import ./programs/zsh;
    emacs = import ./programs/emacs;
    alacritty = import ./programs/alacritty;
  };
}
