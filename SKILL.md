---
name: pdflatex
description: |
  Professional LaTeX document compilation skill for creating publication-quality PDFs. Supports pdflatex, xelatex, lualatex engines with full bibliography chains (BibTeX/Biber), smart cross-referencing (cleveref), publication-quality tables (booktabs/siunitx), and automated builds (latexmk).
  MANDATORY TRIGGERS: LaTeX, pdflatex, xelatex, lualatex, .tex file, compile LaTeX, research paper, academic paper, journal article, thesis, dissertation, conference paper, BibTeX, Biber, biblatex, bibliography, citations, documentclass, beamer presentation, equations, mathematical notation, academic writing, paper submission, ACM template, IEEE template, Springer, Elsevier, arXiv, LaTeX invoice, LaTeX CV, LaTeX resume, LaTeX letter, LaTeX report, LaTeX certificate, typesetting, latexmk, fontspec
license: MIT
compatibility: Requires TeX Live (or MacTeX/MiKTeX) with latexmk. Biber required for biblatex bibliography.
metadata:
  author: christiannikolov
  version: "1.0.0"
---

# PDFLaTeX Compilation Skill

## Quick Start

```bash
# Basic compilation
pdflatex -interaction=nonstopmode document.tex

# With bibliography (biblatex + biber)
pdflatex document.tex && biber document && pdflatex document.tex && pdflatex document.tex

# Automated (recommended)
latexmk -pdf document.tex
```

## Reference Documentation

| Topic | File | Use When |
|-------|------|----------|
| Package reference | [packages.md](references/packages.md) | Need specific package syntax |
| Smart cross-refs | [cross-references.md](references/cross-references.md) | Using cleveref, labeling |
| Publication tables | [tables-siunitx.md](references/tables-siunitx.md) | Professional tables with aligned numbers |
| Build automation | [latexmk-config.md](references/latexmk-config.md) | Configuring latexmk |
| Journal submission | [journal-submission.md](references/journal-submission.md) | ACM, IEEE, Springer, Elsevier requirements |
| Version control | [version-control.md](references/version-control.md) | Git, latexdiff for revisions |
| PDF/A archival | [pdfa-archival.md](references/pdfa-archival.md) | Thesis submission, long-term preservation |
| Troubleshooting | [troubleshooting.md](references/troubleshooting.md) | Fixing compilation errors |
| Font guide | [fonts.md](references/fonts.md) | Custom fonts, XeLaTeX/LuaLaTeX font setup |

## Compilation Workflows

### Automated (Recommended)

```bash
latexmk -pdf document.tex           # pdflatex + auto-detect bibliography
latexmk -xelatex document.tex       # XeLaTeX for custom fonts
latexmk -lualatex document.tex      # LuaLaTeX for advanced scripting
latexmk -pdf -pvc document.tex      # Watch mode (recompile on save)
latexmk -c document.tex             # Clean auxiliary files
```

### Manual Chains

```bash
# BibTeX (traditional)
pdflatex doc.tex && bibtex doc && pdflatex doc.tex && pdflatex doc.tex

# Biber (biblatex - modern)
pdflatex doc.tex && biber doc && pdflatex doc.tex && pdflatex doc.tex

# Shell escape (minted, tikz externalize)
# WARNING: -shell-escape allows .tex files to run arbitrary system commands.
# Only use with trusted files. Prefer -shell-restricted when possible.
pdflatex -shell-escape document.tex

# IMPORTANT: Never hallucinate BibTeX entries. Always use the user's .bib file
# or ask for DOIs. Never fabricate citation data from memory.

```

### PDF Preview After Compilation

```bash
# macOS
open output.pdf

# Linux (uses xdg-open)
xdg-open output.pdf

# Or use the preview script
./scripts/preview_pdf.sh output.pdf
```

## Essential Package Loading Order

```latex
\documentclass[11pt,a4paper]{article}

% Encoding
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

% Math
\usepackage{amsmath,amssymb,amsthm}
\usepackage{mathtools}

% Graphics and layout
\usepackage{graphicx}
\usepackage[margin=1in]{geometry}
\usepackage{booktabs,siunitx}
\usepackage{microtype}

% Bibliography
\usepackage[backend=biber,style=numeric]{biblatex}
\addbibresource{references.bib}

% Cross-references (LOAD ORDER MATTERS)
\usepackage{hyperref}
\hypersetup{colorlinks=true,linkcolor=blue,citecolor=blue,urlcolor=cyan}
\usepackage{cleveref}  % MUST be after hyperref
```

## Engine Selection Guide

| Engine | Use When | Key Feature |
|--------|----------|-------------|
| `pdflatex` | Default choice, most compatible | Widest package support |
| `xelatex` | Custom/system fonts, Unicode-heavy docs | `fontspec` package |
| `lualatex` | Advanced scripting, complex typography | Lua scripting in TeX |
| `latexmk` | Always — wraps any engine | Auto-detects passes needed |

## Project Structure

```
paper/
├── main.tex              # Main document
├── references.bib        # Bibliography
├── .latexmkrc            # Build config
├── sections/
│   ├── abstract.tex
│   ├── introduction.tex
│   ├── methods.tex
│   ├── results.tex
│   └── conclusion.tex
├── figures/
│   └── *.pdf, *.png
└── output/               # Compiled PDFs
```

## Common Tasks

### Smart References (cleveref)

```latex
\label{fig:results}              % After \caption
\cref{fig:results}               % → "Figure 1"
\Cref{fig:results}               % → "Figure 1" (sentence start)
\cref{fig:a,fig:b,fig:c}         % → "Figures 1 to 3"
```

### Publication-Quality Tables

```latex
\begin{table}[htbp]
    \caption{Results comparison.}
    \label{tbl:results}
    \centering
    \begin{tabular}{l S[table-format=2.2] S[table-format=1.2]}
        \toprule
        Model & {Accuracy (\%)} & {F1} \\
        \midrule
        Baseline & 85.32 & 0.83 \\
        \textbf{Ours} & \bfseries 92.15 & \bfseries 0.91 \\
        \bottomrule
    \end{tabular}
\end{table}
```

### Generate Revision Diff

```bash
# Compare current with submitted version
latexdiff-vc --git -r v1.0-submission main.tex
pdflatex main-diffv1.0-submission.tex
```

## Quick Fixes

| Problem | Solution |
|---------|----------|
| `??` in PDF | Run pdflatex twice |
| Citations missing | Run biber/bibtex + pdflatex x2 |
| Undefined control | Add missing `\usepackage{}` |
| Overfull hbox | Add `\sloppy` or adjust text |
| Package conflict | Check load order (hyperref before cleveref) |
| Font not found (XeLaTeX) | Check font name with `fc-list`, use `fontspec` |
| Missing .sty file | `sudo tlmgr install packagename` |

## Example Templates

Ready-to-use templates in `examples/`:
- `research-paper.tex` — Academic paper with biblatex, cleveref, siunitx (+ `references.bib`)
- `invoice.tex` — Professional invoice with line items and totals
- `report.tex` — Business report with TOC, sections, figures, tables
- `letter.tex` — Formal business letter
- `presentation.tex` — Beamer slide deck (modern theme)
- `cv.tex` — Modern CV/resume
- `.latexmkrc` — Ready-to-use build configuration

## Scripts

```bash
./scripts/compile_latex.sh document.tex [pdflatex|xelatex|lualatex] [--bib bibtex|biber] [--clean] [--shell-escape] [--output-dir DIR]
./scripts/clean_latex.sh [directory] [--all]
./scripts/preview_pdf.sh output.pdf
```
