#!/bin/bash
# Clean LaTeX auxiliary files
# Usage: ./clean_latex.sh [directory] [--all]
#
# Without --all: removes common aux files
# With --all: also removes PDF output

DIR="${1:-.}"
CLEAN_ALL=false

if [[ "$2" == "--all" ]] || [[ "$1" == "--all" ]]; then
    CLEAN_ALL=true
    if [[ "$1" == "--all" ]]; then
        DIR="."
    fi
fi

echo "Cleaning LaTeX auxiliary files in: $DIR"

# Common auxiliary extensions
AUX_EXT="aux log bbl blg out toc lof lot bcf run.xml fls fdb_latexmk synctex.gz nav snm vrb"

for ext in $AUX_EXT; do
    find "$DIR" -maxdepth 2 -name "*.$ext" -type f -delete 2>/dev/null
done

# Clean PDF if --all
if [[ "$CLEAN_ALL" == true ]]; then
    echo "Also removing PDF files..."
    find "$DIR" -maxdepth 2 -name "*.pdf" -type f -delete 2>/dev/null
fi

echo "Done."
