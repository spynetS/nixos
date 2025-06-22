{ config, pkgs, ... }:
{
  home.username = "spy";
  home.homeDirectory = "/home/spy";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    pkgs.oh-my-zsh
    (pkgs.writeShellScriptBin "random-wallpaper" ''
    WALLPAPER_DIR="${./Wallpapers}"
    RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    ${pkgs.swaybg}/bin/swaybg -i "$RANDOM_WALLPAPER" -m fill
'')
    (pkgs.writeShellScriptBin "start-random-wallpaper" ''${pkgs.swww}/bin/swww init; sleep 1; while true; do ${pkgs.swww}/bin/swww img /home/spy/Pictures/Wallpapers/$(ls /home/spy/Pictures/Wallpapers | shuf -n 1) --transition-fps 30 --transition-type=random --transition-bezier=0,0.84,1,1; sleep 10; done'')
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
    package = pkgs.emacs-pgtk;  # or your preferred version
  };
  
  home.file = {
    ".config/niri".source = ./dotfiles/niri;
    ".config/waybar".source = ./dotfiles/waybar;
    ".doom.d".source = ./dotfiles/doom;
    "Pictures/Wallpapers" = {
      source = ./Wallpapers;
      recursive = true;
    };
  };

  home.sessionVariables = {
    DOOMDIR = "$HOME/.config/doom";
    EDITOR = "emacs -nw";
  };


  programs.home-manager.enable = true;
}
  
