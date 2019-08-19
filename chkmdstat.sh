#!/bin/sh

#--- Modify here ---
#FLAGFILE is prevent for send message repeatedly.
FLAGFILE="/tmp/mdflag"
#SLACKURL is url for webhook.
#You can get url via your slack app page
SLACKURL="NPUT HERE"
#LINETOKEN is token for LINE notify.
#You can get token via your LINE notify account page.
LINETOKEN="INPUT HERE"
#TOKAROTOKEN is token for webhook integration.
#You can get token via your TOCARO's integration page.
TOCAROTOKEN="INPUT HERE"
MESSAGE="Degraded disk array detected. Please check Machine's status!"
HOSTNAME=`hostname`
#--- Modify here ---

#chkmdstat deletes flagfile when execute with initialize option.
#Please command line option 'init' when this script add rc.local
if [ $# -eq 1 ]; then
	if [ $1 = "init" ]; then
		if [ -e $FLAGFILE ]; then
			rm $FLAGFILE
			MESSAGE="Flag file deleted."
		fi
	fi
fi


if [ -e $FLAGFILE ]; then
	exit 0
fi

#for debug
#MDSTAT=`cat ~/mdstat-d.txt | grep -c _`
MDSTAT=`cat /proc/mdstat | grep -c _`

if [ $MDSTAT = "0" ]; then
	exit 0
fi

touch $FLAGFILE

#Slack
if [ "$SLACKURL" != 'INPUT HERE' ]; then
	curl -f -X POST --data-urlencode "payload={ \"username\": \"chkmdstat\", \"text\": \"$HOSTNAME: $MESSAGE\" }" $SLACKURL
	if [ $? -gt 0 ]; then
		rm $FLAGFILE
	fi
fi

#LINE Notify
if [ "$LINETOKEN" != "INPUT HERE" ]; then
	curl -f -X POST -H "Authorization: Bearer $LINETOKEN" -F "message=$HOSTNAME: $MESSAGE" https://notify-api.line.me/api/notify
	if [ $? -gt 0 ]; then
		rm $FLAGFILE
	fi
fi

#Tocaro
if [ "$TOKAROTOKEN" != "INPUT HERE" ]; then
	curl -f -X POST -H "Content-type: application/json" --data "{ \"text\": \"$HOSTNAME: $MESSAGE\" }" https://hooks.tocaro.im/integrations/inbound_webhook/$TOCAROTOKEN
	if [ $? -gt 0 ]; then
		rm $FLAGFILE
	fi
fi

