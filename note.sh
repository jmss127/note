#!/bin/bash
# note.sh

# an app to record time stamped notes or diary entries.
# free form or field entries
# searchable with ctrl-f in a text editor.
# append entries to file.

# Config:
Color Variables tput
r=$(tput setaf 1) # Warnings/errors Red
g=$(tput setaf 2) # Menus/info/success Green
c=$(tput setaf 6) # Input prompts Cyan
m=$(tput setaf 5) # Highlights Magenta
reset=$(tput sgr0) # Reset

trap 'echo -e "$reset"; exit 0' INT TERM EXIT
DATE=$(date "+## %a %d %b %Y %R")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # Resolve script's directory
NOTE="$SCRIPT_DIR/note.md"      # set note text file name

clear
echo "${g}** ${m}Note ${g}**${reset}"
echo 

# print date and append to file
echo -e "$DATE" >> "$NOTE"

# Enter title
read -r -p "Enter Title > " title1

# print title to note
echo "" >> "$NOTE"

echo "### $title1" >> "$NOTE"
echo ""
echo "Write your note or Diary entry and save with :"
echo ""

# read input with line editor, delimiter set to :
read -e -r -p "> " -r note1

# append entry note1 to file
echo "$note1" >> "$NOTE"

# formatting
echo "" >> "$NOTE"                                 
echo "---" >> "$NOTE"
echo "" >> "$NOTE"


exit 0

