#!/usr/bin/env bash


cat << EOF
    __ __ ___  _________    _   _____ 
   / //_//   |/_  __/   |  / | / /   |
  / ,<  / /| | / / / /| | /  |/ / /| |
 / /| |/ ___ |/ / / ___ |/ /|  / ___ |
/_/ |_/_/  |_/_/ /_/  |_/_/ |_/_/  |_|
                                        (Author: Killswxtch)
EOF

read -p "Enter Domain: " domain 
read -p "Enter Directory Name: " dir
read -p "Absolute Path (Wordlist): " wrdl


mkdir $dir 
cd $dir 
mkdir nmap gobuster nikto whois whatweb


whois $domain | tee whois/lookup.txt > /dev/null 2>&1&
whatweb $domain  -q --log-brief=whatweb/whatweb-log&
nmap -sC -sV -Pn -oN nmap/initial_scan $domain > /dev/null 2>&1&  
nmap -sC -sV -Pn -p- -oN nmap/all_ports_scan $domain > /dev/null 2>&1&
gobuster dir -u https://$domain -w $wrdl -o gobuster/gobuster_initial.log > /dev/null 2>&1&
gobuster dir -u https://$domain -w $wrdl -o gobuster/gobuster_big.log > /dev/null 2>&1&


nikto -h $domain -o nikto/initial.txt > /dev/null 2>&1&

echo -e "\nThis might take some time, You will be notified once the recon is completed."

wait    

echo -e "\nRecon Completed. Scans are ready to view."
tree


