subtotal=0
while read line
do
	if echo "$line" | grep -q -E ",,[^,[:digit:]\.]"
	then
		echo "$line,Total,Average"
	elif $(echo "$line" | grep -q -E "^[^,]*,[^,]*,")
	then
		total=$(echo "$line" | sed -r 's/^,[^,]*,//' | sed 's/,/+/g' | bc)
		N=$(echo -n "$line" | sed -r 's/^[^,]*,[^,]*//' | sed 's/[^,]//g' | wc -c)
		avg=$(echo "$total/$N" | bc)
		echo "$line,$total,$N,$avg"
		subtotal=$(echo "$subtotal+$total" |bc)
	else
		if echo "$line" | grep -q "^$"
		then
			echo "subtotal: $subtotal"
			subtotal=0
		fi
		echo "$line"
	fi
done <$1
echo "subtotal: $subtotal"
