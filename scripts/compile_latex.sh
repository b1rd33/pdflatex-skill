#!/bin/bash
# LaTeX Compilation Script
# Usage: ./compile_latex.sh document.tex [engine] [--bib bibtex|biber] [--clean]
#
# Engines: pdflatex (default), xelatex, lualatex
# Examples:
#   ./compile_latex.sh paper.tex
#   ./compile_latex.sh paper.tex xelatex --bib biber
#   ./compile_latex.sh paper.tex pdflatex --bib bibtex --clean

set -e

# Defaults
ENGINE="pdflatex"
BIB_ENGINE=""
CLEAN=false
OUTPUT_DIR=""

# Parse arguments
TEX_FILE="$1"
shift || true

while [[ $# -gt 0 ]]; do
    case $1 in
        pdflatex|xelatex|lualatex)
            ENGINE="$1"
            shift
            ;;
        --bib)
            BIB_ENGINE="$2"
            shift 2
            ;;
        --clean)
            CLEAN=true
            shift
            ;;
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Validate input
if [[ -z "$TEX_FILE" ]]; then
    echo "Usage: $0 <file.tex> [pdflatex|xelatex|lualatex] [--bib bibtex|biber] [--clean]"
    exit 1
fi

if [[ ! -f "$TEX_FILE" ]]; then
    echo "Error: File '$TEX_FILE' not found"
    exit 1
fi

# Get base name without extension
BASENAME="${TEX_FILE%.tex}"
DIRNAME=$(dirname "$TEX_FILE")

# Change to document directory
cd "$DIRNAME"
BASENAME=$(basename "$BASENAME")

# Build output directory option
OUTPUT_OPT=""
if [[ -n "$OUTPUT_DIR" ]]; then
    mkdir -p "$OUTPUT_DIR"
    OUTPUT_OPT="-output-directory=$OUTPUT_DIR"
fi

echo "=== Compiling $TEX_FILE with $ENGINE ==="

# First pass
echo "[1/4] First $ENGINE pass..."
$ENGINE -interaction=nonstopmode $OUTPUT_OPT "${BASENAME}.tex"

# Bibliography pass if requested
if [[ -n "$BIB_ENGINE" ]]; then
    echo "[2/4] Running $BIB_ENGINE..."
    if [[ -n "$OUTPUT_DIR" ]]; then
        cd "$OUTPUT_DIR"
    fi

    if [[ "$BIB_ENGINE" == "biber" ]]; then
        biber "$BASENAME"
    else
        bibtex "$BASENAME"
    fi

    if [[ -n "$OUTPUT_DIR" ]]; then
        cd - > /dev/null
    fi

    echo "[3/4] Second $ENGINE pass..."
    $ENGINE -interaction=nonstopmode $OUTPUT_OPT "${BASENAME}.tex"

    echo "[4/4] Third $ENGINE pass..."
    $ENGINE -interaction=nonstopmode $OUTPUT_OPT "${BASENAME}.tex"
else
    echo "[2/4] Second $ENGINE pass (for cross-references)..."
    $ENGINE -interaction=nonstopmode $OUTPUT_OPT "${BASENAME}.tex"
fi

# Clean auxiliary files if requested
if [[ "$CLEAN" == true ]]; then
    echo "Cleaning auxiliary files..."
    TARGET_DIR="${OUTPUT_DIR:-.}"
    rm -f "$TARGET_DIR/$BASENAME".{aux,log,bbl,blg,out,toc,lof,lot,bcf,run.xml,fls,fdb_latexmk,synctex.gz}
fi

# Report result
if [[ -n "$OUTPUT_DIR" ]]; then
    PDF_PATH="$OUTPUT_DIR/${BASENAME}.pdf"
else
    PDF_PATH="${BASENAME}.pdf"
fi

if [[ -f "$PDF_PATH" ]]; then
    echo ""
    echo "=== Success! ==="
    echo "Output: $PDF_PATH"
    ls -lh "$PDF_PATH"
else
    echo "Error: PDF not generated"
    exit 1
fi
