# Publication-Quality Tables with siunitx and booktabs

## Overview

Combine `siunitx` (number alignment, units) with `booktabs` (professional rules) for publication-ready tables.

## Setup

```latex
\usepackage{booktabs}
\usepackage{siunitx}

% Global configuration
\sisetup{
    round-mode = places,
    round-precision = 2,
    group-separator = {,},
    detect-weight = true
}
```

## Decimal-Aligned Columns

```latex
% S column type aligns numbers at decimal point
\begin{tabular}{l S[table-format=3.2] S[table-format=2.1]}
    \toprule
    Material & {Density (\si{g/cm^3})} & {Porosity (\%)} \\
    \midrule
    Concrete & 2.35  & 15.2 \\
    Steel    & 7.85  & 0.5  \\
    Wood     & 0.65  & 42.3 \\
    \bottomrule
\end{tabular}
```

**Note**: Headers in S columns need `{braces}` to prevent parsing as numbers.

## table-format Specification

`table-format = A.B` where:
- `A` = digits before decimal
- `B` = digits after decimal

```latex
S[table-format=3.2]     % e.g., 123.45
S[table-format=2.1]     % e.g., 12.3
S[table-format=-1.3]    % negative numbers: -1.234
S[table-format=1.2e2]   % scientific: 1.23e10
```

## Units with siunitx

```latex
% Inline units
The mass is \SI{5.2}{kg}.
Temperature: \SI{25}{\celsius}
Speed: \SI{3e8}{m/s}

% Unit only
\si{kg.m/s^2}           % kg⋅m/s²
\si{\kilo\gram\per\second}

% Common units
\si{\metre}, \si{\second}, \si{\kelvin}
\si{\percent}, \si{\degree}
```

## Uncertainty Values

```latex
\sisetup{separate-uncertainty = true}

% Value with uncertainty
\num{1.234(5)}          % 1.234 ± 0.005
\SI{9.81(2)}{m/s^2}     % 9.81 ± 0.02 m/s²

% Explicit
\num{1.234 \pm 0.005}
```

## Complete Example: Results Table

```latex
\begin{table}[htbp]
    \centering
    \caption{Model performance comparison.}
    \label{tbl:results}
    \sisetup{table-format=2.2, round-precision=2}
    \begin{tabular}{l S S S[table-format=1.3]}
        \toprule
        Model & {Accuracy (\%)} & {F1 Score} & {Latency (s)} \\
        \midrule
        Baseline    & 75.32 & 0.72 & 0.045 \\
        ResNet-50   & 89.15 & 0.87 & 0.123 \\
        Transformer & 92.48 & 0.91 & 0.234 \\
        \textbf{Ours} & \bfseries 94.21 & \bfseries 0.93 & 0.156 \\
        \bottomrule
    \end{tabular}
\end{table}
```

## Booktabs Rules

| Rule | Usage |
|------|-------|
| `\toprule` | Top of table |
| `\midrule` | Between header and body |
| `\bottomrule` | Bottom of table |
| `\cmidrule{a-b}` | Partial rule (columns a to b) |
| `\addlinespace` | Extra vertical space |

**Never use vertical lines** - they're considered poor typographic practice.

## Multi-row Headers

```latex
\begin{tabular}{l S S S S}
    \toprule
    & \multicolumn{2}{c}{Training} & \multicolumn{2}{c}{Test} \\
    \cmidrule(lr){2-3} \cmidrule(lr){4-5}
    Model & {Loss} & {Acc.} & {Loss} & {Acc.} \\
    \midrule
    ...
\end{tabular}
```

## Best Practices

1. **Always use booktabs** - no `\hline`, no vertical lines
2. **Align numbers at decimal** with S columns
3. **Put units in headers** not repeated in every cell
4. **Caption above table** (below for figures)
5. **Consistent precision** across columns
6. **Bold best results** for comparison tables
