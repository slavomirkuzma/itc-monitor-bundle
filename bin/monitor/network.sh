#!/bin/bash

ITCMonitorNetwork ()
{
	#IP=(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
	#echo $IP
	(watch -n 1  "ip -stats addr")
}