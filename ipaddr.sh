#!/bin/bash

#----------------------------------------------------------------
# by Joseph Sayler
# A simple script to check local and internet ip addresses and
# get status of VPN.
#----------------------------------------------------------------

service=openvpn
running=$(ps -ef |grep -v grep | grep $service | wc -l)
interface=wlp2s0
internet_check="icanhazip.com"

echo
echo -n "Current IP address: " ; sleep 1
tput setaf 4 ; curl $internet_check ; tput sgr0 ; sleep 0.5
echo -n "Local IP address: " ; tput setaf 2
ip addr show dev $interface | grep -w inet | awk '{print $2}' | awk -F"/" '{print $1}' ; tput sgr0 ; sleep 0.5
echo -n "VPN status:  "
if [[ $running -ge 1 ]]
     then
            echo "$(tput setab 2)$(tput setaf 18)$(tput bold) CONNECTED $(tput sgr0)"
        else
               echo "$(tput setab 1)$(tput setaf 18)$(tput bold) DISCONNECTED $(tput sgr0)"
           fi
           echo

