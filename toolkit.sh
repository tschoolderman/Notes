#!/bin/bash

# Author: Thomas
# Created: 2023-08-19
# Last Modified: 2023-08-19

# Description:
# Assignment for bash course, keep system clear of organize files

# Usage:
# toolkit.sh

# Display a menu and let the user choose a script
PS3="Select a script to run: "
options=("Organize Files by Extension" "Remove Cruft Files")
select opt in "${options[@]}"; do
    case $opt in
        "Organize Files by Extension")
            ./folder_organiser.sh
            break;;
        "Remove Cruft Files")
            ./cruft_remover.sh
            break;;
        *) echo "Invalid option";;
    esac
done

#!/bin/bash

# Author: Ziyad Yehia
# Created: 8th February 2021
# Last Modified: 8th February 2021

# Description:
# Menu to select which utility should be run

# Usage: ./toolkit.sh

PS3="Which utility do you want to run?: "
select script in "cruft_remover" "folder_organiser"; do
    $HOME/bash_course/scripts/"$script.sh"
    break
done