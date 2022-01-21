# create functions
# Use return to exit a function defined exit code
my_func(){
  read -p "Enter a value: " value
  echo "Doubled value: $[ $value * 2 ]"
  return $[ $value * 2 ]
}
#count=1
#while [ $count -lt 5 ]
#do
#  my_func
#  count=$[ $count + 1 ]
#done
#echo "End"
my_func
echo "Exit status is $?"
function_output=$(my_func)
echo "Function output is: '$function_output'"

# Passing parameters to functions
passing_params(){
  if [ $# -eq 0 ] || [ $# -gt 2 ]
  then
    echo -1
  elif [ $# -eq 1 ]
  then
    echo $[ $1 + $1 ]
  else
    echo $[ $1 + $2 ]
  fi
}
echo -n "Adding two integers: "
value=$(passing_params 10 15)
echo $value
echo -n "Adding one number: "
value=$(passing_params 10)
echo $value
echo -n "Adding three numbers: "
value=$(passing_params 10 15 20)
echo $value

# To use shell variables, pass as parameters to function
params_func(){
  echo $[ $1 * $2 ]
}
if [ $# -eq 2 ]
then
  value=$(params_func $1 $2)
  echo "The value is: $value"
else
  echo "Usage: $0 a b"
fi

#use the local keyword to separate global and local variables esp in functions
# remove local keyword to test
demo_local_var(){
  local temp=$[ $value * 5 ]
  result=$[ $temp * 2 ]
}
temp=4
value=6
demo_local_var
echo The result is $result
if [ $temp -gt $value ]
then
  echo "temp is greater than value"
else
  echo "temp is smaller than value"
fi

# use variables as an array
test_array(){
  local new_array=($(echo "$@"))
  local orig_array=($(echo "$@"))
  local elements=$[ $# - 1 ]
  local i
#  local sum=0
#  for value in ${new_array[*]}
#  do
#    sum=$[ $sum + $value ]
#  done
#  echo $sum
  for (( i=0; i<=$elements; i++ ))
  {
    new_array[$i]=$[ ${orig_array[$i]} * 2 ]
  }
  echo ${new_array[*]}
}
my_array=(1 2 3 4 5)
echo "Original array: ${my_array[*]}"
arg1=$(echo ${my_array[*]})
result=($(test_array $arg1))
echo "The new array is ${result[*]}"

# use the source command to use function library files
# revisit Shtool library files
. ./myfuncs
value1=10
value2=5
result1=`addem $value1 $value2`
result2=$(multem $value1 $value2)
result3=$(divem $value1 $value2)
echo "Result1: $result1"
echo "Result2: $result2"
echo "Result3: $result3"

shtool platform
