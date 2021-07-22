{config, pkgs, ...}:

{
  gtk = {
    enable = true;
    
    gtk2.extraConfig = ''
      gtk-key-theme-name = "Emacs";
    '';
    
    gtk3.extraConfig = {
      gtk-key-theme-name = "Emacs";
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "abehfkkfjlplnjadfcjiflnejblfmmpj" # nord theme
    ];
  };

  #
  # Git and GitHub configuration
  #
  programs.gh.enable = true;
  programs.gh.editor = "emacs -nw";
  programs.gh.gitProtocol = "ssh";
  programs.git = {
    enable = true;
    userEmail = "ddz@theta44.org";
    userName = "Dino A. Dai Zovi";
  };

  # Enable Go with GOPATH=~/.go and binaries in ~/.local/bin
  programs.go.enable = true;
  programs.go.goPath = ".go";
  programs.go.goBin = ".local/bin";
  programs.go.packages = {
  };

  # GnuPG (handled in NixOS configuration now)
  #programs.gpg.enable = true;
  #services.gpg-agent = {
  #  enable = true;
  #  enableSshSupport = true;
  #};

  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    # Update TTY for GPG Agent to prompt for PIN if necessary
    LocalCommand gpg-connect-agent updatestartuptty /bye
  '';
}
