#!/bin/bash

SCRIPT=$(realpath "$0")
DIR=$(dirname "$SCRIPT")

NAME="ITC OS Monitor"

MONITOR_INTERVAL="1" # SECONDS

MONITOR_POOL_HOST="127.0.0.1"
MONITOR_POOL_PORT="4444"
MONITOR_POOL_LOG=$DIR/../../logs/socket.log

source "$DIR/header.sh" $1
source "$DIR/socket.sh" $1
source "$DIR/cpu.sh" $1
source "$DIR/disk.sh" $1
source "$DIR/mail.sh" $1
source "$DIR/mysql.sh" $1
source "$DIR/netstat.sh" $1
source "$DIR/network.sh" $1
source "$DIR/processes.sh" $1
source "$DIR/pool.sh" $1
source "$DIR/tcpdump.sh" $1

ITCMonitorStart()
{
	ITCMonitorPool
	ITCMonitorDiskUsage > /dev/tcp/127.0.0.1/4444

	# (ITCMonitorConnection )
    # (ITCMonitorCPU > /dev/tcp/127.0.0.1/4444)
	# 
	# (ITCMonitorNetstat > /dev/tcp/127.0.0.1/4444)
	# ITCMonitorConnection
	# (ITCMonitorMail)
	# (ITCMonitorMysql)
	# (ITCMonitorNetwork)
	# 
	# (ITCMonitorProcesses)
}

ITCMonitor()
{
	case "$1" in

		start)
			ITCMonitorStart $2
			;;

		cpu)
            ITCMonitorCPU $2
            ;;

        disk)
            ITCMonitorDiskUsage $2
            ;;

		mail)
            ITCMonitorMail $2
            ;;

        mysql)
            ITCMonitorMysql $2
            ;;

        network)
            ITCMonitorNetwork $2
            ;;

        netstat)
        	ITCMonitorNetstat $2
        	;;

        processes)
        	ITCMonitorProcesses $2
        	;;

		*)
			ITCMonitorHeader
			printf "Service " $NAME " usage start-server|start|restart|cpu|disk|mail|mysql|network|netstat|processes"
  			;;
	esac
	exit
}

(ITCMonitor $1)