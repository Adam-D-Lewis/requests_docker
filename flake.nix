{    
  description = "A very basic flake";    
    
  inputs = {        
    # pulls in the flake.nix file from this github repo        
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";        
    itemdb.url = "/home/balast/CodingProjects/nix/nix-flakes/itemdb_flake/";    
  };    
    
  outputs = inputs@{ self, nixpkgs, itemdb}: rec {    
        pkgs = import nixpkgs { system = "x86_64-linux"; };    
        # itemdb_pkg = import itemdb {};    
        pypkgs = pkgs.python3Packages;    
        timetagger = pypkgs.buildPythonPackage {    
          name = "timetagger";    
          src = pkgs.fetchFromGitHub {        
            owner = "almarklein";        
            repo = "timetagger" ;        
            rev = "e3526da61c32276d315056483f6b3cfa03d4b657";        
            sha256 = "6PhBYYrGtAel7bA0q2RM+XxMUnKUhaCA1YvakGRpSk8=";        
          };        
          propagatedBuildInputs = [     
            pypkgs.uvicorn     
            # asgineer # not in nixpkgs    
            itemdb # not in nixpkgs, but this has no dependencies so should be easy to package
            # pscript # also not in nixpkgs, but pure python and no dependencies    
            pypkgs.pyjwt     
            pypkgs.jinja2     
            pypkgs.markdown     
          ];    
      };    
      defaultPackage.x86_64-linux = self.timetagger;    
  };    
} 
