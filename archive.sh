#!/bin/bash
# Archive designated files and dirs daily
DATE=`date +%y%m%d`
FILE=archive$DATE.tar.gz
CONFIG_FILE=archive/Files_to_backup
DESTINATION=archive/$FILE
# Check backup config file exists
if [ -f $CONFIG_FILE ]
then
  echo
else
  echo "$CONFIG_FILE does not exist."
  echo "Backup incomplete"
  exit
fi

FILE_NO=1               # Line 1 of Config file
exec < $CONFIG_FILE     # Redirect STDIN to name of Config file
read FILE_NAME
while [ $? -eq 0 ]
do
  if [ -f $FILE_NAME -o -d $FILE_NAME ]
  then
    # if file exists, add it to the list
    FILE_LIST="$FILE_LIST $FILE_NAME"
  else
    echo "$FILE_NAME, does not exist."
    echo "It is listed on line $FILE_NO of the config file"
    echo "Continuing..."
  fi
  FILE_NO=$[$FILE_NO + 1] # inc line/file number by one
  read FILE_NAME  # read next record
done
echo "Starting archive..."
tar -czf $DESTINATION $FILE_LIST 2> /dev/null
echo "Archive completed"
echo "Resulting archive file is: $DESTINATION"
exit