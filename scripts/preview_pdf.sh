#!/bin/bash
# Preview a PDF file using the system's default viewer
# Usage: ./preview_pdf.sh document.pdf
#
# macOS: opens in Preview.app (or Skim if available)
# Linux: uses xdg-open
# WSL: uses wslview or explorer.exe

set -e

PDF_FILE="$1"

if [[ -z "$PDF_FILE" ]]; then
    echo "Usage: $0 <file.pdf>"
    exit 1
fi

if [[ ! -f "$PDF_FILE" ]]; then
    echo "Error: File '$PDF_FILE' not found"
    exit 1
fi

# Detect platform and open
case "$(uname -s)" in
    Darwin)
        # macOS — prefer Skim for continuous preview, fall back to Preview
        if open -Ra "Skim" 2>/dev/null; then
            open -a Skim "$PDF_FILE"
        else
            open "$PDF_FILE"
        fi
        ;;
    Linux)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            # WSL
            if command -v wslview &>/dev/null; then
                wslview "$PDF_FILE"
            else
                explorer.exe "$(wslpath -w "$PDF_FILE")"
            fi
        else
            xdg-open "$PDF_FILE"
        fi
        ;;
    *)
        echo "Unsupported platform. Open manually: $PDF_FILE"
        exit 1
        ;;
esac

echo "Opened: $PDF_FILE"
