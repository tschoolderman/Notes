#!/bin/bash

# Author: Thomas
# Created: 2023-08-19
# Last Modified: 2023-08-19

# Description:
# Assignment for bash course, keep system clear of organize files

# Usage:
# folder_organiser.sh

# Step 1: Create a while loop with the ls command as input
while IFS= read -r file; do
    # Step 2: a case statement to glob filenames for extension
    case "$file" in
        *.jpg|*.jpeg|*.png)
            dest_dir="images";;
        *.doc|*.docx|*.txt|*.pdf)
            dest_dir="documents";;
        *.xls|*.xlsx|*.csv)
            dest_dir="spreadsheets";;
        *.sh)
            dest_dir="scripts";;
        *.zip|*.tar|*.tar.gz|*.tar.bz2)
            dest_dir="archives";;
        *.ppt|*.pptx)
            dest_dir="presentations";;
        *.mp3)
            dest_dir="audio";;
        *.mp4)
            dest_dir="video";;
        *);;
    esac
    # Create the destination directory if it doesn't exist
    mkdir -p "$dest_dir"
    # Move the file to the appropriate directory
    mv "$file" "$dest_dir/"
done < <(ls)


#!/bin/bash

# Author: Ziyad Yehia
# Created: 8th February 2021
# Last Modified: 8th February 2021

# Description:
# Keeps a folder specified by the user clean by moving files into
# folders based on their file extensions

# Usage: ./folder_organiser.sh

read -p "Which folder do you want to organise?: " folder

while read filename; do
    case "$filename" in
        *.jpg|*.jpeg|*.png)
            subfolder="images" ;;
        *.doc|*.docx|*.txt|*.pdf)
            subfolder="documents" ;;
        *.xls|*.xlsx|*.csv)
            subfolder="spreadsheets" ;;
        *.sh)
            subfolder="scripts" ;;
        *.zip|*.tar|*.tar.gz|*.tar.gz.bz2)
            subfolder="archives" ;;
        *.ppt|*.pptx)
            subfolder="presentations" ;;
        *.mp3)
            subfolder="audio" ;;
        *.mp4)
            subfolder="video" ;;
        *)
            subfolder="." ;;
    esac

    if [ ! -d "$folder/$subfolder" ]; then
       mkdir "$folder/$subfolder"
    fi

    mv "$filename" "$folder/$subfolder"
done < <(ls "$folder")