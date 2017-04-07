#!/bin/bash

#----------------------------------------------------------------
# by Joseph Sayler
#
# This script starts/stops openvpn and gives current IP address.
#
# Be sure to place vpn config files in /etc/openvpn.
#
# MUST BE RUN AS ROOT!
#----------------------------------------------------------------

service=openvpn
ovpn_dir=/etc/openvpn
running=$(ps -ef | grep -v grep | grep $service | wc -l)
pid_file=$ovpn_dir/openvpn.pid
pid=$(cat $pid_file)
ip_check="icanhazip.com"
file_list=`find $ovpn_dir/*.conf -type f -printf "%f\n"`
PS3="Pick a connection or press CTRL+C to exit: "
net_dev='tun0'

# checks if root
if [ "$EUID" -ne 0 ]
 then
   echo "Please run as root."
   exit
fi

tput clear ; tput bold ; tput setaf 7 ; tput setab 8
echo "                             "
echo "        VPN COMMANDER        "
echo "                             "
tput sgr 0
echo

if [[ $running -ge 1 ]]
 then
# if service is running, asks if you want to stop service
   echo "VPN is $(tput setab 2)$(tput setaf 18)$(tput bold) CONNECTED $(tput sgr0)"
   echo
   echo -n "Current IP address: " ; tput setaf 4 ; curl $ip_check ; tput sgr0
   echo
   echo -n "Do you want to $(tput setaf 1)stop$(tput sgr0) the service? [y/n] "; read stop_ans
   case "$stop_ans" in
    "y") echo
        echo "Stopping VPN..."
	kill -9 $pid
	# the down portion of the update-resolv-conf.sh script does not appear
	# to be working; use the following to change resolv.conf back to original
	resolvconf -d $net_dev.inet
	sleep 2.5
        echo
        echo "VPN is $(tput setab 1)$(tput setaf 18)$(tput bold) DISCONNECTED $(tput sgr0)"
        echo
        echo -n "New IP address: " ; tput setaf 4 ; curl $ip_check ; tput sgr0
        echo
        ;;
     *) echo;exit
        ;;
   esac
 else
# if service not running, asks you to pick a location to start service
   echo "VPN is $(tput setab 1)$(tput setaf 18)$(tput bold) DISCONNECTED $(tput sgr0)"
   echo
   echo -n "Current IP address: " ; tput setaf 4 ; curl $ip_check ; tput sgr0
   echo
   echo "Available VPN locations:"
   echo
   select file in $file_list
     do
       if [[ $file != *[!0-9]* ]] ; then
         echo "Invalid choice, try again."
         echo
       else
         vpn_conf=$file
         break
       fi
   done
 echo
 echo -n "Starting VPN..."
 $service --config $ovpn_dir/$vpn_conf --writepid $pid_file > /dev/null 2>&1 &
 sleep 5
 echo
 echo
 echo "VPN is $(tput setab 2)$(tput setaf 18)$(tput bold) CONNECTED $(tput sgr0)"
 echo
 echo -n "New IP address: " ;  tput setaf 4 ; curl $ip_check ; tput sgr0
 echo
fi
