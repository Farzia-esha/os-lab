#!/bin/bash

read -p "Enter total memory size: " total
read -p "Enter block size: " block

blocks=$((total / block))
echo "Number of blocks: $blocks"

read -p "Enter number of processes: " p

internal=0
used=0
mem=()

for ((i=1; i<=p; i++)); do
    read -p "Memory required for P$i: " mem[i]
done

echo -e "\nPROCESS   MEM_REQ   ALLOCATED   INT_FRAG"

for ((i=1; i<=p && used<blocks; i++)); do
    if [ ${mem[i]} -le $block ]; then
        frag=$((block - mem[i]))
        internal=$((internal + frag))
        used=$((used+1))
        echo "P$i        ${mem[i]}        YES        $frag"
    else
        echo "P$i        ${mem[i]}        NO         -----"
    fi
done

for ((; i<=p; i++)); do
    echo "P$i        ${mem[i]}        NO         -----"
done

external=$((total - used*block))
echo -e "\nTotal Internal Fragmentation: $internal"
echo "Total External Fragmentation: $external"
