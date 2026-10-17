{ config, pkgs, ... }:
let
  libcSoLink = pkgs.runCommand "libc-so-link" { } ''
    mkdir -p $out/lib
    ln -s ${pkgs.glibc}/lib/libc.so.6 $out/lib/libc.so
  '';
in
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libcSoLink
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      fuse3
      gdk-pixbuf
      glib
      glibc
      gtk3
      icu
      libGL
      libappindicator-gtk3
      libdrm
      libglvnd
      libnotify
      libpulseaudio
      libunwind
      libusb1
      libuuid
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      openssl
      pango
      pipewire
      stdenv.cc.cc
      systemd
      vulkan-loader
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxkbfile
      xorg.libxshmfence
      zlib
      udev
      wayland
      alsa-lib
      harfbuzz
    ]
    ++ pkgs.steam-run.args.multiPkgs pkgs; #add all the libraries included in the steam fhs environment
  };
}