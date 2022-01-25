{    
  description = "A very basic flake";    
    
  inputs = {        
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";        
  };    
    
  outputs = inputs@{ self, nixpkgs }: rec {    
    legacyPackages.x86_64-linux = rec { 
        pkgs = import nixpkgs { system = "x86_64-linux"; };    
        docker-flake = import ./docker-flake.nix { inherit pkgs; };
    };
    
    defaultPackage.x86_64-linux = legacyPackages.x86_64-linux.docker-flake;
  };    
} 
