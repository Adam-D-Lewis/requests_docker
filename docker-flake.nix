{ pkgs }:    
    
pkgs.dockerTools.buildLayeredImage {    
  name = "requests_image";    
  tag = "latest";    
  contents = [ pkgs.python3Packages.requests pkgs.bash pkgs.lsd pkgs.vim pkgs.findutils pkgs.gnugrep ];    
  config = {    
    Cmd = [ "bash" ];    
  };    
}
