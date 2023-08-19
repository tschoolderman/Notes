#!/bin/bash

# Author: Thomas
# Created: 2023-08-19
# Last Modified: 2023-08-19

# Description:
# Assignment for bash course, keep system clear of unnecessary files

# Usage:
# cruft_remover.sh

# Step 1: Ask for input
read -p -r "Which folder do you want to remove 'cruft' from? " folder_path
read -p -r "Enter the number of days for files to be considered 'cruft': " days_threshold

# Step 2: Create an array of eligible files using the find command
readarray -t files_to_remove <<< "$(find "$folder_path" -maxdepth 1 -type f -mtime +"$days_threshold")"

# Step 3: Iterate over the array and prompt (-i) user for deletion confirmation
for file in "${files_to_remove[@]}"; do
    read -p -r "Delete '$file'? (y/n): " choice
    if [[ ${choice,,} == "y" ]]; then
        rm -i "$file"
        echo "Deleted: $file"
    else
        echo "Skipped: $file"
    fi
done


#!/bin/bash

# Author: Ziyad Yehia
# Created: 8th February 2021
# Last Modified: 8th February 2021

# Description:
# Prompts you to remove all files in a specified folder that have not
# been modified within a given number of days

# Usage: ./cruft_remover.sh

read -p "Which folder do you want to remove unmodified files from?: " folder
read -p "How many days is too old?: " days

readarray -t files < <(find $folder -maxdepth 1 -type f -mtime "+$days")

for file in "${files[@]}"; do
    rm -i "$file"
done