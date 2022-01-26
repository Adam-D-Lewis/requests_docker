{   
  description = "A very basic flake";    
    
  inputs = {        
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";        
    my_itemdb.url = "/home/balast/CodingProjects/nix/nix-flakes/itemdb_flake";
  };    
    
  outputs = inputs@{ self, nixpkgs, my_itemdb }: rec {    
    # ref: https://github.com/NixOS/nixpkgs/issues/26487#issuecomment-307363295
    my_overlay = self: super:
      rec {
        # nix-shell -p python.pkgs.my_stuff
        python3 = super.python3.override {
          # Careful, we're using a different self and super here!
          packageOverrides = self: super: {
            itemdb = super.flask; #super.buildPythonPackage rec {
            };
          };
        };
      # nix-shell -p pythonPackages.my_stuff
      # pythonPackages = python.pkgs;

    legacyPackages.x86_64-linux = rec { 
        pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ my_overlay ]; };    
        docker-flake = import ./docker-flake.nix { inherit pkgs; };
    };
    
    defaultPackage.x86_64-linux = legacyPackages.x86_64-linux.docker-flake;
  };    
} 
