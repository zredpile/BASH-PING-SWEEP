#!/bin/bash
# script by Mohammed Almoghazy
#

#first get current ip and network mask
ipvar=$( sudo ifconfig | grep -iw 'inet'| grep broadcast| cut -d " " -f 10)
mask=$( sudo ifconfig | grep -iw 'inet'| grep broadcast| cut -d " " -f 13)
echo
echo
echo "This script will automatically detect your local IP and ping your local network "
echo 
echo "the script will ping the local network for the IP : $ipvar  with  subnet mask : $mask "
echo
echo " by Mohammed Almoghazy "
echo
echo "-------------------------------------------------------------------------------------"
# function to extract parts of the ip address
get-field-from-ip () {
# parameter $1 is the  ip
# parameter $2 is the required field


fieldvalue=$(echo $1|cut -d "." -f $2 ) 

x=$fieldvalue
echo $x

}

#-----------------------------
#function to form the range of ips based on the required field according to  network mask
get-range-for-field () {

fieldx=$(get-field-from-ip $ipvar $1)
fieldmask=$(get-field-from-ip $mask $1)
if [ $fieldmask -eq 0 ]
then
  echo "1 255"
else
  echo "$fieldx $fieldx"
fi

}

#------------------------
# get sequence for each part of the ip
seq0=$(get-range-for-field 1)
seq1=$(get-range-for-field 2)
seq2=$(get-range-for-field 3)
seq3=$(get-range-for-field 4)

for f0 in $(seq $seq0)
do
	for f1 in $(seq $seq1)
        do
		for f2 in $(seq $seq2)
		do
			for f3 in $(seq $seq3)
			do
				ipx=$f0.$f1.$f2.$f3 # this is the full formed ip 
				ping -c 1 -q $ipx  #ping only one packet for testing
			done
		done
	done
done 


