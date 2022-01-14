#!/usr/bin/env bash
# Gunakan dengan bijak
# Tools boleh untuk di pelajari tapi tidak di recode!!

# colors
esc="\x1b"
a="${esc}[1;90m"
r="${esc}[1;31m"
g="${esc}[1;32m"
y="${esc}[1;33m"
b="${esc}[1;34m"
u="${esc}[1;35m"
c="${esc}[1;36m"
w="${esc}[1;37m"
n="${esc}[0;00m"
o="${esc}[1;38;5;208m"
ba="${esc}[90;7m"
br="${esc}[91;7m"
bg="${esc}[92;7m"
by="${esc}[93;7m"
bb="${esc}[94;7m"
bu="${esc}[95;7m"
bc="${esc}[96;7m"
bw="${esc}[97;7m"
bo="${esc}[98;5;208;7m"
dependencies() {
	JQ=$( which jq > /dev/null 2>&1; echo $?)
	if [[ $JQ -ne 0 ]]; then
		apt install jq -y &> /dev/null || { echo >&2 "Please Check Your Connecting"; exit; }
	fi
	CURL=$(which curl > /dev/null 2>&1; echo $?)
	if [[ $CURL -ne 0 ]]; then
		apt install curl -y &> /dev/null || { echo >&2 "Please Check Your Connecting"; exit; }
	fi
	PV=$(which pv > /dev/null 2>&1; echo $?)
	if [[ $PV -ne 0 ]]; then
		apt install pv -y &> /dev/null || { echo >&2 "Please Check Your Connecting"; exit; }
	fi
}
sltinyurl() {
	echo -ne "\n ${b}[${o}+${b}] ${n}Enter To Website : "
	read web
	link=$( curl -Gs -d "url=${web}" "http://tinyurl.com/api-create.php" )
	printf "\n"
	echo -e " ${y}[${r}+${y}] ${b}============================== ${y}[${r}+${y}]"
	echo -e "  ${c}[${b}+${c}] ${g}Link ${r}: ${w}${web}${n}"
	echo -e "  ${c}[${b}+${c}] ${g}Result ${r}: ${w}${link}${n}"
	echo -e " ${y}[${r}+${y}] ${b}============================== ${y}[${r}+${y}]"
}
about() {
	echo -e "\t\t   ${g}About${n}" | pv -qL 8
	echo -e "\t${n}---------------------------" | pv -qL 15
	echo -e "\t ${w}Nama ${g}: ${n}Shortlink Tinyurl" | pv -qL 8
	echo -e "\t ${w}Author ${g}: ${n}Wanz Xploit" | pv -qL 8
	echo -e "\t ${w}Version ${g}: ${n}1.0.0" | pv -qL 8
	echo -e "\t ${w}Team ${g}: ${n}Black Dragons Hunter" | pv -qL 8
	echo -e "\t ${w}Date ${g}: ${n}15 - 1 - 2022" | pv -qL 8
	printf "\n"
	echo -ne "    ${b}[${n}B${b}]${n}ack ${w}Or ${b}[${n}E${b}]${n}xit : "
	read back
	if [[ $back == "b" ]] || [[ $back == "B" ]]; then
		bash $0
	else
		clear
		echo -e "Bye :)"
	fi
}
banner() {
	echo -e ""
	echo -e "${r}______                         _
|_   _(_)_ __  _   _ _   _ _ __| |
  | | | | '_ \| | | | | | | '__| |
  | | | | | | | |_| | |_| | |  | |
  |_| |_|_| |_|\__, |\__,_|_|  |_|
               |___/"
	echo -e "${n}____________________________________________"
	echo -e "  ${g}[${w}+${g}] ${n}Tools Short link Create By \e[4m${c}Wanz Xploit${n} "
	echo -e "  ${g}[${w}+${g}] ${n}Thanks to Black Dragons Hunter"
	echo -e "${n}————————————————————————————————————————————\n"
}
main() {
	clear # clear screen
	if [[ -e data ]]; then
		rm -rf data
	fi
	dependencies # call function dependencies
	banner # call function banner
	Menu=( "Shortlink" "About" "Exit" )
	count=1
	for menu in "${Menu[@]}"; do
		echo -e "\t${c}[${w}${count}${c}] ${o}${menu}"
		count=$(( $count + 1 ))
	done
	echo
	echo -ne "    ${g}[${w}+${g}] ${n}Choice : "
	read input
	if ! [[ $input -eq $input ]]; then
		printf "\n"
		echo -e " ${w}[[ ${r}! ${w}]] ${r}ERROR ${y}: ${r}Enter number!${n}"
		sleep 2
		bash $0
	elif [[ $input -eq 1 ]]; then
		sltinyurl
	elif [[ $input -eq 2 ]]; then
		about
	elif [[ $input -eq 3 ]]; then
		clear
		echo -e "Bye :)"
	else
		printf "\n"
		echo -e " ${w}[[ ${r}! ${w}]] ${r}ERROR ${y}: ${r}Wrong Input${n}"
		sleep 2
		bash $0
	fi
}
[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
