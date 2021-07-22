{config, pkgs, epkgs, ...}:
{
  programs.emacs = {
    enable = true;
    #package = pkgs.emacs-nox;
    extraPackages = epkgs: with epkgs; [
      use-package
      nord-theme
    
      # Go development
      company
      flycheck
      #flymake-go
      go-mode
      gotest
      lsp-mode
    
      nix-mode
    ];
  };

  # Additional packages used by emacs configuration
  home.packages = with pkgs; [
    golint
    gopls
  ];
}
