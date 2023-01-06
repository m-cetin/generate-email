#! /bin/bash

# create a new file "combos.txt" to store the combinations
touch combos.txt

# prompt the user for the domain name
read -p "Enter the domain name (e.g. @github.com): " domain

# get the number of lines in the vornamen.txt file
num_surnames=$(wc -l < vornamen.txt)

# counter for the progress bar
counter=0

# loop through all the surnames
while read surname; do
  # replace German characters in the surname
  surname=$(echo "$surname" | sed 's/ü/ue/g; s/ä/ae/g; s/ö/oe/g')

  # loop through all the last names
  while read lastname; do
    # replace German characters in the last name
    lastname=$(echo "$lastname" | sed 's/ü/ue/g; s/ä/ae/g; s/ö/oe/g')

    # combine the surname and last name and append the domain
    combo="$surname.$lastname$domain"

    # write the combo to the file
    echo "$combo" >> combos.txt
  done < nachnamen.txt

  # update the progress bar
  counter=$((counter+1))
  percentage=$(awk "BEGIN { pc=100*${counter}/${num_surnames}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
  printf "\rGenerating combinations: %d%%" "$percentage"
done < vornamen.txt

echo ""  # add a newline after the progress bar
