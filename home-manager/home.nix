{ config, pkgs, ... }:
{
  home.username = "spy";
  home.homeDirectory = "/home/spy";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    pkgs.oh-my-zsh
    (pkgs.writeShellScriptBin "random-wallpaper" ''
    WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
    RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    ${pkgs.swaybg}/bin/swaybg -i "$RANDOM_WALLPAPER" -m fill
'')
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -alh";
      nixconf="export EDITOR='emacs -nw'; sudoedit /etc/nixos/configuration.nix";
      update = "sudo nixos-rebuild switch";
    };
    initExtra = ''
      fastfetch

    '';
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "agnoster";
    };
  };
  
  programs.git = {
    enable = true;
    userName = "spynets";
    userEmail = "alfred@stensatter.se";
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };


  xdg.mimeApps.defaultApplications = {
    "text/plain" = ["emacs"];
    "image/*" = ["feh"];
    "application/pdf" = ["firefox"];
    "video/*" = ["mpv.desktop"];
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30;  # or your preferred version
  };
  
  home.file = {
    ".config/niri/config.kdl".source = "/home/spy/.config/home-manager/dotfiles/niri/config.kdl";
    ".config/waybar/config.jsonc".source = "/home/spy/.config/home-manager/dotfiles/waybar/config.jsonc";
    ".config/waybar/style.css".source = "/home/spy/.config/home-manager/dotfiles/waybar/style.css";
  ".doom.d".source = ./dotfiles/doom;
  };

  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };


  programs.home-manager.enable = true;
}
  
