# Version Control and Revision Tracking

## Git for LaTeX Projects

### .gitignore for LaTeX

```gitignore
# Auxiliary files
*.aux
*.log
*.out
*.toc
*.lof
*.lot
*.fls
*.fdb_latexmk
*.synctex.gz

# Bibliography
*.bbl
*.blg
*.bcf
*.run.xml

# Glossaries
*.glo
*.gls
*.glg
*.ist
*.acn
*.acr
*.alg

# Output (optional - some prefer to track)
# *.pdf

# Editor files
*.swp
*~
.DS_Store

# Build directories
build/
output/
```

### Recommended Workflow

```bash
# Initialize
git init
git add .tex .bib .cls .sty figures/
git commit -m "Initial commit"

# Feature branches for major changes
git checkout -b add-experiments-section
# ... make changes ...
git commit -am "Add experiments section with results"
git checkout main
git merge add-experiments-section

# Tag releases
git tag -a v1.0-submission -m "Initial journal submission"
git tag -a v2.0-revision -m "First revision after reviews"
```

## Latexdiff - Track Changes Between Versions

Generate a PDF highlighting additions (blue) and deletions (red strikethrough).

### Basic Usage

```bash
# Compare two files
latexdiff old.tex new.tex > diff.tex
pdflatex diff.tex

# Compare with git versions
latexdiff-vc --git -r HEAD~1 main.tex
# Creates main-diffHEAD~1.tex

# Compare specific commits
latexdiff-vc --git -r abc123 -r def456 main.tex

# Compare with tag
latexdiff-vc --git -r v1.0-submission main.tex
```

### Multi-file Documents

```bash
# Flatten first, then diff
latexpand old/main.tex > old-flat.tex
latexpand new/main.tex > new-flat.tex
latexdiff old-flat.tex new-flat.tex > diff.tex
```

### Customization Options

```bash
# Change markup style
latexdiff --type=CTRADITIONAL old.tex new.tex > diff.tex
# Types: UNDERLINE, CTRADITIONAL, TRADITIONAL, CFONT, FONTSTRIKE

# Exclude certain environments (e.g., figures)
latexdiff --exclude-textcmd="section" old.tex new.tex > diff.tex

# Handle math better
latexdiff --math-markup=3 old.tex new.tex > diff.tex
```

### Common Issues and Solutions

**Problem**: Diff doesn't compile
```bash
# Try different markup
latexdiff --type=TRADITIONAL old.tex new.tex > diff.tex

# Or use safer math handling
latexdiff --math-markup=0 old.tex new.tex > diff.tex
```

**Problem**: Missing packages in diff
```latex
% Add to diff.tex preamble if needed
\usepackage{ulem}
\usepackage{color}
```

## Git-latexdiff Wrapper

More convenient for git-based workflows:

```bash
# Install
# brew install git-latexdiff  # macOS

# Compare current with commit
git latexdiff HEAD~3 --main main.tex

# Compare two branches
git latexdiff main feature-branch --main main.tex

# Output to specific file
git latexdiff HEAD~1 --main main.tex -o revision-changes.pdf
```

## Track Changes for Collaborators

### Using changes Package

```latex
\usepackage[final]{changes}  % Remove 'final' to show changes
% \usepackage{changes}       % Show changes mode

\definechangesauthor[name={Reviewer 1}, color=blue]{R1}
\definechangesauthor[name={Author}, color=orange]{AU}

% In document:
\added[id=R1]{New text added by reviewer.}
\deleted[id=AU]{Text removed.}
\replaced[id=AU]{new text}{old text}
\comment[id=R1]{This needs clarification.}

% Summary of changes
\listofchanges
```

### Using todonotes Package

```latex
\usepackage{todonotes}

\todo{Fix this section}
\todo[inline]{Major revision needed here}
\missingfigure{Add results graph}

% List all todos
\listoftodos
```

## Revision Letter Template

When responding to reviewers, organize your diff:

```bash
# Create diff against submitted version
latexdiff-vc --git -r v1.0-submission main.tex

# Compile
pdflatex main-diffv1.0-submission.tex
biber main-diffv1.0-submission
pdflatex main-diffv1.0-submission.tex
pdflatex main-diffv1.0-submission.tex
```

Structure your revision:
```
revision/
├── response-to-reviewers.pdf
├── manuscript-revised.pdf
├── manuscript-diff.pdf          # Changes highlighted
└── supplementary-revised.pdf
```

## Best Practices

1. **Commit frequently** with meaningful messages
2. **Tag submission versions** for easy diff later
3. **Use branches** for major experimental changes
4. **Generate diff PDF** for every revision submission
5. **Keep .bib files** under version control
6. **Don't track** generated files (PDF, aux, etc.) unless needed
