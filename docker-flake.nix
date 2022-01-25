{ pkgs ? import <nixpkgs> { system = "x86_64-linux";}; 
  tt_flake ? import /home/balast/CodingProjects/nix/nix-flakes/timetagger_flake/flake.nix {}
}:  # nixpkgs package set
pkgs.dockerTools.buildLayeredImage { # helper to build Docker image          
  name = "nix-hello";                # give docker image a name              
  tag = "latest";                    # provide a tag                         
  contents = [ tt_flake.time_tagger ];         # packages in docker image              
}
