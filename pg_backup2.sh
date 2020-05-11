#!/bin/sh
# RUN OS USER postgres
### CONFIG BEGIN ###
BACKUPDIR=/DATA/pgdata/backup
#BACKUPFILE="pgbackupall2-`date +%a`.backup"
BACKUPFILE="pgbackupall-`date +%F`.backup"
MESSAGEOK="`date +%F\ +%T` BACKUP $BACKUPFILE OK"
MESSAGEFAILED="`date +%F\ +%T` BACKUP $BACKUPFILE FAILED"
### CONFIG END ###

### don't change below ###
## overwrite by filename using week(marked)
## housekeeping by days
/usr/pgsql-12/bin/pg_dumpall -p 5433 -U postgres -f ${BACKUPDIR}/${BACKUPFILE} 


# BACKUP MESSAGE
[ $? -ne 0 ]&& echo $MESSAGEFAILED >> $BACKUPDIR/pgbackup_result.log && exit 1
echo $MESSAGEOK >> $BACKUPDIR/pgbackup_result.log
## run housekeeping
find ${BACKUPDIR} -type f -ctime +${KEEPDAYS} -name "*.backup" -exec rm -f '{}' ';' 

