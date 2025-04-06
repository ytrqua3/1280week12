#!/usr/bin/python3

import sys

subtotal=0

for line in sys.stdin:
	line=line.strip("\n")
	if line=="":
		print("Subtotal: ", subtotal)
		subtotal=0
	elif ',' not in line:
		print(line)
	else:
		tokens=line.split(",")
		total=0
		count=0
		isdataline=True
		for token in tokens[2:]:
			try:
				total=total+float(token)
				count+=1
			except ValueError:
				isdataline=False
			if not isdataline:
				quit
		if isdataline:
			average=round(total/count,2)
			print(line,",",total,",",average)
			subtotal+=total
		else:
			print(line + "," + "Total" + "Average")
