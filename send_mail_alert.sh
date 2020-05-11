#!/bin/sh
# send a message by email to BACKUP alerts
# Made by JamesLin. james.lin@cenoq.com cc.5247@gmail.com
# BEGIN: 2020/05/11 VERSION: 1.0
# Requirements: 
#    1.install mailx.(RHEL,CentOS)
#    2.start postfix service.
#    3.set SMTP firewall 
### CONFIG BEGIN ###
SUBJECT="PostgreSQL BACKUP FAILED"
CONTEXT="BACKUP FAILED.  $HOSTNAME"
MAILLIST="cc.5247@yahoo.com.tw"
#MAILLISTFILE="./maillist.txt"  # NOTICE: ","
DBBACKUPLOG="/DATA/pgdata/backup/pgbackup_result.log" # -a : attach logfile

## OPTION
CC="cc.5247@gmail.com, james.lin@cenoq.com " # -c : cc address # NOTICE: ","
#BCC="cc.5247@gmail.com james.lin@cenoq.com"
#BCCFILE="./bcclist.txt" # -b : bcc  # NOTICE: ","
#FROMSERVER="postgresql@myself.jameslin.com"  # -r : From address.

### CONFIG END ###
### DON'T CHANGE BELOW ###
# simple send 
#echo $CONTEXT `date +%F\ %T` | mail -s "$SUBJECT"  $MAILLIST 

# normal send hide receiver 
#echo $CONTEXT `date +%F\ %T` | mail -s "$SUBJECT" -a $DBBACKUPLOG   -b `tr -d '\n' < $BCCFILE` $MAILLIST

# normal send with cc

echo $CONTEXT `date +%F\ %T` | mail -s "$SUBJECT" -a $DBBACKUPLOG   -c "$CC" $MAILLIST

### END ###


### below only test,not sure ###
## send HTML format
#MESSAGEFILE="message.html"
#mail -s "$(echo -e "$SUBJECT \nContent-Type: text/html")"  -b `tr -d '\n' < $BCCFILE` $MAILLIST < $MESSAGEFILE
