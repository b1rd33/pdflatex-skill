# LaTeX Troubleshooting Guide

## Reading Error Messages

LaTeX errors show: `! Error message` followed by `l.123` (line number).

```
! Undefined control sequence.
l.45 \includegrahpics
                     {image.png}
```
→ Typo on line 45: `\includegrahpics` should be `\includegraphics`

## Common Errors and Fixes

### Undefined Control Sequence

**Error**: `! Undefined control sequence`

| Missing Command | Required Package |
|-----------------|------------------|
| `\includegraphics` | `graphicx` |
| `\url` | `url` or `hyperref` |
| `\cite` (with biblatex) | `biblatex` |
| `\cref` | `cleveref` |
| `\SI`, `\num` | `siunitx` |
| `\toprule` | `booktabs` |
| `\begin{align}` | `amsmath` |
| `\mathbb` | `amssymb` |

**Check**: Is the package loaded in preamble?

### Missing File

**Error**: `! LaTeX Error: File 'xxx.sty' not found`

```bash
# Install missing package
sudo tlmgr install packagename

# Update all packages
sudo tlmgr update --all
```

### Unbalanced Braces

**Error**: `! Missing } inserted` or `Runaway argument?`

**Fix**: Every `{` needs a matching `}`. Use editor bracket matching.

Common causes:
- Missing `}` in `\textbf{...`
- Missing `}` in environment options
- Unescaped special character

### Undefined Reference

**Error**: `LaTeX Warning: Reference 'fig:example' undefined`

**Causes**:
1. Label doesn't exist - check spelling
2. Need second compilation pass
3. Label defined after reference (in same file)

```bash
# Run twice
pdflatex document.tex
pdflatex document.tex
```

### Undefined Citation

**Error**: `Citation 'key' undefined`

**Checklist**:
1. Key exists in `.bib` file (exact spelling)
2. Run bibliography tool:
   ```bash
   pdflatex document.tex
   bibtex document      # or: biber document
   pdflatex document.tex
   pdflatex document.tex
   ```
3. Check `.blg` file for errors
4. Verify `\bibliography{file}` or `\addbibresource{file.bib}` path

### Overfull/Underfull Boxes

**Warning**: `Overfull \hbox (10.0pt too wide)`

**Fixes**:
```latex
% Allow more flexibility
\sloppy                    % Entire document
\begin{sloppypar}...       % Specific paragraph

% Hyphenation
\hyphenation{long-word}    % Define break points

% For tables
\resizebox{\textwidth}{!}{...}  % Scale to fit

% For text overflow
\emergencystretch=1em      % In preamble
```

### Float Placement Issues

**Problem**: Figures/tables not where expected

```latex
% Force placement
\begin{figure}[H]          % Requires float package
\begin{figure}[!htbp]      % Try here, top, bottom, page

% Adjust float parameters
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.9}
\renewcommand{\textfraction}{0.1}
```

### Package Conflicts

**Common conflicts**:

| Conflict | Solution |
|----------|----------|
| hyperref + cleveref | Load cleveref AFTER hyperref |
| amsmath + wasysym | Load amsmath first |
| tikz + graphicx | Usually compatible, check options |

**Debug**: Comment out packages one by one to isolate.

### Encoding Issues

**Error**: `Package inputenc Error: Invalid UTF-8 byte`

```latex
% Ensure UTF-8
\usepackage[utf8]{inputenc}

% Or use XeLaTeX/LuaLaTeX which handle UTF-8 natively
```

**Check file encoding**: Should be UTF-8, not Latin-1.

## Build Issues

### Bibliography Not Appearing

**Checklist**:
```bash
# Full chain
pdflatex main.tex
bibtex main        # Check main.blg for errors
pdflatex main.tex
pdflatex main.tex
```

For biblatex:
```bash
pdflatex main.tex
biber main         # Not bibtex!
pdflatex main.tex
pdflatex main.tex
```

### Compilation Hangs

**Cause**: Interactive mode waiting for input

**Fix**: Use non-stop mode:
```bash
pdflatex -interaction=nonstopmode document.tex
```

### Memory Exceeded

**Error**: `TeX capacity exceeded`

```bash
# Increase memory (in texmf.cnf)
main_memory = 5000000
```

Or simplify document - reduce tikz complexity, optimize images.

## Debugging Strategies

### Minimal Working Example (MWE)

Isolate the problem:
```latex
\documentclass{article}
\usepackage{problematic-package}
\begin{document}
% Minimal code that reproduces error
\end{document}
```

### Check Log File

```bash
# Look for errors and warnings
grep -i "error\|warning" document.log

# Find specific issue
grep -A 5 "Undefined control" document.log
```

### Clean Build

```bash
# Remove all auxiliary files
rm -f *.aux *.log *.bbl *.blg *.out *.toc *.lof *.lot *.bcf *.run.xml *.fls *.fdb_latexmk

# Or with latexmk
latexmk -C document.tex

# Fresh compile
pdflatex document.tex
```

### Draft Mode

```latex
\documentclass[draft]{article}
% Shows overfull boxes as black bars
% Skips image loading (faster)
```

## Quick Reference

| Symptom | Likely Cause | Quick Fix |
|---------|--------------|-----------|
| `??` in PDF | Undefined reference | Run twice |
| Missing citations | No bibtex/biber run | Run bib tool + pdflatex ×2 |
| Commands not working | Missing package | Add `\usepackage{...}` |
| Weird characters | Encoding mismatch | Use UTF-8 + inputenc |
| Figures missing | Wrong path | Check `\graphicspath{}` |
| PDF not updating | Cached aux files | Clean and rebuild |
