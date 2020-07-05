# InteractiveTestBook Makefile

# Where the notebooks are
NOTEBOOKS = chapters

# Git repo
GITHUB_REPO = https://github.com/ViniciusSiqueira54/InteractiveTestBook

# Binder link
BINDER_URL = https://mybinder.org/v2/gh/ViniciusSiqueira54/InteractiveTestBook/master

# Sources in the notebooks folder
SOURCES = $(NOTEBOOKS)

# Where to place the html
HTML_TARGET = html/

# Files to appear on the Web page
DOCS = $(NOTEBOOKS:%.ipynb=%) 

# Various derived files
HTMLS = $(SOURCES:%.ipynb=$(HTML_TARGET)%.html)

# Configuration
# The site
SITE = https://viniciussiqueira54.github.io/InteractiveTestBook/

## TOOLS
# Python
PYTHON ?= python3

# Jupyter
JUPYTER ?= jupyter

# The nbconvert alternative
NBCONVERT ?= $(JUPYTER) nbconvert

# Program to open files after creating, say OPEN=open (default: ignore; "true" does nothing)
OPEN ?= true

# Make directory
MKDIR = mkdir -p

# Book base name
BOOK = fuzzingbook

# Use standard Jupyter tools
ifeq ($(SOURCES),nbconvert)
CONVERT_TO_HTML   = $(NBCONVERT) --to html --output-dir=$(HTML_TARGET)
endif

# Short targets
# Default target is "chapters", as that's what you'd typically like to recreate after a change
.PHONY: chapters default
chapters default: html code

# Individual targets
.PHONY: html pdf python code slides word doc docx md markdown epub
.PHONY: full-notebooks full fulls rendered-notebooks rendered renders book-pdf book-html
html:	ipypublish-chapters $(HTMLS)

.PHONY: edit jupyter lab notebook
# Invoke notebook and editor: `make jupyter lab`
edit notebook:
	$(JUPYTER) notebook

lab:
	$(JUPYTER) lab
	
jupyter:

# Run a notebook, (re)creating all output cells
ADD_METADATA = utils/add_metadata.py

$(FULL_NOTEBOOKS)/%.ipynb: $(NOTEBOOKS)/%.ipynb $(DEPEND_TARGET)%.makefile $(ADD_METADATA) $(NBAUTOSLIDE) $(NBSYNOPSIS)
	$(EXECUTE_NOTEBOOK) $<
	$(PYTHON) $(ADD_METADATA) $@ > $@~ && mv $@~ $@

# index.html comes with relative links (html/) such that the beta version gets the beta menu
$(DOCS_TARGET)index.html: \
	$(FULL_NOTEBOOKS)/index.ipynb $(HTML_DEPS)
	@test -d $(DOCS_TARGET) || $(MKDIR) $(DOCS_TARGET)
	@test -d $(HTML_TARGET) || $(MKDIR) $(HTML_TARGET)
	$(CONVERT_TO_HTML) $<
	mv $(HTML_TARGET)index.html $@
	@cd $(HTML_TARGET) && $(RM) -r index.nbpub.log index_files
	$(PYTHON) utils/post_html.py --menu-prefix=html/ --home $(POST_HTML_OPTIONS)$(HOME_POST_HTML_OPTIONS) $@
	@$(OPEN) $@

## Some checks
# Add notebook metadata (add table of contents)
.PHONY: metadata
metadata: $(ADD_METADATA)
	@for notebook in $(SOURCES); do \
		echo "Adding metadata to $$notebook...\c"; \
		$(PYTHON) $(ADD_METADATA) $$notebook > $$notebook~ || exit 1; \
		if diff $$notebook $$notebook~; then \
			echo "unchanged."; \
		else \
		    mv $$notebook~ $$notebook; \
			echo "done."; \
		fi; \
		$(RM) $$notebook~; \
	done

