{ config, lib, pkgs, ... }:
{
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    # The workaround moves realtime processes (e.g. Hyprland, which gets
    # CAP_SYS_NICE from its NixOS wrapper) into the root cgroup. That takes
    # them out of their logind session, so polkit treats them as non-local
    # and refuses session actions like VT switching. It's only needed when
    # the kernel has CONFIG_RT_GROUP_SCHED, which NixOS kernels don't.
    settings.cgroup_realtime_workaround = lib.mkForce false;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };

  # ananicy only reads its config at startup, and NixOS doesn't restart it when
  # just /etc/ananicy.d changes, so restart it whenever the config changes.
  systemd.services.ananicy-cpp.restartTriggers = [
    config.environment.etc."ananicy.d".source
  ];
}
