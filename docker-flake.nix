{ pkgs, itemdb }:    
    
pkgs.dockerTools.buildLayeredImage {    
  name = "itemdb";    
  tag = "latest";    
  contents = [ itemdb.defaultPackage.x86_64-linux pkgs.bash pkgs.lsd pkgs.vim pkgs.findutils pkgs.gnugrep ];    
  config = {    
    Cmd = [ "bash" ];    
  };    
}
