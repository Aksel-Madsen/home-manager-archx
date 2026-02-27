{
  description = "MyHomeManager";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
    url = "github:nix-community/home-manager/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, home-manager, ...}:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linix";
    pkgs = import nixpkgs { inherit system; }
  in {
    homeConfigurations = {
      archo = home-manager.lib.homeManager.Configuration {
        inherit pkgs;
	modules = [ ./home.nix ];
      };
    };
  };
}
