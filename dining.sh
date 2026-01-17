#!/bin/bash

read -p "Enter total philosophers: " n
read -p "How many are hungry: " h

hungry=()
for ((i=0; i<h; i++)); do
    read -p "Enter philosopher $((i+1)) position: " hungry[$i]
done

while true; do
    echo -e "\n1.One can eat\t2.Two can eat\t3.Exit"
    read -p "Enter choice: " choice

    case $choice in
        1) limit=1 ;;
        2) limit=2 ;;
        3) echo "Exiting..."; exit ;;
        *) echo "Invalid choice"; continue ;;
    esac

    chopstick=()
    done=()
    for ((i=1; i<=n; i++)); do
        chopstick[$i]=1
        done[$i]=0
    done

    total_done=0
    while [ $total_done -lt $h ]; do
        granted=0
        for p in "${hungry[@]}"; do
            if [ ${done[$p]} -eq 1 ]; then
                continue
            fi
            r=$(( (p % n) + 1 ))
            if [ $granted -ge $limit ]; then
                echo "P $p is waiting"
            elif [ ${chopstick[$p]} -eq 1 ] && [ ${chopstick[$r]} -eq 1 ]; then
                chopstick[$p]=0
                chopstick[$r]=0
                echo "P $p is eating"
                chopstick[$p]=1
                chopstick[$r]=1
                done[$p]=1
                total_done=$((total_done+1))
                granted=$((granted+1))
            else
                echo "P $p is waiting"
            fi
        done
        if [ $granted -eq 0 ]; then
            echo "Deadlock! Stopping..."
            break
        fi
    done
done
