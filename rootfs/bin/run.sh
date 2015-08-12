#!/bin/busybox sh

echo "running!" &&
if test ! -d "${HOME}/.ipfs"
then
	echo "initialize IPFS node" &&
	ipfs init &&
	#ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001 &&
	ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
else
	ipfs id -f '<id>
'
fi &&
echo "launch daemon" &&
exec ipfs daemon
