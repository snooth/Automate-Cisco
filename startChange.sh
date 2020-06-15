#!/bin/bash

# loop to read in all the ip addresses and pull configs for day 0
while read ips
do
	export ips
	./pullconfig.sh $ips
done < ipaddresses

# loop to invokeChange for each IP address
while read ips
do
	export ips
	./enablefunction.sh $ips
done < ipaddresses

