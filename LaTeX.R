# generate_dashboard_tex.R

# necessary imports
latex_code <- "
\\documentclass[a4paper,12pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage[margin=1in]{geometry}
\\usepackage{graphicx}
\\usepackage{float}
\\usepackage{caption}
\\usepackage{subcaption}
\\usepackage{fancyhdr}
\\usepackage{xcolor}
\\usepackage{titlesec}

% Define custom colors
\\definecolor{deepindigo}{HTML}{4B0082}
\\definecolor{red}{HTML}{E41A1C}
\\definecolor{blue}{HTML}{377EB8}
\\definecolor{gray}{HTML}{666666}

% Customize header and footer
\\pagestyle{fancy}
\\fancyhf{}
\\lhead{\\textcolor{gray}{Advertiser Dashboard}}
\\rhead{\\textcolor{gray}{Data Analysis}}
\\cfoot{\\textcolor{gray}{\\thepage}}

% Customize section titles
\\titleformat{\\section}
  {\\color{deepindigo}\\normalfont\\Large\\bfseries}{\\thesection}{1em}{}
\\titleformat{\\subsection}
  {\\color{blue}\\normalfont\\large\\bfseries}{\\thesubsection}{1em}{}



"