# Add/update HTML code in Web pages
.PHONY: publish-html publish-html-setup
publish-html: html publish-html-setup \
	$(DOCS_TARGET)html/00_Index.html \
	$(DOCS_TARGET)html/00_Table_of_Contents.html \
	$(DOCS_TARGET)html/custom.css \
	$(DOCS_TARGET)html/favicon \
	$(DOCS:%=$(DOCS_TARGET)html/%.html) \
	$(DOCS:%=$(DOCS_TARGET)html/%_files)
	
publish-html-setup:
	@test -d $(DOCS_TARGET) || $(MKDIR) $(DOCS_TARGET)
	@test -d $(DOCS_TARGET)html || $(MKDIR) $(DOCS_TARGET)html
	
$(DOCS_TARGET)html/%: $(HTML_TARGET)%
	cp -pr $< $@

# Table of contents
.PHONY: toc
toc: $(DOCS_TARGET)notebooks/00_Table_of_Contents.ipynb
$(DOCS_TARGET)notebooks/00_Table_of_Contents.ipynb: utils/nbtoc.py \
	$(TOC_CHAPTERS:%=$(DOCS_TARGET)notebooks/%) \
	$(TOC_APPENDICES:%=$(DOCS_TARGET)notebooks/%) \
	$(CHAPTERS_MAKEFILE) \
	$(SITEMAP_SVG)
	$(RM) $@
	$(PYTHON) utils/nbtoc.py \
		--chapters="$(TOC_CHAPTERS:%=$(DOCS_TARGET)notebooks/%)" \
		--appendices="$(TOC_APPENDICES:%=$(DOCS_TARGET)notebooks/%)" > $@
	$(EXECUTE_NOTEBOOK) $@ && mv $(FULL_NOTEBOOKS)/00_Table_of_Contents.ipynb $@
	$(PYTHON) $(ADD_METADATA) $@ > $@~ && mv $@~ $@
	$(JUPYTER) trust $@
	@$(OPEN) $@
		
## Binder services
# Force recreation of binder service; avoids long waiting times for first user
.PHONY: binder
binder: .FORCE
	open $(BINDER_URL)

# After a git push, we want binder to update; "make push" does this
.PHONY: push
push: .FORCE
	git push
	open $(BINDER_URL)

# Debugging binder
# This is the same system as mybinder uses, but should be easier to debug
# See https://repo2docker.readthedocs.io/en/latest/
.PRECIOUS: binder/binder.log
.PHONY: binder-local debug-binder
binder-local debug-binder: binder/binder.log binder/postBuild
binder/binder.log: .FORCE
	@echo Writing output to $@
	@docker version > /dev/null
	jupyter-repo2docker --debug $(GITHUB_REPO) 2>&1 | tee $@

## Getting rid of stray processes and workspaces
kill:
	-pkill -HUP -l -f jupyter-lab Firefox.app firefox-bin runserver
	$(RM) $$HOME/lab/workspaces/*.jupyterlab-workspace

## Cleanup
.PHONY: clean-code 
clean-code:
	$(RM) $(PYS) $(PYS_OUT)

.PHONY: clean-full-notebooks clean-full clean-fulls 
.PHONY: clean-docs clean realclean
clean-full-notebooks clean-full clean-fulls:
	$(RM) $(FULLS)

clean-docs:
	$(RM) -r $(DOCS_TARGET)html $(DOCS_TARGET)notebooks

clean: clean-code clean-docs clean-fulls
	@echo "All derived files deleted"

realclean: clean
	cd $(HTML_TARGET); $(RM) *.html; $(RM) -r *_files
	@echo "All old files deleted"

## A bit of Makefile debugging
# See http://www.drdobbs.com/tools/debugging-makefiles/197003338#
# Use "make print-VAR" to see the value of VAR, e.g. "make print-NBDEPEND"
print-%: ; @$(error $* = $($*) (defined as $* = $(value $*) from $(origin $*)))

# Use "make DEBUG=1" to get better diagnostics why a command gets executed
ifdef DEBUG
OLD_SHELL := $(SHELL)
SHELL = $(warning creating $@ from $^: $? is newer)$(OLD_SHELL)
endif