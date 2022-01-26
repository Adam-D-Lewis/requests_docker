{ pkgs }:    
let 
  my-python-packages-function = python-packages: with python-packages; [
    requests
    itemdb
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages-function; # pythonPackages.python3.withPackages my-python-pakcages-function; 
in
pkgs.dockerTools.buildLayeredImage {    
  name = "requests_image";    
  tag = "latest";    
  contents = [ pkgs.bash pkgs.lsd pkgs.vim pkgs.findutils pkgs.gnugrep pkgs.coreutils python-with-my-packages];    
  config = {    
    Cmd = [ "bash" ];    
  };    
}
