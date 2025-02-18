#!/bin/bash

# Help function to show usage
show_help() {
    echo "Usage: $0 -c CATEGORY -n 'Your note text here'"
    echo "Categories: task, idea, meeting, general"
    echo "Example: $0 -c task -n 'Complete project documentation'"
    exit 1
}

# Default category
CATEGORY="general"

# Parse command line options
while getopts "c:n:h" opt; do
    case $opt in
        c) CATEGORY=$OPTARG ;;
        n) NOTE=$OPTARG ;;
        h) show_help ;;
        ?) show_help ;;
    esac
done

# Validate input
if [ -z "$NOTE" ]; then
    show_help
fi

# Validate category
case $CATEGORY in
    task|idea|meeting|general) ;;
    *) echo "Invalid category. Use: task, idea, meeting, or general"
       exit 1 ;;
esac

# Create the file if it doesn't exist
if [ ! -f terminal_notes.md ]; then
    echo "# Terminal Notes" > terminal_notes.md
    echo "\nCreated on $(date '+%Y-%m-%d')\n" >> terminal_notes.md
fi

# Format timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Format the note with markdown
NOTE_ENTRY="\n## [$CATEGORY] - $TIMESTAMP\n\n$NOTE\n"

# Append the formatted note to the markdown file
echo -e "$NOTE_ENTRY" >> terminal_notes.md

# Confirm the note was added
echo "✓ Note added to terminal_notes.md in category: $CATEGORY"

# Show the last entry
echo -e "\nLast entry:"
tail -n 4 terminal_notes.md
