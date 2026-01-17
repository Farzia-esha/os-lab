#!/bin/bash

echo -n "enter the process num:"
read n

declare -a BT WT TAT

#enter burst time
for((i=0;i<n;i++))
do
	echo -n "enter burst time for P$((i)):"
	read BT[i]
done

#calculate WT TAT
WT[0]=0
TAT[0]=${BT[0]}

for((i=1;i<n;i++))
do
	WT[i]=$((WT[i-1]+BT[i-1]))
	TAT[i]=$((WT[i]+BT[i]))
done

#display

echo -e "\nProcess \t BT \t WT \t TAT"
totat_WT=0
total_TAT=0

for((i=0;i<n;i++))
do 
	echo -e "P$((i)) \t\t ${BT[i]} \t ${WT[i]} \t ${TAT[i]}"
	total_WT=$((total_WT+WT[i]))
	total_TAT=$((total_TAT+TAT[i]))
done

avg_WT=$(echo "scale=2; $total_WT/$n" |bc)
avg_TAT=$(echo "scale=2; $total_TAT/$n" |bc)

echo -e "avg WT= $avg_WT"
echo "avg TAT=$avg_TAT"
