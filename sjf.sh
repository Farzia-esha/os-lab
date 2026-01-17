#!/bin/bash

echo -n "Enter number of processes: "
read n

declare -a PID BT WT TAT

# Initialize PID
for ((i=0; i<n; i++))
do
    PID[i]=$i
done

# Input BT
for ((i=0; i<n; i++))
do
    echo -n "Enter the BT for P$((i)): "
    read BT[i]
done

# Sorting processes by BT (SJF)
for ((i=0; i<n-1; i++))
do
    for ((j=i+1; j<n; j++))
    do
        if [ ${BT[i]} -gt ${BT[j]} ]; then
            # Swap BT
            temp=${BT[i]}
            BT[i]=${BT[j]}
            BT[j]=$temp
            # Swap PID
            temp=${PID[i]}
            PID[i]=${PID[j]}
            PID[j]=$temp
        fi
    done
done

# Calculate WT
WT[0]=0
for ((i=1; i<n; i++))
do
    WT[i]=$((WT[i-1] + BT[i-1]))
done

# Calculate TAT
for ((i=0; i<n; i++))
do
    TAT[i]=$((WT[i] + BT[i]))
done

# Display table
echo -e "\nProcess\tBT\tWT\tTAT"
total_WT=0
total_TAT=0
for ((i=0; i<n; i++))
do
    echo -e "P${PID[i]}\t${BT[i]}\t${WT[i]}\t${TAT[i]}"
    total_WT=$(( total_WT + WT[i] ))
    total_TAT=$(( total_TAT + TAT[i] ))
done

# Calculate averages
avg_WT=$(echo "scale=2; $total_WT / $n" | bc)
avg_TAT=$(echo "scale=2; $total_TAT / $n" | bc)

echo -e "\nAverage Waiting Time = $avg_WT"
echo "Average Turnaround Time = $avg_TAT"
