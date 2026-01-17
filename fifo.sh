#!/bin/bash
# FIFO Page Replacement Algorithm

echo "Enter number of frames:"
read f
echo "Enter number of pages:"
read n
echo "Enter the page reference string:"
for ((i=0; i<n; i++))
do
  read pages[$i]
done

frames=()
faults=0
index=0

for ((i=0; i<n; i++))
do
  page=${pages[$i]}
  found=0
  for frame in "${frames[@]}"; do
    if [ "$frame" == "$page" ]; then
      found=1
      break
    fi
  done
  if [ $found -eq 0 ]; then
    if [ ${#frames[@]} -lt $f ]; then
      frames+=($page)
    else
      frames[$index]=$page
      index=$(((index+1)%f))
    fi
    faults=$((faults+1))
  fi
  echo "Frames after page $page : ${frames[@]}"
done

echo "Total Page Faults: $faults"
