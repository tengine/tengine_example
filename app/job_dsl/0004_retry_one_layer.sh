#!/bin/bash
typeset -i time=$1
export LOGFILE=tengine_job_test.log
echo "`date` tengine_job_test $MM_ACTUAL_JOB_NAME_PATH start" >> $LOGFILE
case "$MM_ACTUAL_JOB_NAME_PATH" in
  "/jn0004/j1" ) 
    sleep ${J1_SLEEP:=0} 
    if [ "$J1_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0004/j2" ) 
    sleep ${J2_SLEEP:=0}
    if [ "$J2_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0004/j3" ) 
    sleep ${J3_SLEEP:=0}
    if [ "$J3_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0004/j4" ) 
    sleep ${J4_SLEEP:=0} 
    if [ "$J4_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0004/finally/jn0004_f" ) 
    sleep ${JN0004_F_SLEEP:=0} 
    if [ "$JN0004_F_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
esac

echo "`date` tengine_job_test $MM_ACTUAL_JOB_NAME_PATH finish" >> $LOGFILE
