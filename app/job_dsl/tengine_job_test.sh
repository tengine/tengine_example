#!/usr/bin/env bash
typeset -i time="$1"
export LOGFILE=tengine_job_test.log
echo "`date` tengine_job_test $2 start" >> $LOGFILE
if [ "$SLEEP" != ""  ] ; then
  sleep ${SLEEP:=0}
else
  sleep `expr 1 + $time`
fi
echo "`date` tengine_job_test $2 finish" >> $LOGFILE
