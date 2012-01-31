#!/bin/bash
typeset -i time="$1"
export LOGFILE=tengine_job_test.log
echo "`date` tengine_job_test $MM_ACTUAL_JOB_NAME_PATH start" >> $LOGFILE
case "$MM_ACTUAL_JOB_NAME_PATH" in
  "/jn0006/jn1/jn11/j111" ) 
    sleep ${J111_SLEEP:=0} 
    if [ "$J111_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn1/jn11/j112" ) 
    sleep ${J112_SLEEP:=0} 
    if [ "$J112_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn1/jn11/finally/jn11_f" ) 
    sleep ${JN11_F_SLEEP:=0} 
    if [ "$JN11_F_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn1/j12" ) 
    sleep ${J12_SLEEP:=0} 
    if [ "$JN12_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn1/finally/jn1_f" ) 
    sleep ${JN1_F_SLEEP:=0} 
    if [ "$JN1_F_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn2/j21" ) 
    sleep ${J21_SLEEP:=0} 
    if [ "$JN21_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn2/jn22/j221" ) 
    sleep ${J221_SLEEP:=0} 
    if [ "$J221_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn2/jn22/j222" ) 
    sleep ${J222_SLEEP:=0} 
    if [ "$J222_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn2/jn22/finally/jn22_f" ) 
    sleep ${JN22_F_SLEEP:=0} 
    if [ "$JN22_F_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/jn2/finally/jn2_f" ) 
    sleep ${JN2_F_SLEEP:=0} 
    if [ "$JN2_F_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
  "/jn0006/finally/finally/jn_f" ) 
    sleep ${JN_F_SLEEP:=0} 
    if [ "$JN_F_FAIL" = "true" ] ; then
      exit 1
    fi
    ;;
esac

echo "`date` tengine_job_test $MM_ACTUAL_JOB_NAME_PATH finish" >> $LOGFILE