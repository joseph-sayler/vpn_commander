# vpn_commander

vpn_commander is a client-side script for automating the use of openvpn from the command line. The script is meant for use in a headless server environment, or any cli environment.

The point of the script was to create a simple, light-weight way to quickly start up OpenVPN and connect to a VPN server. My examples are built around config files from a specific commercial VPN service, but as long as you place config files in a location the script can get to, you can use any commercial service or your own personal VPN server(s).

#### Setup

Place the `vpn_cmdr.sh` file somewhere in your PATH (`/usr/local/bin` is a good place). Optionally, place the `ipaddr.sh` file in the same location. The `vpn_cmdr.sh` script assumes you have openvpn configuration files (*.conf or *.ovpn) in the `/etc/openvpn` directory. These are used for connecting to the VPN service provider. The `ipaddr.sh` script requires no extra set up.

#### Usage

As root, type `vpn_cmdr.sh` and you will be presented with one of two screens:

* If the vpn service is running, you will be asked if you want to stop the service. If you say yes, a kill command (SIGKILL) will be sent to the program, immediately terminating it. If you select no, no further action is taken.

![image](https://raw.githubusercontent.com/joseph-sayler/vpn_commander/master/screenshots/disconnect.png)

* If the VPN service is not running, you will be presented with a menu and asked to select a "Location". The "locations" are a list of connection configuration files in the `/etc/openvpn` directory. Selecting one will use that file to connect to the VPN service. See `example.conf` for an example configuration connection file.

![image](https://raw.githubusercontent.com/joseph-sayler/vpn_commander/master/screenshots/connect.png)

Your internet IP address is shown whenever you run `vpn_cmdr.sh`. If you only want to see your IP address, run `ipaddr.sh` and you will be presented with the current local and internet IP addresses without the option to start or stop openvpn.


#### Notes
This script does not work with other programs or utilities that also interface with OpenVPN. NetworkManager is one such utility. The script will simply fail since NetworkManager both manipulates network connection and can interface with OpenVPN directly. Other programs, such as ConnMan, may operate in a similar manner.

#### To Do
- [ ] integrate `ipaddr.sh` into tmux status line *(not a critical task, more of a wish list idea)*
- [ ] remove dependency on update-resolv-conf.sh by calling resolvconf directly; the following command removes dns settings for a device - resolvconf -d tun0.inet -- this could also be used to modify resolv.conf (check arch linux wiki for more info)
