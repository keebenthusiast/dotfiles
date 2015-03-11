#!/bin/bash

# Take the numbers from raw_data and remove the dashes, redirect
# to file id_number
awk '/^[0-9].*/ { print $1 }' raw_data | sed 's/-//' | sed 's/-//' | sed 's/,$//' > id_number

# Take the last names on the 2nd column, remove the line that 
# contains last, remove prior spaces from last names, add
# colons, and redirect to file last_name
cut -f2 -d, raw_data | sed '/last/ d' | sed 's/^ //' | sed 's/$/:/' > last_name

# Take the first names on the 3rd column, use grep to show lines 
# that do not contain the word 'first', remove prior spaces from
# first names, and redirect to file first_name
cut -f3 -d, raw_data | grep -v 'first' | sed 's/^ //' > first_name

# Combine the files first_name, last_name, and id_number in that
# order, separated with a single space.
paste -d\  first_name last_name id_number > final

# concatenate the file final
cat final

# done!
exit
