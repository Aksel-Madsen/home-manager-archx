{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "archo";
    homeDirectory = "/home/archo";

    stateVersion = "25.11";
  };
}
