#!/bin/bash
#diskspace(){
#  clear; df -k
#}
#who_logged_in(){
#  clear; who
#}
#memusage(){
#  clear; cat /proc/meminfo
#}
#menu(){
#  clear
#  echo -e "\t\t\tSys Admin Menu\n"
#  echo -e "\tSelect an Option"
#  echo -e "\t1. Display disk space"
#  echo -e "\t2. Display logged-in users"
#  echo -e "\t3. Display memory usage"
#  echo -e "\t0. Exit program\n\n"
#  echo -en "\t\tEnter Option: "
#  read -n1 option
#}

#while [ 1 ]
#do
#  menu
#  case "$option" in
#  0)
#    break;;
#  1)
#    diskspace;;
#  2)
#    who_logged_in;;
#  3)
#    memusage;;
#  *)
#    echo " Sorry, wrong selection";;
#  esac
#  echo -en "\n\n\t\t\tHit any key to continue"
#  read -n1 line
#done
#clear

# use the select command to display menu. Note: set PS3 variable
#PS3="Enter Option: "
#select option in "Display disk space" "Display logged in users" "Display memory usage" "Exit Program"
#do
# case $option in
#  "Exit Program")
#  break ;;
#  "Display disk space")
#  diskspace;;
#  "Display logged in users")
#  who_logged_in;;
#  "Display memory usage")
#  memusage;;
#  *)
#    echo "Sorry, wrong selection";;
#  esac
#done

#Install & use the dialog package
#temp=$(mktemp -t test.XXXXXX)
#temp2=$(mktemp -t test2.XXXXXX)
#diskspace(){
#  df -k > $temp
#  dialog --textbox $temp 20 60
#}
#who_logged_in(){
#  who > $temp
#  dialog --textbox $temp 20 50
#}
#memusage(){
#  cat /proc/meminfo > $temp
#  dialog --textbox $temp 20 50
#}
#while [ 1 ]
#do
#  dialog --menu "System Admin Menu" 20 30 10 1 "Display Disk Space" 2 \
#  "Display Users" 3 "Display memory usage" 0 "Exit" 2> $temp2
#  if [ $? -eq 1 ]
#  then
#    break
#  fi
#
#  selection=$(cat $temp2)
#
#  case $selection in
#  1)
#    diskspace;;
#  2)
#    who_logged_in;;
#  3)
#    memusage;;
#  0)
#    break;;
#  *)
#    dialog -msgbox "Sorry, Invalid Selection" 10 30
#  esac
#done
#rm -f $temp 2> /dev/null
#rm -f $temp2 2> /dev/null

# The Zenity package
temp=$(mktemp -t test.XXXXXX)
temp2=$(mktemp -t test2.XXXXXX)
diskspace() {
  df -k > $temp
  zenity --text-info --title "Disk Space" --filename=$temp --width 750 --height 10
}
who_logged_in(){
  who > $temp
  zenity --text-info --title "Logged in users" --filename=$temp --width 500 --height 10
}
memusage(){
  cat /proc/meminfo
  zenity --text-info --title "Memory Usage" --filename=$temp --width 300 --height 500
}
while [ 1 ]
do
  zenity --list --radiolist --title "Sys Admin Menu" --column "Select" column "Menu Item" FALSE \
  "Display diskspace" FALSE "Display users" FALSE "Display memory usage" FALSE "Exit" > $temp2
  if [ $? -eq 1 ]
  then
    break
  fi

  selection=$(cat $temp2)

  case $selection in
  "Display disk space")
    diskspace;;
  "Display users")
    who_logged_in;;
  "Display memory usage")
    memusage;;
  "Exit")
    break;;
  *)
    zenity -info "Sorry, Invalid Selection"
  esac
done
rm -f $temp 2> /dev/null
rm -f $temp2 2> /dev/null