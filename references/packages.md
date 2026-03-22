# LaTeX Package Reference

## Table of Contents
1. [Document Structure](#document-structure)
2. [Mathematics](#mathematics)
3. [Graphics and Figures](#graphics-and-figures)
4. [Tables](#tables)
5. [Code Listings](#code-listings)
6. [Bibliography](#bibliography)
7. [Typography](#typography)
8. [Layout](#layout)

---

## Document Structure

### geometry - Page layout
```latex
\usepackage[margin=1in]{geometry}
\usepackage[a4paper,left=2cm,right=2cm,top=2.5cm,bottom=2.5cm]{geometry}
```

### hyperref - Hyperlinks and PDF metadata
```latex
\usepackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    urlcolor=cyan,
    pdftitle={Document Title},
    pdfauthor={Author Name}
}
```

### fancyhdr - Headers and footers
```latex
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{Left Header}
\fancyhead[R]{Right Header}
\fancyfoot[C]{\thepage}
```

---

## Mathematics

### amsmath - Core math environments
```latex
\usepackage{amsmath}

% Aligned equations
\begin{align}
    f(x) &= ax^2 + bx + c \\
    g(x) &= \int_0^x f(t)\,dt
\end{align}

% Matrices
\begin{pmatrix} a & b \\ c & d \end{pmatrix}
\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}
```

### amssymb - Extended symbols
```latex
\usepackage{amssymb}
% Provides: \mathbb{R}, \mathbb{N}, \therefore, \because
```

### amsthm - Theorem environments
```latex
\usepackage{amsthm}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}{Definition}

\begin{theorem}
Statement of theorem.
\end{theorem}
\begin{proof}
Proof goes here.
\end{proof}
```

### mathtools - Enhanced math (extends amsmath)
```latex
\usepackage{mathtools}
% Provides: \coloneqq, split environments, \DeclarePairedDelimiter
```

---

## Graphics and Figures

### graphicx - Include images
```latex
\usepackage{graphicx}

\includegraphics[width=0.8\textwidth]{image.png}
\includegraphics[height=5cm,keepaspectratio]{diagram.pdf}
```

### subfig / subcaption - Subfigures
```latex
\usepackage{subcaption}

\begin{figure}
    \centering
    \begin{subfigure}{0.45\textwidth}
        \includegraphics[width=\textwidth]{fig1.png}
        \caption{First}
    \end{subfigure}
    \hfill
    \begin{subfigure}{0.45\textwidth}
        \includegraphics[width=\textwidth]{fig2.png}
        \caption{Second}
    \end{subfigure}
    \caption{Combined caption}
\end{figure}
```

### tikz - Programmatic graphics
```latex
\usepackage{tikz}
\usetikzlibrary{shapes,arrows,positioning}

\begin{tikzpicture}
    \node[draw,circle] (A) {A};
    \node[draw,circle,right=of A] (B) {B};
    \draw[->] (A) -- (B);
\end{tikzpicture}
```

### pgfplots - Data visualization
```latex
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}

\begin{tikzpicture}
\begin{axis}[xlabel=$x$,ylabel=$y$]
    \addplot[blue,domain=0:10,samples=100]{sin(deg(x))};
\end{axis}
\end{tikzpicture}
```

---

## Tables

### booktabs - Professional tables
```latex
\usepackage{booktabs}

\begin{tabular}{lcc}
    \toprule
    Header 1 & Header 2 & Header 3 \\
    \midrule
    Data 1   & Data 2   & Data 3   \\
    Data 4   & Data 5   & Data 6   \\
    \bottomrule
\end{tabular}
```

### tabularx - Auto-width columns
```latex
\usepackage{tabularx}

\begin{tabularx}{\textwidth}{l X r}
    Left & Stretch to fill & Right \\
\end{tabularx}
```

### longtable - Multi-page tables
```latex
\usepackage{longtable}

\begin{longtable}{ll}
    \caption{Long table title} \\
    \toprule
    Col 1 & Col 2 \\
    \midrule
    \endfirsthead
    % Content continues across pages
\end{longtable}
```

---

## Code Listings

### listings - Basic code
```latex
\usepackage{listings}
\lstset{
    language=Python,
    basicstyle=\ttfamily\small,
    keywordstyle=\color{blue},
    commentstyle=\color{gray},
    numbers=left,
    breaklines=true
}

\begin{lstlisting}
def hello():
    print("Hello, World!")
\end{lstlisting}
```

### minted - Syntax highlighting (requires -shell-escape)
```latex
\usepackage{minted}

\begin{minted}{python}
def hello():
    print("Hello, World!")
\end{minted}
```

---

## Bibliography

### biblatex (Modern - Recommended)
```latex
\usepackage[backend=biber,style=numeric]{biblatex}
\addbibresource{references.bib}

% In document:
\cite{key}
\printbibliography
```

Common styles: `numeric`, `alphabetic`, `authoryear`, `apa`, `ieee`

### natbib (Traditional)
```latex
\usepackage{natbib}
\bibliographystyle{plainnat}

% In document:
\citep{key}  % (Author, Year)
\citet{key}  % Author (Year)
\bibliography{references}
```

---

## Typography

### microtype - Improved typography
```latex
\usepackage{microtype}
% Enables character protrusion and font expansion
```

### fontspec (XeLaTeX/LuaLaTeX) - System fonts
```latex
\usepackage{fontspec}
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}
```

### setspace - Line spacing
```latex
\usepackage{setspace}
\doublespacing
% or \onehalfspacing, \singlespacing
```

---

## Layout

### multicol - Multiple columns
```latex
\usepackage{multicol}

\begin{multicols}{2}
Text in two columns...
\end{multicols}
```

### enumitem - Customized lists
```latex
\usepackage{enumitem}

\begin{enumerate}[label=(\alph*),leftmargin=*]
    \item First
    \item Second
\end{enumerate}
```

### float - Float placement
```latex
\usepackage{float}

\begin{figure}[H]  % Force placement HERE
    \includegraphics{...}
\end{figure}
```
