#!/bin/sh

#--- Modify here ---
FLAGFILE="/tmp/mdflag"
LINETOKEN="INPUT HERE"
TOCAROTOKEN="INPUT HERE"
MESSAGE="Degraded disk array detected. Please check Machine's status!"
HOSTNAME=`hostname`
#--- Modify here ---

#delete flagfile when bootig machine
#Please command line option 'boot' when this script add rc.local
if [ $# -eq 1 ]; then
	if [ $1 = "boot" ]; then
		if [ -e $FLAGFILE ]; then
			rm $FLAGFILE
			MESSAGE="Machine booted. delete flag file."
		fi
	fi
fi


if [ -e $FLAGFILE ]; then
	exit 0
fi
i
#for debug
#MDSTAT=`cat mdstat-d.txt | grep -c _`
MDSTAT=`cat /proc/mdstat | grep -c _`

if [ $MDSTAT = "0" ]; then
	exit 0
fi

if [ -e $FLAGFILE ]; then
	exit 0
fi

touch $FLAGFILE

#LINE Notify
#curl -X POST -H "Authorization: Bearer $LINETOKEN" -F "message=$HOSTNAME: $MESSAGE" https://notify-api.line.me/api/notify
#Tocaro
curl -X POST -H 'Content-type: application/json' --data '{"text": "$MESSAGE" }' https://hooks.tocaro.im/integrations/inbound_webhook/$TOCAROTOKEN
if [ $? -gt 0 ]; then
	rm $FLAGFILE
fi
