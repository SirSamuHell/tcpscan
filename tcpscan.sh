#!/bin/bash 

declare -a PARAMS=($@)

if [[ $# -eq 0 ]]; then
	echo 'HOW TO USE ?'
	echo 'Usage: tcpscan <ip>'
	echo '- Description: Scan all port from 0 to 65535.'
	echo 'Usage: tcpscan <ip> <port1> <port2> <port...>'
	echo '- Description: Scan port(s) from a list in parameter(s).'
	exit 1
fi 

LENGTHS=${#PARAMS[@]}
IP=${PARAMS[0]}
PORTS=${PARAMS[@]:1:LENGTHS}

function TCPScanAllRange()
{
	for port in $(seq 0 65535);
	do
		bash -c "echo -c </dev/tcp/$IP/$port" > /dev/null 2>&1
	
		if [[ $? -eq 0 ]]; then 
			printf "[+] %s:%d is open\n" $IP $port
		fi 
	done
}

function scanFromSourcePorts() 
{
	for port in $PORTS;
	do
		bash -c "</dev/tcp/$IP/$port" > /dev/null 2>&1

		if [[ $? -eq 0 ]]; then 
			printf "[+] %s:%d is open\n" $IP $port
		fi 
	done 
}


if [[ $# -eq 1 ]]; then 
	TCPScanAllRange 
else 
	scanFromSourcePorts
fi 
