#!/bin/bash
# note.sh

# an app to record time stamped notes or diary entries.
# free form or field entries
# searchable with ctrl-f in a text editor.
# append entries to file.

# Config:
#Color Variables tput
# r=$(tput setaf 1) # Warnings/errors Red
g=$(tput setaf 2)  # Menus/info/success Green
c=$(tput setaf 6)  # Input prompts Cyan
m=$(tput setaf 5)  # Highlights Magenta
reset=$(tput sgr0) # Reset

trap 'echo -e "$reset"; exit 0' INT TERM EXIT
DATE=$(date "+%a %d %b %Y %R")
SCR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # Resolve script's directory
FILE="note.md"                                          # set markdown file name
NOTE="$SCR_DIR/$FILE"                                   # Script dir and markdown file

# Main:
[ ! -f "$NOTE" ] && touch "$NOTE"
# getopts -r for read note, s: for searching
while getopts "hrs:" flag; do
    case ${flag} in
    h) printf "Note Options:\n-h List of options.\n-r read Note record in editor.\n-s Search for records."
        exit 0; ;;
    r) nano -v "$NOTE"; exit 0; ;;
    # Select a suitable pager here.
    s) awk -v w="${OPTARG}" '
        /^##/ {record=""; inblock=1}
        /^___/ {inblock=0; if (record ~ w) print record}
        inblock {record = record $0 "\n"}' "$FILE" | batcat --file-name "$NOTE"
        exit 0; ;; 
    *) exit 0; ;;
    esac
done
while true; do
    clear
    echo "${g}** ${m}Note ${g}**${reset}"
    echo
    echo "${g}Write your note and save with ${m}Ctrl+D${g} on a new line or ${m}Ctrl+C${g} to exit${reset}"
    echo
    # read input
    echo -ne "$c> ${reset}"
    note_in=$(cat) # capture multiline input
    echo -e "$reset"
    # Extract title from first three words
    title=$(echo "$note_in" | head -n 1 | grep -o "^\S\+\s\+\S\+\s\+\S\+" || echo "Untitled")
    # Append to file using ed
    ed -s "$NOTE" <<EOF
\$a

## $title - $DATE

$note_in

___
.
w
q
EOF
done
exit 0