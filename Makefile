
src := src
main := main
artifacts := artifacts

tex := lualatex
texflags := --output-directory=$(artifacts) -interaction nonstopmode

bib := biber
bibflags := --output-directory=$(artifacts) --input-directory=$(artifacts)

main := main

precompile := true

.PHONY: all
all: $(main).pdf

draft: precompile := false
draft: $(main).pdf

$(main).pdf: $(artifacts)/$(main).pdf
	mv $^ $@

# Build the document.
.PHONY: $(artifacts)/$(main).pdf
$(artifacts)/$(main).pdf:
	! $(precompile) || $(tex) $(texflags) --draftmode $(src)/$(main).tex
	! $(precompile) || $(bib) $(bibflags) $(main)
	! $(precompile) || $(tex) $(texflags) --draftmode $(src)/$(main).tex
	$(tex) $(texflags) $(src)/$(main).tex

.PHONY: clean
clean:
	latexmk -CA -output-directory=$(artifacts) $(src)/$(main)
