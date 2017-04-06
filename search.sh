#!/bin/bash
# Get users search parameters
echo -e "Are you searching for a file name or for text in a file? (Type f for file or t for text in a file)"
read s_place
if [[ "$s_place" = "f" ]]; then
    # If they are searching for a filename assign the filename for the search to $filename
    echo -e "What is the name of the file you are searching for?"
    read filename
else 
    if [[ "$s_place" = "t" ]]; then
        # If they are searching for a text string assign that text string to $textstring
        echo -e "Enter the text string you are wanting to search for."
        read textstring
    else
        # Restart the search script if they entered an incorrect variable
        echo "$s_place is not a valid input, please try again"
        eval '/Users/brighton/scripts/search.sh'
    fi
fi
if [[ "$s_place" = "F" ]]; then
    grep -r . "$filename"
else
    if [[ "$s_place" = "T" ]]; then
        grep -r "$textstring" .
    fi
fi



