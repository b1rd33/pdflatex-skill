# latexmkrc - Project configuration for latexmk
# Place in project root as .latexmkrc or latexmkrc

# ============================================
# OUTPUT FORMAT
# ============================================
# 1 = pdflatex, 4 = lualatex, 5 = xelatex
$pdf_mode = 1;

# ============================================
# ENGINE CONFIGURATION
# ============================================
# pdflatex with synctex for editor integration
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# Uncomment for shell-escape (minted, tikz externalize)
# $pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode -synctex=1 %O %S';

# For XeLaTeX (custom fonts, Unicode)
# $pdf_mode = 5;
# $xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';

# For LuaLaTeX (advanced scripting)
# $pdf_mode = 4;
# $lualatex = 'lualatex -interaction=nonstopmode -synctex=1 %O %S';

# ============================================
# BIBLIOGRAPHY
# ============================================
$biber = 'biber %O %S';
$bibtex = 'bibtex %O %S';

# ============================================
# OUTPUT DIRECTORY
# ============================================
# Uncomment to build in separate directory
# $out_dir = 'build';
# $aux_dir = 'build';

# ============================================
# PREVIEW (macOS)
# ============================================
# Preview.app
$pdf_previewer = 'open -a Preview %O %S';

# Skim (better for continuous preview)
# $pdf_previewer = 'open -a Skim %O %S';

# ============================================
# GLOSSARIES SUPPORT
# ============================================
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
sub makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    my $return = system "makeglossaries '$base_name'";
    return $return;
}

# ============================================
# INDEX SUPPORT
# ============================================
$makeindex = 'makeindex -s %O -o %D %S';

# ============================================
# CLEAN EXTENSIONS
# ============================================
@generated_exts = qw(
    aux log out toc lof lot
    bbl blg bcf run.xml
    fls fdb_latexmk synctex.gz
    glo gls glg ist acn acr alg
    idx ind ilg
    nav snm vrb
);

# ============================================
# SAFETY
# ============================================
$max_repeat = 5;  # Prevent infinite loops
