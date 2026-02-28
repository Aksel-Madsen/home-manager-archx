{ config, pkgs, ... }:

{
  home.file = {
    # You can also source an existing file from your nix flake/directory
    ".config/doom/test.el".source = ./config/test.el;
  };
}
