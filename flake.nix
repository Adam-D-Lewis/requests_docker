{    
  description = "A very basic flake";    
    
  inputs = {        
    # pulls in the flake.nix file from this github repo        
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";        
    itemdb.url = "/home/balast/CodingProjects/nix/nix-flakes/itemdb_flake/";    
  };    
    
  outputs = inputs@{ self, nixpkgs, itemdb }: rec {    
    legacyPackages.x86_64-linux = rec { 
        pkgs = import nixpkgs { system = "x86_64-linux"; };    
        pypkgs = pkgs.python3Packages;    
        docker-flake = import ./docker-flake.nix { inherit pkgs itemdb; };
    };
    
    defaultPackage.x86_64-linux = legacyPackages.x86_64-linux.docker-flake;
  };    
} 
