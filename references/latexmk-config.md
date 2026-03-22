# Latexmk Build Automation

## Overview

`latexmk` automatically determines required compilation passes, handles bibliography, and supports continuous preview.

## Basic Commands

```bash
# Build PDF (auto-detects bibliography, indices, etc.)
latexmk -pdf document.tex

# XeLaTeX for custom fonts
latexmk -xelatex document.tex

# LuaLaTeX
latexmk -lualatex document.tex

# Continuous preview (recompile on save)
latexmk -pdf -pvc document.tex

# Clean auxiliary files
latexmk -c document.tex

# Clean ALL including PDF
latexmk -C document.tex

# Force rebuild
latexmk -f -pdf document.tex
```

## Configuration File (latexmkrc)

Create `.latexmkrc` in project root or `~/.latexmkrc` for global config.

### Basic Configuration

```perl
# Default to PDF output
$pdf_mode = 1;

# Use pdflatex
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# For XeLaTeX instead:
# $pdf_mode = 5;
# $xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';

# Output directory
$out_dir = 'build';

# Biber for biblatex
$biber = 'biber %O %S';

# Clean these extensions
@generated_exts = qw(aux log out toc lof lot bbl blg bcf run.xml fls fdb_latexmk synctex.gz);
```

### Advanced Configuration

```perl
# Shell escape for minted
$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -synctex=1 %O %S';

# Glossaries support
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
sub makeglossaries {
    system("makeglossaries \"$_[0]\"");
}
push @generated_exts, 'glo', 'gls', 'glg';

# Index support
$makeindex = 'makeindex -s %O -o %D %S';

# Preview PDF viewer (macOS)
$pdf_previewer = 'open -a Preview %O %S';
# Or for Skim:
# $pdf_previewer = 'open -a Skim %O %S';

# Maximum runs to prevent infinite loops
$max_repeat = 5;
```

### Project-Specific Example

```perl
# .latexmkrc for research paper with biblatex + glossaries

$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
$biber = 'biber %O %S';
$out_dir = 'output';

# Glossaries
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
sub makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    pushd $path;
    system "makeglossaries '$base_name'";
    popd;
}

# Clean extensions
@generated_exts = qw(aux log out toc lof lot bbl blg bcf run.xml fls fdb_latexmk synctex.gz glo gls glg ist acn acr alg);
```

## Useful Options

| Option | Effect |
|--------|--------|
| `-pdf` | Generate PDF via pdflatex |
| `-xelatex` | Use XeLaTeX engine |
| `-lualatex` | Use LuaLaTeX engine |
| `-pvc` | Preview continuously (watch mode) |
| `-c` | Clean auxiliary files |
| `-C` | Clean all generated files |
| `-f` | Force processing |
| `-g` | Force processing, process all |
| `-silent` | Suppress most output |
| `-outdir=DIR` | Output directory |
| `-auxdir=DIR` | Auxiliary files directory |

## Integration with Editors

### VS Code (LaTeX Workshop)

Add to `settings.json`:
```json
{
    "latex-workshop.latex.tools": [{
        "name": "latexmk",
        "command": "latexmk",
        "args": ["-pdf", "-synctex=1", "-interaction=nonstopmode", "%DOC%"]
    }]
}
```

### TeXShop (macOS)

Preferences → Typesetting → Default Command: `latexmk`

## Typical Workflow

```bash
# Initial build
latexmk -pdf main.tex

# Writing mode (auto-rebuild on save)
latexmk -pdf -pvc main.tex

# Before submission - clean build
latexmk -C main.tex && latexmk -pdf main.tex

# View build log
cat main.log | grep -i "warning\|error"
```
