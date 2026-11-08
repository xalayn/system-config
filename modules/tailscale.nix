{ ... }:
{
  # Tailscale, on the homelab's own tailnet: its coordinator is the Headscale
  # server at headscale.alex-kumpula.net (xalayn-homelab repo), not
  # tailscale.com. While connected, the server is reachable from anywhere as
  # `xalayn-homelab` (MagicDNS) or 100.64.0.1, and its VMs as 10.0.100.x.
  #
  # Joining is once per device (the laptop makes its own identity, so it
  # can't be in config):
  #   sudo tailscale up --login-server https://headscale.alex-kumpula.net --accept-routes
  # then run the `headscale nodes register ...` command the login page shows
  # on the server, with sudo and `--user alex`. (`up` resets settings it isn't
  # given, hence --accept-routes there too.)
  services.tailscale = {
    enable = true;
    # Lets replies from the VM network through Linux's reverse-path check.
    useRoutingFeatures = "client";
    # Use the server's route to the VMs (10.0.100.0/24), re-applied on every
    # boot.
    extraSetFlags = [ "--accept-routes" ];
  };
}
