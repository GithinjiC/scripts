#!/bin/bash
if pwd; then
  echo "It worked"
fi

if NotCommand; then
  echo "It worked"
fi
echo "Outside if statement"

#user=$USER
user=NoUser
if grep $user /etc/passwd
then
  echo "$user exists on this system"
elif ls -d /home/$user
then
  echo "$user doesn't exist but has a home dir"
else
  echo -n "$user doesn't exists in this system. "
  echo "And $user doesnt have a home dir"
fi

#One way to test conditions: using the test command
if test $user
then
  echo "The variable expression returns True"
else
  echo "The variable expression returns False"
fi

# Another way to test conditions: use square brackets
# Will evaluate numeric, string and file comparisons
# Cannot use floating-point values for test conditions
# Use double parentheses to use additional mathematical operators and pattern matching
value1=20
value2=15
value3=25
if [ $value1 -eq $value2 ]
then
  echo "The variables are equal"
elif [ $value1 -lt $value2 ] || [ $value3 -gt $value2 ]
then
  echo "Value1 is less than value2 & value3 greater than value2"
elif [ $value1 -gt $value2 ] && [ $value3 -gt $value1 ]
then
  echo "Value1 is greater than value2 & value3 greater than value1"
fi

#Using < or > bash interprets it as output redirection
#these have to be escaped as \>, \<
val1=a
val2=B
if [ $val1 \> $val2 ]
then
  echo "$val1 is greater than $val2"
else
  echo "$val1 is less than $val2"
fi
if [ -n $val1 ] #check if non-zero in length
then
  echo "the variable is not empty"
else
  echo "the variable is empty"
fi

states_file="states"
# define IFS(internal field separator)
IFS_OLD=$IFS
#Use the old value of IFS to return to default
#IFS=$'\n':;" to use multiple separators(newline, colon, semicolon, double quotes)
# Pipe output to sort
IFS=$'\n'
for state in `(cat $states_file)`
do
  echo "Visit $state"
done | sort

IFS=$IFS_OLD

# C style for command
for (( a=0, b=10; a<=10, b>=0; a++, b-- ))
do
  echo "The numbers are $a and $b"
done

# While loop using multiple test commands
# exit status of last test command det when loop stops
var1=10
while echo $var1
        [ $var1 -ge 0 ]
do
  echo "This is inside the loop"
  var1=$[ $var1 - 1 ]
done

# Until loop with multiple test commands
# exit status of last test command det when loop stops
var1=100
until echo $var1
[ $var1 -eq 0 ]
do
  echo This is inside the loop: $var1
  var1=$[ $var1 - 25 ]
done

#IFS_OLD=$IFS
#IFS=$'\n'
#for entry in `cat /etc/passwd`
#do
#  echo "Values in $entry -"
#  IFS=:
#  for value in $entry
#  do
#    echo "  $value"
#  done
#done
#IFS=$IFS_OLD

# Processing the output of a loop
for file in /home/lilith/*
do
  if [ -d $file ]
  then
    echo "$file is a dir"
  else
    echo "$file is a file"
  fi
done > output.txt