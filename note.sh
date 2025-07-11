#!/bin/bash
# note.sh

# an app to record time stamped notes or diary entries.
# free form or field entries
# searchable with ctrl-f in a text editor.
# append entries to file.

clear
echo ""
echo "** Note **"
echo ""

# print date and append to file
date "+## %a %d %b %Y %R" | tee -a ~/Nevada/Scripts/note/note.md

# Enter title
read -p "Enter Title - " title1

# print title to note
echo "" >> ~/Nevada/Scripts/note/note.md

echo "### $title1" >> ~/Nevada/Scripts/note/note.md
echo ""
echo "Write your note or Diary entry and save with :"
echo ""

# read input with line editor, delimiter set to :
read -e -d ":" -p "> " -r note1

# append entry note1 to file
echo "$note1" >> ~/Nevada/Scripts/note/note.md

# formatting
echo "" >> ~/Nevada/Scripts/note/note.md                                 
echo "---" >> ~/Nevada/Scripts/note/note.md
echo "" >> ~/Nevada/Scripts/note/note.md

# Use markdown to convert .md to .html
pandoc --metadata title="note" -s -o ~/Nevada/Scripts/note/note.html ~/Nevada/Scripts/note/note.md
exit 0

