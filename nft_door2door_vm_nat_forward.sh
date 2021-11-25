#!/bin/bash

nft add table nat
nft add chain nat postrouting '{ type nat hook postrouting priority 100 ; }'
nft add chain nat prerouting '{ type nat hook prerouting priority -100; }'
nft add rule nat postrouting masquerade

nft insert rule ip filter FORWARD oifname "virbr0" ip daddr 192.168.122.10 counter accept

nft insert rule ip nat prerouting iifname "enp9s0f0" tcp dport 22222 counter dnat to 192.168.122.10:22
nft insert rule ip nat prerouting iifname "enp9s0f0" tcp dport 80 counter dnat to 192.168.122.10:80
nft insert rule ip nat prerouting iifname "enp9s0f0" tcp dport 443 counter dnat to 192.168.122.10:443
nft insert rule ip nat prerouting iifname "enp9s0f0" tcp dport 5000 counter dnat to 192.168.122.10:5000

