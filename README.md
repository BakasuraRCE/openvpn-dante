Supported tags and respective `Dockerfile` links
================================================

  * [`latest` (Dockerfile)](https://github.com/BakasuraRCE/openvpn-dante/blob/master/Dockerfile)


How to use this image
-------------

You can use this image at same form that [dperson image](https://github.com/dperson/openvpn-client)
Additional this expose the `1080` port as socks5 proxy server

Example Compose File
-------------

```
version: "3.8"

services:
  vpn:
    image: bakasura/openvpn-dante:latest
    # If you need IPv6
    #sysctls:
    #  net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    cap_drop:
      - CAP_MKNOD
    environment:
      TZ: 'Etc/GMT-2'
      FIREWALL: ''
      GROUPID: '1000'
    ports:
      - "1080:1080"
    volumes:
      - /dev/net:/dev/net:z
      # Put .ovpn configuration file in the /vpn directory (in "volumes:" above or
      # launch using the command line arguments, IE pick one:
      - ./vpn:/vpn
      mode: replicated
      replicas: 1
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure
```