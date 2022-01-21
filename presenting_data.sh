#!/bin/bash
# run below using `/.sh 2> error_msg` capture errors msgs
# use exec for permanent redirection
# 0 rep stdin --> 1 rep stdout --> 2 rep stderr
# exec 1> all_text
#exec 2> error_msgs
#echo "Welcome"
#echo "This is an error" >&2
#echo "This is normal output"

# Redirecting Input, Creating Input file descriptor
exec 6<&0
exec 0< states
count=1
while read line
do
  echo "Line #$count: $line"
  count=$[ $count + 1 ]
done
exec 0<&6
read -p "Are you done now?" answer
case $answer in
Y|y) echo "Goodbye";;
N|n) echo "End";;
esac
# Creating Redirection
exec 3>> test3out
echo "On monitor"
echo "Output to test3out file" >&3
echo "On monitor"

#lsof command to get FDs for current PID $$
lsof -a -p $$ -d 0,1,2,3,4,5,6,7
# To close a file descriptor redirect to &-
# i.e exec 3>&-

# Create a temp file in a local dir use `mktemp testing.XXXXXX`
# the -t forces mktemp to create in /tmp
tempfile=$(mktemp -t testing.XXXXXX)
exec 3> $tempfile
echo "Temp file: $tempfile"
echo "First line" >&3
echo "Second line" >&3
echo "Third line" >&3
exec 3>&-
cat $tempfile
#rm -f $tempfile 2> /dev/null
echo "Removing $tempfile"
rm -f $tempfile

# the -d option to mktemp creates a temp dir
tempdir=$(mktemp -d dir.XXXXXX)
cd $tempdir
tempfile1=$(mktemp temp.XXXXXX)
tempfile2=$(mktemp temp.XXXXXX)
exec 7> $tempfile1
exec 8> $tempfile2
echo "Tempdir: $tempdir"
echo "Test line for $tempfile1" >&7
echo "Test line for $tempfile2" >&8
echo "Removing $tempdir"; cd ..; rm -rf $tempdir

# Using the tee command for logging and output display
# use tee -a to append
tempfile=teetestfile
echo "Start of tee" | tee $tempfile
echo "Second of tee" | tee -a $tempfile
echo "End of tee" | tee -a $tempfile