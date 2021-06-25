#!/bin/bash
read -p "Introdu adresa IP: " ip

function severifica()
{
	ip="$1"
	tipar='^([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)$'
	#IF THE IP DOES NOT MATCH THE PATTERN GIVEN BY OUR REGEX CODE
	if [[ ! $ip =~ $tipar ]]
	then
		echo "adresa IP invalida [$ip]"
		return 1
	fi

	for i in {1..4}
	do
		#BASH_REMATCH IS AN ARRAY VARIABLE ASSIGNED BY OUR BINARY OPERATOR "=~" TO OUR CONDITION "if[[ $... ]]
		#denies octets greater than 255
		if [[ ${BASH_REMATCH[$i]} -gt 255 ]] 
		then
			echo "octet invalid [${BASH_REMATCH[$i]}] in [$ip]"
			return 1
		fi
	done
	#denies first octet to be 0
	if [[ ${BASH_REMATCH[1]} -eq 0 ]]
	then
		echo "primul octet nu poate fi 0 in [$ip]"
		return 1
	fi
	
	echo "adresa IP validata [$ip]"
	return 0

}
#if everything in our function checks out 
if severifica $ip; then 
	ping -c 4 $ip
	if [ $? -eq 0 ]; then
		echo "Masina este disponibila."
	else
		echo "Masina nu este disponibila."
	fi
fi

