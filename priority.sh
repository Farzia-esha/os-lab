#!/bin/bash

echo -n "Enter the number of processes -- "
read n

declare -a BT PR PID WT TAT

# Input burst time and priority
for (( i=0; i<n; i++ ))
do
    echo -n "Enter the Burst Time & Priority of Process $i --- "
    read BT[i] PR[i]
    PID[i]=$i
done

# Sort based on priority (lower number = higher priority)
for (( i=0; i<n-1; i++ ))
do
    for (( j=i+1; j<n; j++ ))
    do
        if (( PR[i] > PR[j] ))
        then
            # Swap priority
            temp=${PR[i]}
            PR[i]=${PR[j]}
            PR[j]=$temp

            # Swap burst time
            temp=${BT[i]}
            BT[i]=${BT[j]}
            BT[j]=$temp

            # Swap process ID
            temp=${PID[i]}
            PID[i]=${PID[j]}
            PID[j]=$temp
        fi
    done
done

WT[0]=0
TAT[0]=${BT[0]}
totalWT=0
totalTAT=${TAT[0]}

# Calculate WT and TAT
for (( i=1; i<n; i++ ))
do
    WT[i]=$(( WT[i-1] + BT[i-1] ))
    TAT[i]=$(( WT[i] + BT[i] ))
    totalWT=$(( totalWT + WT[i] ))
    totalTAT=$(( totalTAT + TAT[i] ))
done

echo -e "\nOUTPUT\n"
echo -e "PROCESS\tPRIORITY\tBURST TIME\tWAITING TIME\tTURNAROUND TIME"
for (( i=0; i<n; i++ ))
do
    echo -e "${PID[i]}\t${PR[i]}\t\t${BT[i]}\t\t${WT[i]}\t\t${TAT[i]}"
done

avgWT=$(echo "scale=6; $totalWT / $n" | bc)
avgTAT=$(echo "scale=6; $totalTAT / $n" | bc)

echo -e "\nAverage Waiting Time is --- $avgWT"
echo -e "Average Turnaround Time is --- $avgTAT"
