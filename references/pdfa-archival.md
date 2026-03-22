# PDF/A Compliance for Archival

## Overview

PDF/A is an ISO standard for long-term document preservation. Required by many universities for thesis submission and institutional repositories.

## PDF/A Versions

| Version | Use Case |
|---------|----------|
| PDF/A-1b | Basic compliance, visual appearance preserved |
| PDF/A-2b | Modern features, JPEG2000 compression |
| PDF/A-2u | PDF/A-2b + Unicode text (recommended) |
| PDF/A-3b | Allows embedded files (attachments) |

**Recommended**: PDF/A-2u for thesis/dissertation submission.

## Method 1: pdfx Package (Simplest)

```latex
\documentclass{article}

% Load BEFORE hyperref
\usepackage[a-2u]{pdfx}  % PDF/A-2u compliance

% Create metadata file: main.xmpdata
\usepackage{hyperref}
% ... rest of preamble
```

Create `main.xmpdata` (same name as .tex file):
```
\Title{Document Title}
\Author{Author Name}
\Language{en-US}
\Keywords{keyword1\sep keyword2\sep keyword3}
\Publisher{University Name}
```

## Method 2: hyperxmp + hyperref

```latex
\usepackage{hyperref}
\usepackage{hyperxmp}

\hypersetup{
    pdftitle={Document Title},
    pdfauthor={Author Name},
    pdfsubject={Subject},
    pdfkeywords={keyword1, keyword2},
    pdflang={en-US},
    pdfapart=2,
    pdfaconformance=u
}
```

## Required Font Embedding

PDF/A requires all fonts to be embedded. Verify with:

```bash
pdffonts document.pdf
```

All fonts should show "yes" under "emb" column.

### Force Embedding

```latex
% In preamble
\pdfgentounicode=1
\input{glyphtounicode}

% For T1 encoding
\usepackage[T1]{fontenc}
\usepackage{lmodern}  % Latin Modern fonts (fully embeddable)
```

## Common Compliance Issues

### Issue: Transparency

PDF/A-1 doesn't support transparency. Solutions:
- Use PDF/A-2 or higher
- Flatten transparent images before including
- Avoid `tikz` with opacity

### Issue: Non-embedded Fonts

```latex
% Use fully embeddable fonts
\usepackage{lmodern}           % Latin Modern
% OR
\usepackage{libertinus}        % Libertinus fonts
% OR with XeLaTeX/LuaLaTeX
\usepackage{fontspec}
\setmainfont{TeX Gyre Termes}  % Open-source Times clone
```

### Issue: RGB vs CMYK Colors

```latex
% Specify color profile in pdfx
\usepackage[a-2u,pdf17]{pdfx}
```

### Issue: External Links

PDF/A allows links but recommends marking them:
```latex
% pdfx handles this automatically
% Or manually specify link handling
```

## Validation

### Online Validators
- veraPDF (https://verapdf.org/) - open source, most reliable
- PDF/A Validator by PDF Tools AG
- Adobe Acrobat Pro (Preflight)

### Command Line (veraPDF)

```bash
# Install veraPDF
# https://docs.verapdf.org/install/

# Validate
verapdf --flavour 2u document.pdf

# Detailed report
verapdf --flavour 2u --format mrr document.pdf > validation-report.xml
```

## Complete Example

```latex
\documentclass[12pt,a4paper]{report}

% PDF/A-2u compliance
\usepackage[a-2u]{pdfx}

% Fonts - fully embeddable
\usepackage[T1]{fontenc}
\usepackage{lmodern}

% Standard packages
\usepackage{amsmath,amssymb}
\usepackage{graphicx}
\usepackage[backend=biber]{biblatex}

% Hyperref (after pdfx)
\usepackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    citecolor=blue,
    urlcolor=blue
}

\begin{document}
% ... content ...
\end{document}
```

With `main.xmpdata`:
```
\Title{PhD Thesis: Research Topic}
\Author{John Smith}
\Language{en-US}
\Keywords{machine learning\sep deep learning\sep neural networks}
\Subject{Computer Science PhD Thesis}
\Publisher{University Name}
```

## Thesis Submission Checklist

- [ ] Used pdfx or hyperxmp package
- [ ] Created .xmpdata metadata file
- [ ] All fonts embedded (check with `pdffonts`)
- [ ] No transparency in PDF/A-1 (use PDF/A-2+)
- [ ] Validated with veraPDF
- [ ] Check university-specific requirements
- [ ] Test PDF opens correctly in Adobe Reader
