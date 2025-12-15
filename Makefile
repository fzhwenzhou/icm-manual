# Makefile for compiling Markdown documentation to PDF

# Variables
SRC_DIR = src
OUTPUT_DIR = build
OUTPUT_PDF = $(OUTPUT_DIR)/icm-manual.pdf
MD_FILES = $(wildcard $(SRC_DIR)/*.md)

# Default target: Build the PDF
all: pdf

# Target to build the PDF
pdf: $(OUTPUT_PDF)

$(OUTPUT_PDF): $(MD_FILES)
	@mkdir -p $(OUTPUT_DIR)
	pandoc $(MD_FILES) -o $@ --from=markdown --to=pdf --pdf-engine=pdflatex -V geometry:margin=1in

# Clean up generated files
clean:
	rm -rf $(OUTPUT_DIR)

# Phony targets (not actual files)
.PHONY: all pdf clean