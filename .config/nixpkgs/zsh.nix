{config, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    
    loginExtra = ''
      test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)
    '';

    shellAliases = {
      emacs = "emacs -nw";
    };
  };
}
