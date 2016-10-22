vpn_commander
=============

vpn_commander is a script for automating the use of openvpn from the command line. The script is meant for use in a headless server environment, or any cli environment.

Setup
-----

Place the `vpn_cmdr.sh` file somewhere in your PATH (`/usr/local/bin` is a good place). Optionally, place the `ipaddr.sh` file in the same location. The `vpn_cmdr.sh` script assumes you have openvpn configuration files (*.conf or *.ovpn) in the `/etc/openvpn` directory. These are used for connecting to the VPN service provider. The `ipaddr.sh` script requires no extra set up.

Usage
-----

As root, type `vpn_cmdr.sh` and you will be presented with one of two screens:

0. If the vpn service is running, you will be asked if you want to stop the service. If you say yes, a kill command (SIGKILL) will be sent to the program, immediately terminating it. If you select no, no further action is taken.

#### [disconnect.png]
![image](https://raw.githubusercontent.com/joseph-sayler/vpn_commander/master/screenshots/disconnect.png)

0. If the VPN service is not running, you will be presented with a menu and asked to select a "Location". The "locations" are a list of connection configuration files in the `/etc/openvpn` directory. Selecting one will use that file to connect to the VPN service. See `example.conf` for an example configuration connection file.

#### [connect.png]
![image](https://raw.githubusercontent.com/joseph-sayler/vpn_commander/master/screenshots/connect.png)

Your local and internet IP addresses are shown whenever you run `vpn_cmdr.sh`. If you only want to see your IP addresses, run `ipaddr.sh` and you will be presented with the current IP addresses without the option to start or stop openvpn.


