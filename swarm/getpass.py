#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

from random import choice
from sys import argv
from string import upper

passlen = 8
if len(argv[1:])>0:
	try:
		passlen = int(argv[1])
	except:
		print('Set password length as argument')
		exit(1)

abc = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
abcupper = map(upper, abc)
numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

abc = abc + abcupper +numbers

temppass = ''

for c in xrange(0,passlen):
	temppass = temppass + choice(abc)

print(temppass)
exit(0)
