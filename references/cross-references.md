# Smart Cross-Referencing with cleveref

## Overview

`cleveref` automatically generates reference names ("Figure 1", "Equation 2", etc.) - never hardcode these.

## Setup

```latex
% CRITICAL: Load in this exact order
\usepackage{varioref}   % Optional: extended refs
\usepackage{hyperref}   % Must be before cleveref
\usepackage{cleveref}   % Must be LAST
```

## Label Conventions

Always use descriptive prefixes:

| Type | Prefix | Example |
|------|--------|---------|
| Figure | `fig:` | `\label{fig:architecture}` |
| Table | `tbl:` | `\label{tbl:results}` |
| Equation | `eq:` | `\label{eq:loss-function}` |
| Section | `sec:` | `\label{sec:methodology}` |
| Algorithm | `alg:` | `\label{alg:training}` |
| Listing | `lst:` | `\label{lst:example-code}` |
| Theorem | `thm:` | `\label{thm:convergence}` |

## Basic Usage

```latex
% Single reference
See \cref{fig:architecture} for details.      % → "Figure 1"
See \Cref{fig:architecture} for details.      % → "Figure 1" (capitalized)

% Multiple references (auto-sorted and compressed)
\cref{fig:a,fig:b,fig:c}                      % → "Figures 1 to 3"
\cref{eq:1,eq:2,eq:5}                         % → "Equations 1, 2 and 5"

% Range
\crefrange{fig:first}{fig:last}               % → "Figures 1 to 5"

% Mixed types
\cref{fig:arch,tbl:results}                   % → "Figure 1 and Table 2"
```

## Configuration Options

```latex
% Full names instead of abbreviations
\usepackage[noabbrev]{cleveref}               % "Figure" not "Fig."

% Capitalize all references
\usepackage[capitalise]{cleveref}

% Custom format
\crefname{equation}{Eq.}{Eqs.}                % singular, plural
\Crefname{equation}{Equation}{Equations}      % capitalized forms
```

## Common Patterns

```latex
% In introduction - capitalize at sentence start
\Cref{sec:methods} describes our approach.

% Mid-sentence - lowercase
As shown in \cref{fig:results}, the model converges.

% Multiple with range
The results in \cref{tbl:main,tbl:ablation} and \crefrange{fig:1}{fig:4} demonstrate...

% With page references (requires varioref)
See \cref{fig:arch} \vpageref{fig:arch}.      % → "Figure 1 on page 5"
```

## Best Practices

1. **Never hardcode** reference names - let cleveref handle it
2. **Use descriptive labels** - `fig:training-curve` not `fig:1`
3. **Place `\label` after `\caption`** in figures/tables
4. **Load cleveref last** - after hyperref
5. **Be consistent** with prefix conventions across document
