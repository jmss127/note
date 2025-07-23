#!/bin/bash
# note.sh

# an app to record time stamped notes or diary entries.
# free form or field entries
# searchable with ctrl-f in a text editor.
# append entries to file.
# TODO: Add search function instead of or as well as -r flag

# Config:
Color Variables tput
# r=$(tput setaf 1) # Warnings/errors Red
g=$(tput setaf 2)  # Menus/info/success Green
c=$(tput setaf 6)  # Input prompts Cyan
m=$(tput setaf 5)  # Highlights Magenta
reset=$(tput sgr0) # Reset

trap 'echo -e "$reset"; exit 0' INT TERM EXIT
DATE=$(date "+## %a %d %b %Y %R")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # Resolve script's directory
FILE="note.md"                                             # set markdown file name
NOTE="$SCRIPT_DIR/$FILE"                                   # Script dir and markdown file

# Main:
if [ ! -f "$NOTE" ]; then
    touch "$NOTE"
fi
# getopts -r for read note
while getopts "r" flag; do
    case ${flag} in
    r)
        nano -v "$NOTE"
        exit 0
        ;;
    *)
        exit 0
        ;;
    esac
done
while true; do
    clear
    echo "${g}** ${m}Note ${g}**${reset}"
    echo
    echo "${g}Write your note and save with ${m}Enter${g} or ${m}CTRL+C${g} to exit${reset}"
    echo
    # read input with line editor
    echo -ne "$c"
    read -e -r -p "> ${reset}" note1
    echo -e "$reset"
    
    # Extract title from first three words
    title1=$(echo "$note1" | head -n 1 | grep -o "^\S\+\s\+\S\+\s\+\S\+")
    if [ -z "$title1" ]; then
        title1="Untitled"
    fi
    # Print to markdown file.
    cat >>"$NOTE" <<EOF
$DATE

### $title1

$note1

___

EOF
done
exit 0
