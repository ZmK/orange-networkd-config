#!/bin/bash

# WAN & LAN Interfaces
IFWAN="enp1s0"
IFWAN_MACADDR="00:a8:2a:e8:33:34"
IFLAN="enp2s0"
IFLAN_MACADDR="00:a8:2a:e8:33:35"

# Domain
DOMAIN="blakyris.io"
SERVER_NAME="gateway"

# LAN Settings
LAN_NETWORK="192.168.1.0/24"
LAN_INTERFACE_IP="192.168.1.1"
LAN_DHCP=1
LAN_DHCP_RANGE_START=10
LAN_DHCP_RANGE_END=200

# Installation
echo "Installing Packages..."
sudo yum install -y -q openssh ppp unbound dhcp
curl http://www.internic.net/domain/named.root -o ./etc/unbound/root.hints

echo "Configuring DNS Resolver..."
sudo rm -f /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf
echo "nameserver ::1" >> /etc/resolv.conf
sudo cp ./etc/unbound/* /etc/unbound/

echo "Configuring Interfaces..."
sudo mkdir /etc/systemd/network
sudo cp ./etc/systemd/network/* /etc/systemd/network/
sudo cp ./etc/systemd/system/* /etc/systemd/system/
sudo cp ./etc/ppp/peers/* /etc/ppp/peers/

echo "Configuring DHCP Server..."
sudo rm -f /etc/dhcpd.conf
sudo cp ./etc/dhcpd.conf /etc/

echo "Starting network services..."
sudo systemctl -q daemon-reload
sudo systemctl -q disable NetworkManager
sudo systemctl -q stop NetworkManager
sudo systemctl -q enable systemd-networkd
sudo systemctl -q enable systemd-resolved
sudo systemctl -q enable unbound
sudo systemctl -q enable ppp@orange
sudo systemctl -q enable dhcpd4
sudo systemctl -q start systemd-resolved
sudo systemctl -q start systemd-networkd
sudo systemctl -q start unbound
sudo systemctl -q start ppp@orange
sudo systemctl -q start dhcpd4
