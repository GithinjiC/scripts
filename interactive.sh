#!/bin/bash
#factorial=1
#for (( number=1; number<=$1; number++ ))
#do
#  factorial=$[ $factorial * $number ]
#done
#echo The factorial of $1 is $factorial

# create symbolic links to various file names
name=`basename $0`
if [ $name = "cos" ]
then
  total=$[ $1 + $2 ]
  echo $total
elif [ $name = "ken" ]
then
  total=$[ $1 - $2 ]
  echo $total
elif [ $name = "ben" ]
then
  total=$[ $1 * $2 ]
  echo $total
else
  echo "name required"
fi

# the shift command/multi-shift command
#count=1
#while [ -n "$1" ]
#do
#  echo "Parameter #$count = $1"
#  count=$[ $count + 1 ]
#  shift
#done

# Separating options from parameters
# bash--> ./script.sh -c -a -b -- param1 param2 param3
# bash uses double dash to separate options from parameters
# getopt command
#set - $(getopt -q ab:cd "$@")
#while [ -n "$1" ]
#do
#  case "$1" in
#  -a)
#    echo "Found the -a option";;
#  -b) param="$2"
#    echo "Found the -b option, with parameter value $param"
#    shift;;
#  -c)
#    echo "Found the -c option";;
#  --)
#    shift
#      break;;
#  *)
#    echo "$1 is not an option";;
#  esac
#  shift
#done
#echo $1 $2
#count=1
#for param in $@
#do
#  echo "Parameter #$count: $param"
#  count=$[ $count + 1 ]
#done
#set -x
# getopts command
if [ $# -lt 5 ]
then
  echo $#
  echo "Usage: interactive.sh -a -b value -c -d [optional parameters]"
  exit
else
  while getopts :ab:c:d opt
  do
    case "$opt" in
    a) echo "Found the -a option";;
    b) echo "Found the -b option, with value $OPTARG";;
    c) echo "Found the -c option, with value $OPTARG";;
    d) echo "Found the -d option";;
    *) echo "Unknown option: $opt";;
    esac
  done
fi
echo $opt
echo $OPTIND
shift 4
echo $@
echo $#
shift $[ $OPTIND - 1 ]
count=1
for param in "$@"
do
  echo "Parameter $count: $param"
  count=$[ $count + 1 ]
done

#user input
# read without variable names--->$REPLY
read -t 5 -p "Enter name: "; echo "Data for $REPLY"
read -s -p "Enter pssd: "; echo
echo $REPLY

read -n1 -p "Continue[Y/N]?" answer
case $answer in
Y | y) echo
  echo "Yes";;
N | n) echo
  echo "No";;
*)
  echo "Enter N or Y"
esac
echo "End"

count=1
cat states | while read line
do
  echo "Line $count: $line"
  count=$[ $count + 1 ]
done
echo "End"