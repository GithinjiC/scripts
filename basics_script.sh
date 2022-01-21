#!/bin/bash

# To show each command that run use set -x
# set -x

# Single quotes interpret the text literally
echo '$HOME *** $(date)'
echo "$HOME *** `date`"

#Assigning command output to variables
today=`date`
also_today=$(date +%y%m%d)
echo "Today: $today"; echo "Also today: $also_today"

#inline input redirection
wc << EOF
test string 1
test string 2
test string 3
EOF

#Using bash calc >> bc
var1=$(echo "scale=4; 3.44 / 5" | bc)
echo The answer is $var1
var2=43.67
var3=33.2
var4=70
var5=$(bc << EOF
scale=4
a1 = ($var1 * $var2)
b1 = ($var3 * $var4)
a1 + b1
EOF
)
echo The answer to this mess is $var5
exit

echo "First argument $1. Second argument $2."
echo "The command itself is $0"
# $0, $1...$n
# $# variable-->how many parameters given to script
# $@ variable-->takes all params as a separate words in the same string
# S* variable-->takes all params as a single word
# $? variable--> receives exit status of the last command executed
# ${!#} variable--> gets the last parameter

read -p "Enter two spaced numbers: " Name Age
if [ $# -lt 2 ]; then
  echo "Need two spaced arguments. "
else
  TOTAL=`expr $Name + $Age`; echo "TOTAL: $TOTAL"
fi

# Use one line if statements with || and &&--> help test
dirname=/home/lilith/Documents/ansible/script/
[ -e $dirname ] && echo $dirname already exists || mkdir $dirname

# Use square brackets instead of expr
BIGNUM=1024
let RESULT=$BIGNUM/16; echo $RESULT
RESULT=`expr $BIGNUM / 16` ; echo $RESULT
RESULT=`echo "$BIGNUM / 16" | bc`; echo $RESULT
let foo=$RANDOM; echo $foo
echo $((++foo)); echo $((--foo))

VARIABLE=1
if [ $VARIABLE -eq 1 ]; then
  echo "The variable is 1"
fi

STRING=$HOME
if [ $STRING = "/home/lilith" ]; then
  echo $RANDOM
else
  echo $HOME
fi

filename="/home/lilith/Documents/ansible/script.sh"
if [ -f "$filename" ]; then
    echo "$filename is a regular file"18
elif [ -d "$filename" ]; then
    echo "$filename is a directory"
else
  echo "No clue what it is"
fi

case `date +%a` in
  "Mon")
    echo "Monday"
#    BACKUP='/home/lilith/Documents/ansible/script.sh'
#    TAPE=/dev/rft0
  ;;
  "Tue" | "Thu")
    echo "Its either Tue or Thur"
  ;;
  "Wed" | "Fri")
    echo "Its either Wed or Fri"
  ;;
  *)
    echo "Its the weekend"
  ;;
esac

for NUM in 0 1 2 3 4 5 6; do
  echo $NUM
done

N=42
while [ $N -le 45 ]; do
  echo "Number is less than 45"
  let N=$N+1
done

#M=0
#until [ $M -eq 3]; do
#  echo -n $M
#  let M=$M+1
#done