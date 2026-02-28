{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      spotify
    ];

    username = "archo";
    homeDirectory = "/home/archo";

    stateVersion = "25.11";
  };
}
