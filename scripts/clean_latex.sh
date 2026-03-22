#!/bin/bash
# Clean LaTeX auxiliary files
# Usage: ./clean_latex.sh [directory] [--all]
#        ./clean_latex.sh --all [directory]
#
# Without --all: removes common aux files
# With --all: also removes PDF output

DIR=""
CLEAN_ALL=false

# Parse arguments in any order
for arg in "$@"; do
    if [[ "$arg" == "--all" ]]; then
        CLEAN_ALL=true
    elif [[ -z "$DIR" ]]; then
        DIR="$arg"
    fi
done

DIR="${DIR:-.}"

if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' not found"
    exit 1
fi

echo "Cleaning LaTeX auxiliary files in: $DIR"

# Common auxiliary extensions (matches .gitignore)
AUX_EXT="aux log bbl blg out toc lof lot bcf run.xml fls fdb_latexmk synctex.gz nav snm vrb glo gls glg ist acn acr alg idx ind ilg"

for ext in $AUX_EXT; do
    find "$DIR" -name "*.$ext" -type f -delete 2>/dev/null
done

# Clean PDF if --all
if [[ "$CLEAN_ALL" == true ]]; then
    echo "Also removing PDF files..."
    find "$DIR" -name "*.pdf" -type f -delete 2>/dev/null
fi

echo "Done."
