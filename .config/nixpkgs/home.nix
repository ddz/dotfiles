{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./programs.nix
    ./sway.nix
    ./zsh.nix
  ];
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "me";
  home.homeDirectory = "/home/${config.home.username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    gh
    jq
  ];

  home.file.".dir_colors".text = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-dircolors";
      # Commit isn't in a tagged release yet
      rev = "5a2763c87860a480c15f45a31d9ac7f0c04efc4c";
      sha256 = "1g3klhlmd5d4ywbnxkv0f6kv4pfr3hbaz3fryd9mbzdbp7zp32sm";
    } + "/src/dir_colors"
  );

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # XDG
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "\$HOME/XDG/Desktop";
      documents = "\$HOME/XDG/Documents";
      download = "\$HOME/XDG/Downloads";
      music = "\$HOME/XDG/Music";
      pictures = "\$HOME/XDG/Pictures";
      publicShare = "\$HOME/XDG/Public";
      templates = "\$HOME/XDG/Templates";
      videos = "\$HOME/XDG/Videos";
    };
  };
}
