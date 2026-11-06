{ pkgs, pkgs-unstable, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # programs.gamescope = {
  #   enable = true;
  #   package = pkgs-unstable.gamescope;
  # };

  environment.systemPackages = with pkgs; [
    # ... other packages
    xkeyboard_config
  ];

  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope;
    capSysNice = false;
  };
}
