# Font Guide for LaTeX

## Engine-Specific Font Handling

### pdflatex (Default)

Uses `.tfm` font metrics. Limited to fonts packaged for LaTeX.

```latex
\usepackage[T1]{fontenc}
\usepackage{lmodern}           % Latin Modern (default, clean)

% Alternative font packages
\usepackage{newtxtext,newtxmath} % Times + matching math (modern, recommended)
% \usepackage{mathptmx}         % Legacy Times — use newtx instead
\usepackage{palatino}          % Palatino
\usepackage{libertinus}        % Libertinus (modern, open source)
\usepackage{ebgaramond}        % EB Garamond (elegant serif)
\usepackage{charter}           % Charter (readable)

% Sans serif
\usepackage{helvet}            % Helvetica clone
\usepackage[sfdefault]{roboto} % Roboto (Google)
\usepackage[sfdefault]{inter}  % Inter

% Monospace
\usepackage{inconsolata}       % Inconsolata
\usepackage[scale=0.85]{beramono} % Bera Mono
```

### XeLaTeX / LuaLaTeX (System Fonts)

Can use any font installed on your system via `fontspec`.

```latex
\usepackage{fontspec}

% System fonts
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

% With options
\setmainfont{Garamond}[
    BoldFont={Garamond Bold},
    ItalicFont={Garamond Italic},
    BoldItalicFont={Garamond Bold Italic}
]

% Open-source alternatives
\setmainfont{TeX Gyre Termes}     % Times clone
\setsansfont{TeX Gyre Heros}      % Helvetica clone
\setmonofont{TeX Gyre Cursor}     % Courier clone
```

## Finding Available Fonts

```bash
# List all system fonts (XeLaTeX/LuaLaTeX)
fc-list | sort

# Search for a specific font
fc-list | grep -i "garamond"

# List TeX fonts
tlmgr list --only-installed | grep font
```

## Common Font Issues

### Missing Font

```
! Font T1/lmr/m/n/10=ec-lmr10 at 10.0pt not loadable
```

**Fix**: Install the font package:
```bash
sudo tlmgr install lm          # Latin Modern
sudo tlmgr install collection-fontsrecommended
```

### Font Not Found (XeLaTeX)

```
! fontspec error: "font-not-found"
```

**Fix**: Check the exact font name:
```bash
fc-list | grep -i "desired font"
```

Use the exact name from `fc-list` output in `\setmainfont{}`.

### Font Not Embedded (PDF/A)

```bash
# Check font embedding
pdffonts document.pdf

# All entries should show "yes" under "emb"
```

**Fix**: Use `lmodern` or explicitly embeddable fonts.

## Recommended Font Pairings

| Use Case | Serif | Sans | Mono |
|----------|-------|------|------|
| Academic paper | Latin Modern | — | — |
| Business report | TeX Gyre Termes | TeX Gyre Heros | Inconsolata |
| Modern document | Libertinus | Inter | JetBrains Mono |
| Thesis | EB Garamond | Source Sans Pro | Source Code Pro |

## Math Font Packages

```latex
% With pdflatex
\usepackage{mathptmx}          % Times math
\usepackage{eulervm}           % Euler math (distinctive)
\usepackage{newtxmath}         % New TX math (high quality)

% With XeLaTeX/LuaLaTeX
\usepackage{unicode-math}
\setmathfont{TeX Gyre Termes Math}
\setmathfont{STIX Two Math}
```
