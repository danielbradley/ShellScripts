#!/bin/bash
#
#	Usage: git-rename.sh <directory> <search> <replace>
#
#	e.g., git-rename.sh 3.1 6.1
#
#	Renames all files beginning with 3.1 so that 3.1 is replaced with 6.1.

dir=$1
search=$2
replace=$3
s="/$search"
r="/$replace"

if [ ! -d ${dir} ]
then
	echo "Error: not a directory - ${dir}"
	exit -1

elif [ -z "$search" ]
then
	echo "Error: missing search term"
	exit -1

elif [ $# -lt 3 ]
then
	echo "Error: missing replace term"
	exit -1

else
	if [ $0 == ${0/git-rename.sh/xxx} ]
	then
		echo "Test"

		for file in $dir/${search}*
		do
			echo "${file}"
			echo "${file/$s/$r}"
			echo " "
		done
	else
		echo "Real"

		for file in $dir/${search}*
		do
			git mv "${file}" "${file/$s/$r}" 2>/dev/null

			if [ $? -eq 0 ]
			then
				echo "git mv ${file} ${file/$s/$r}"
			else
				mv "${file}" "${file/$s/$r}"
				if [ $? -eq 0 ]
				then
					echo "mv ${file} ${file/$s/$r}"
				else
					echo "Error: could not git mv or mv ${file} to ${file/$s/$r}"
				fi
			fi
		done

	fi
fi

