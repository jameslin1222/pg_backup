#!/bin/sh
# RUN OS USER postgres
### CONFIG BEGIN ###
BACKUPDIR=/DATA/pgdata/backup
#BACKUPFILE="pgbackupall-`date +%a`.backup"
BACKUPFILE="pgbackupall-`date +%F`.backup"
KEEPDAYS=1
MESSAGEOK="`date +%F\ +%T` BACKUP OK"
MESSAGEFAILED="`date +%F\ +%T` BACKUP FAILED"
### CONFIG END ###

### don't change below ###
## overwrite by filename using week(marked)
## housekeeping by days
/usr/pgsql-12/bin/pg_dumpall -U postgres -f ${BACKUPDIR}/${BACKUPFILE} 


# BACKUP MESSAGE
[ $? -ne 0 ]&& echo $MESSAGEFAILED >> $BACKUPDIR/pgbackup_result.log && exit 1
echo $MESSAGEOK >> $BACKUPDIR/pgbackup_result.log
## run housekeeping
find ${BACKUPDIR} -type f -ctime +${KEEPDAYS} -name "*.backup" -exec rm -f '{}' ';' 

