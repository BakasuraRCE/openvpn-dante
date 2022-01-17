#!/bin/sh

# Stop and exit if any background process fail
set -e

/usr/bin/openvpn.sh &
openvpn_pid=$!
sleep 15
sockd -N "$(nproc --all)" &
sockd_pid=$!

wait ${openvpn_pid}
wait ${sockd_pid}
