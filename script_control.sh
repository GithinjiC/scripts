#!/bin/bash
# the trap command
trap "echo ' Trapped Ctrl+C' " SIGINT
trap "echo 'Goodbye' " EXIT
count=1
echo "Script process ID: $$"
while [ $count -le 5 ]
do
  echo "Loop #$count"
  sleep 1
  count=$[ $count + 1 ]
done

trap "echo ' Modified Ctrl+C Trap' " SIGINT
new_count=1
while [ $new_count -le 5 ]
do
  echo "Loop #$new_count"
  sleep 1
  new_count=$[ $new_count + 1 ]
done
# to remove a set trap use two dashes
# remove trap
trap -- SIGINT
echo "Just removed the trap"
count=1
while [ $count -le 5 ]
do
  echo "Loop #$count"
  sleep 1
  count=$[ $count + 1 ]
done

# use nohup command to run script to completion in background
# even after shell exit
# all output is placed in nohup.out file

# the nice command(-20--highest priority to +19--lowest priority)
# the renice command allows you to specify the PID of a running process
# to change its priority

# Schedule when to execute a script with at command or cron command
# revisit the anacron program