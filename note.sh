#!/bin/bash
# note.sh

# an app to record time stamped notes or diary entries.
# free form or field entries
# searchable with ctrl-f in a text editor.
# append entries to file.
# TODO: Add search function instead of or as well as -r flag

# Config:
Color Variables tput
#r=$(tput setaf 1) # Warnings/errors Red
g=$(tput setaf 2) # Menus/info/success Green
c=$(tput setaf 6) # Input prompts Cyan
m=$(tput setaf 5) # Highlights Magenta
reset=$(tput sgr0) # Reset

trap 'echo -e "$reset"; exit 0' INT TERM EXIT
DATE=$(date "+## %a %d %b %Y %R")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # Resolve script's directory
FILE="note.md"                  # set markdown file name
NOTE="$SCRIPT_DIR/$FILE"        # Script dir and markdown file


# Main:
clear
if [ ! -f "$NOTE" ]; then
    touch "$NOTE"
fi
# getopts -r for read note
while getopts "r" flag; do
case ${flag} in
    r) nano -v "$NOTE"
        exit 0
    ;;
    *) exit 0
    ;;
esac
done

echo "${g}** ${m}Note ${g}**${reset}"
echo 
# Enter title
read -r -p "${g}Enter Title ${c}> ${reset}" title1
echo 
echo "${g}Write your note and save with ${m}Enter${reset}"
echo 
# read input with line editor
echo -ne "$c"
read -e -r -p "> ${reset}" note1
echo -ne "$reset"

cat >> "$NOTE" << EOF
$DATE

### $title1

$note1

___

EOF
exit 0