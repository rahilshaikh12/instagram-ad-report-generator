# Makefile

# File names (update myscript.R to your R script name if needed)
RSCRIPT = code.R
JSONFILE = advertisers_using_your_activity_or_information.json
LATEXFILE = dashboard.tex
PDF = dashboard.pdf
GEN_LATEX = LateX.R

# Default target: build the final PDF dashboard
all: $(PDF)

# The final PDF depends on the images and the LaTeX file
$(PDF): plot_personal_info.png plot_interaction.png plot_visited.png plot_interaction_personal.png $(LATEXFILE)
	pdflatex $(LATEXFILE)
	pdflatex $(LATEXFILE)

# Generate the LaTeX file by running the R script that creates it
$(LATEXFILE): $(GEN_LATEX)
	Rscript $(GEN_LATEX)

# Generate the plot images by running your R script (which uses ggsave)
plot_personal_info.png plot_interaction.png plot_visited.png plot_interaction_personal.png: $(RSCRIPT) $(JSONFILE)
	Rscript $(RSCRIPT)

# Clean up auxiliary files and outputs
clean:
	rm -f *.aux *.log *.out $(PDF) plot_personal_info.png plot_interaction.png plot_visited.png plot_interaction_personal.png $(LATEXFILE)
