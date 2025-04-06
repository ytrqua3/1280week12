#!/bin/bash
subtotal=0
while read line
do
	if echo "$line" | grep -q -E "^[^,]*,[^,]*,[[:digit:]]"; then
		total=$(echo "$line" | sed -r 's/^[^,]*,[^,]*,//' | sed -r 's/,/+/g' | bc)
		N=$(echo -n "$line" | sed -r 's/^[^,]*,[^,]*//' | sed 's/[^,]//g' | wc -c)
		avg=$(echo "scale=2; $total/$N" | bc)
		subtotal=$(echo $total+$subtotal | bc)
		echo $line,$total,$avg
	elif echo "$line" | grep -q -E "^[^,]*,[^,]*,"; then
		echo $line,Total,Average
	elif echo "$line" | grep -q -E "^$"; then
		echo Subtotal: $subtotal
	else
		echo $line
	fi
done <$1
echo SUbtotal: $subtotal
