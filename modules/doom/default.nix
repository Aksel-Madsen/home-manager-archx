{ config, pkgs, ... }:

{
  home.file = {
    ".config/doom/init.el".source = ./config/init.el;
  };
  home.file = {
    ".config/doom/config.el".source = ./config/config.el;
  };
  home.file = {
    ".config/doom/packages.el".source = ./config/packages.el;
  };
  home.file = {
    ".config/doom/custom.el".source = ./config/custom.el;
  };
}
