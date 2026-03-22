# Academic Journal Submission Requirements

## General Best Practices

1. **Always use official templates** - download from publisher website
2. **No custom packages** beyond what the template provides
3. **Single flat directory** - all files in one folder
4. **Complete metadata** - title, authors, affiliations, contact email
5. **Test locally** before submission
6. **Read author guidelines** carefully

## ACM Publications

**Template**: ACM Primary Article Template (LaTeX 2.16+)

```latex
\documentclass[sigconf]{acmart}  % or sigplan, sigchi, etc.

% Required metadata
\acmConference[CONF'25]{Conference Name}{Month Year}{Location}
\acmDOI{10.1145/xxxxxxx.xxxxxxx}
\acmISBN{978-x-xxxx-xxxx-x}
```

**Requirements**:
- Use only packages from ACM approved list
- No custom macros
- Must compile with TAPS system
- Anonymize for double-blind review

**Download**: https://www.acm.org/publications/proceedings-template

## Elsevier Journals

**Template**: elsarticle class

```latex
\documentclass[preprint,12pt]{elsarticle}
% or review, 1p, 3p, 5p for different layouts

\journal{Journal Name}

\begin{frontmatter}
\title{Paper Title}
\author{Name}
\address{Affiliation}
\begin{abstract}
...
\end{abstract}
\begin{keyword}
keyword1 \sep keyword2
\end{keyword}
\end{frontmatter}
```

**Requirements**:
- Compatible with TeX Live 2022+
- All files in single directory
- BibTeX preferred (`.bib` file)
- High-resolution figures (300 dpi minimum)

**Download**: https://www.elsevier.com/authors/policies-and-guidelines/latex-instructions

## Springer Nature

**Template**: sn-article class (December 2024)

```latex
\documentclass{sn-jnl}
% Options: sn-basic, sn-mathphys, sn-aps, sn-vancouver

\begin{document}
\title{Paper Title}
\author{Name}\email{email@example.com}
\affil{Affiliation}

\abstract{...}
\keywords{keyword1 \and keyword2}
\maketitle
```

**Requirements**:
- "Content-first" approach
- Minimal formatting
- Single .tex file preferred
- Use provided bibliography style

**Download**: https://www.springernature.com/gp/authors/campaigns/latex-author-support

## IEEE Transactions

**Template**: IEEEtran class

```latex
\documentclass[journal]{IEEEtran}
% Options: conference, journal, technote

\begin{document}
\title{Paper Title}
\author{Name~Author,~\IEEEmembership{Member,~IEEE}}
\maketitle
\begin{abstract}
...
\end{abstract}
\begin{IEEEkeywords}
keyword1, keyword2
\end{IEEEkeywords}
```

**Requirements**:
- Use IEEEtran.bst for bibliography
- Double-column format for most journals
- Figures in EPS or PDF format
- Include author photos for journals

**Download**: https://www.ieee.org/conferences/publishing/templates.html

## arXiv Preprints

**Requirements**:
- Must compile with TeX Live (current year - 1)
- All source files uploaded
- No absolute paths in `\includegraphics`
- Total size < 50MB
- Single main .tex file recommended

**Tips**:
```latex
% Avoid these for arXiv compatibility
% \usepackage{...}[option=value]  % Some options fail
% \input{/absolute/path}          % Use relative paths
```

**Test locally**: `pdflatex --interaction=nonstopmode main.tex`

## Common Submission Checklist

- [ ] Downloaded latest official template
- [ ] Removed unused packages
- [ ] All figures in correct format (PDF/EPS for vector, PNG for raster)
- [ ] Bibliography compiles without errors
- [ ] No overfull/underfull box warnings
- [ ] Page limits respected
- [ ] Author information correct (check blind review requirements)
- [ ] Supplementary material separate
- [ ] PDF generated successfully
- [ ] Spell check completed

## BibTeX vs Biblatex for Submissions

| Publisher | Preferred |
|-----------|-----------|
| ACM | BibTeX |
| Elsevier | BibTeX |
| Springer | BibTeX or Biblatex |
| IEEE | BibTeX (IEEEtran.bst) |
| arXiv | Either |

**Safe choice**: Use BibTeX with publisher's `.bst` file unless biblatex explicitly supported.
