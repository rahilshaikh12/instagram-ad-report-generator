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

\\begin{document}

\\begin{center}
    \\vspace*{0.5cm}
    {\\LARGE \\textbf{Advertiser Dashboard}}\\\\[0.5cm]
    {\\large A Visual Overview of Your Advertiser Data}\\\\[1cm]
\\end{center}

\\section*{Personal Information Access}
This section presents a donut chart that shows the proportion of advertisers that have access to your personal information versus those that do not. The graph segments the data into two categories, allowing you to quickly understand how many advertisers have (or do not have) direct access to your data.

\\begin{figure}[H]
    \\centering
    \\includegraphics[width=0.8\\textwidth]{plot_personal_info.png}
    \\caption{Advertisers with access to your personal information.}
\\end{figure}

\\section*{Interaction History}
This graph represents the number of advertisers with whom you have directly interacted---such as visiting their websites or making purchases. It illustrates your direct engagement level with these companies by dividing them into groups based on your interaction history.

\\begin{figure}[H]
    \\centering
    \\includegraphics[width=0.8\\textwidth]{plot_interaction.png}
    \\caption{Advertisers you've interacted with before.}
\\end{figure}

\\section*{Store Visits}
This section provides insights into your offline engagement with advertisers. The donut chart here distinguishes between advertisers whose physical stores you have visited and those you have not, helping you visualize your real-world interactions.

\\begin{figure}[H]
    \\centering
    \\includegraphics[width=0.8\\textwidth]{plot_visited.png}
    \\caption{Advertisers whose physical store you've visited.}
\\end{figure}





"
