# Instagram Ad Report Generator

## Overview

This project aims to promote transparency around digital privacy by analyzing which advertisers have access to your Instagram data and how they interact with it. It automates the creation of a visual dashboard that reveals insights into your advertising profile, helping you better understand the scope of personal data access and targeting.

The pipeline:
1. Runs an R script to process and visualize your data.
2. Automatically generates a LaTeX file for reporting.
3. Compiles it into a polished PDF dashboard.

## How to Get Your Instagram Advertiser Data

To obtain the required data file from Instagram:

1. Go to your [Instagram Settings]([https://www.instagram.com/accounts/privacy_and_security/](https://accountscenter.instagram.com/info_and_permissions/dyi/?theme=dark)).
2. Click on **"Download Your Information"**.
3. Click on **"Some of your information"**.
4. Select all options in **"Ads Information"**.
5. Select **"Download to Device"**.
6. Select the required date range (all time recommended)
7. Request a copy of your data in **JSON** format.
8. Once you receive and extract the ZIP, locate the file: **advertisers_using_your_activity_or_information.json**
9. Move the file into this folder


## Files Required

- **advertisers_using_your_activity_or_information.json**: The JSON data file. (Not included)
- **code.R**: The R script that processes the JSON file and generates graphs (using `ggsave()`).
- **LaTeX.R**: The R script that automatically creates the LaTeX file (`dashboard.tex`).
- **dashboard.tex**: The LaTeX file (generated automatically).
- **Makefile**: Automates the entire process.
- **README.md**: This file with instructions.

## Requirements

- **R** (with the required packages: `tidyverse`, `rjson`, `UpSetR`)
- **pdflatex** (a LaTeX compiler)
- **make** (to run the Makefile; on Windows, consider using MinGW or Cygwin)

### Installing a LaTeX Distribution on macOS

If you get an error like `pdflatex: No such file or directory`, it means that a LaTeX distribution is not installed or is not in your system’s PATH. On macOS, the recommended distribution is **MacTeX**.

#### Steps to Install MacTeX:

1. **Download and Install MacTeX:**
   - You can download MacTeX from [MacTeX's website](https://tug.org/mactex/), or install it via Homebrew with:
     ```bash
     brew install --cask mactex
     ```
2. **Update Your PATH:**
   - MacTeX installs binaries in `/Library/TeX/texbin`. To ensure that `pdflatex` is available in your Terminal, you must add this directory to your PATH.
   - **For zsh (default on recent macOS versions):**
     1. Open Terminal.
     2. Open your `.zshrc` file in a text editor (using nano for example):
        ```bash
        nano ~/.zshrc
        ```
     3. Add the following line at the end of the file:
        ```bash
        export PATH="/Library/TeX/texbin:$PATH"
        ```
     4. Save the file by pressing **Control + O** and then **Enter**.
     5. Exit nano by pressing **Control + X**.
     6. Reload your profile with:
        ```bash
        source ~/.zshrc
        ```
   - **For bash:**
     1. Open Terminal.
     2. Open your `.bash_profile` file:
        ```bash
        nano ~/.bash_profile
        ```
     3. Add the same export line:
        ```bash
        export PATH="/Library/TeX/texbin:$PATH"
        ```
     4. Save, exit, and reload with:
        ```bash
        source ~/.bash_profile
        ```

## Setup & Execution

1. **Place All Files in the Same Folder:**  
   Ensure that `advertisers_using_your_activity_or_information.json`, `code.R`, `LaTeX.R`, and `Makefile` are all in the same directory.

2. **Run the Automation:**
   - Open a terminal or command prompt in the project directory.
   - Execute the command:
     ```bash
     make
     ```
   This command will:
   - Run `myscript.R` to generate the graphs.
   - Run `generate_dashboard_tex.R` to create `dashboard.tex`.
   - Compile `dashboard.tex` (using `pdflatex`) to produce `dashboard.pdf`.  
   (The LaTeX compilation runs twice to resolve all references.)

3. **View the Dashboard:**  
   Open `dashboard.pdf` to view your final, automated dashboard.

## Cleanup

To remove generated files and auxiliary files, run:
```bash
make clean
```

## Sample Insights from Personal Data

Here are a few example insights the dashboard revealed using my own Instagram data:

- **Over 200 companies** had access to my personal information, despite only interacting with a small fraction of them directly.
- **70% of advertisers** who had my data had no recorded engagement — meaning they may have received my info through data sharing or partnerships.
- **Some companies** appeared across multiple categories (e.g., accessed my data and were visited physically), suggesting stronger ad targeting relationships.
- **Donut charts** helped visualize the imbalance between data access and actual user interaction.
- **UpSet plots** revealed overlaps between advertisers with data access, direct interaction, and store visits — surfacing interesting clusters.

> These patterns raised questions about how widely user data is circulated and how little control or awareness users may have over it. The goal of this project is to bring that to light in a clear, visual way.

### 📊 Sample Visuals

**1. Advertisers with Access to Personal Information**  
![Donut Chart – Access to Personal Info](https://imgur.com/8ZuYASL)

**2. Advertisers You’ve Interacted With**
![Bar Chart – Interaction History](images/interaction_chart_placeholder.png)

**3. Overlap of Advertisers Across Categories (UpSet Plot)**
![UpSet Plot – Overlapping Ad Categories](images/upset_plot_placeholder.png)

