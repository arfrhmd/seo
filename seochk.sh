#!/bin/bash
# DA & PA Checker
# Coded by Arif Rahmadi W

hijau='\e[38;5;85m' # HIJAU
merah='\e[38;5;196m' # MERAH
c='\e[38;5;121m' # CYAN
c2='\e[38;5;122m' # CYAN 2
c3='\e[38;5;123m' # CYAN 3
nc='\033[0m' # DEFAULT
useragent="Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

function check(){
	sites=$1;
	url="https://smallseotools.com/ajexdomain-authority-checker";
	header=("X-Requested-With: XMLHttpRequest" "Content-Type: application/x-www-form-urlencoded; charset=UTF-8");
	getData=$(curl -s -A "$useragent" -X POST -H "${header[0]}" -H "${header[1]}" --data-urlencode "urls=${sites}" "$url" > data.tmp);
	DA=$(cat data.tmp | jq .data[0].domain_auth | sed 's:"::g');
	PA=$(cat data.tmp | jq .data[0].page_auth | sed 's:"::g');
	if [[ -z data.tmp ]];then
		echo -e "${merah}Failed to get data\n";
		exit 0;
	else
		echo -e "${c}[INFO] Site : $sites";
		echo -e "${c2}[INFO] DA   : $DA";
		echo -e "${c3}[INFO] PA   : $PA";
		echo -e "[$(date '+%x %X')]\nSite : $sites\nDA   : $DA\nPA   : $PA\n" >> result_seo.txt
	fi
}
clear
printf "${hijau}"
cat << "banner"
 ___ ___ ___   ___ _           _           
/ __| __/ _ \ / __| |_  ___ __| |_____ _ _ 
\__ \ _| (_) | (__| ' \/ -_) _| / / -_) '_|
|___/___\___/ \___|_||_\___\__|_\_\___|_|  

     Format list : www.example.com

banner
printf "${nc}";
echo -n "Input list : "; read list;
echo " ";
for chk in $(cat $list)
do
	check $chk;
	echo " ";
done
printf "${nc}"
# EOF