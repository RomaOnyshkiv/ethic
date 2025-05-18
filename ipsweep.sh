#!/bin/bash

file="ipsweep.txt"

if [ -f $file ]; then
    rm $file
fi

if [ -z "$1" ]; then
    echo "IP address is requred. Format: ./ipsweep.sh 192.168.1"
else
    for ip in `seq 1 254`; do
        ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> $file  &
    done
    echo "IP addresses saved to $file"
    echo "Scanning for open ports..."
    for ip in `cat $file`; do
        nmap $ip
    done
fi