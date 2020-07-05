#!/usr/bin/env python

"""
usage:

python add-metadata.py [--titlepage] A.ipynb > A'.ipynb
"""

import io
import os
import sys
import re

import nbformat

def get_text_contents(notebook):
    contents = ""
    for cell in notebook.cells:
        if cell.cell_type == 'markdown':
            contents += "".join(cell.source) + "\n\n"
    return contents
    
def get_title(notebook):
    """Return the title from a notebook file"""
    contents = get_text_contents(notebook)
    match = re.search(r'^# (.*)', contents, re.MULTILINE)
    title = match.group(1).replace(r'\n', '')
    return title

def add_document_metadata(notebook, titlepage):
    """Add document metadata"""
    # No cell toolbar for published notebooks
    #https://discourse.jupyter.org/t/cell-toolbar-and-tags/775
    if 'celltoolbar' in notebook.metadata:
        del notebook.metadata['celltoolbar']

    # Add table of contents
    notebook.metadata['toc'] = {
     "base_numbering": 1,
     "nav_menu": {},
     "number_sections": True,
     "sideBar": True,
     "skip_h1_title": True,
     "title_cell": "",
     "title_sidebar": "Contents",
     "toc_cell": False,
     "toc_position": {},
     "toc_section_display": True,
     "toc_window_display": True
    }
    notebook.metadata["toc-autonumbering"] = False


def add_metadata(filename, titlepage):
    # Read in
    with io.open(filename, 'r', encoding='utf-8') as f:
        notebook = nbformat.read(f, as_version=4)

    add_document_metadata(notebook, titlepage)
    
    # Write out
    # Include a newline at the end, as Jupyterlab does
    notebook_content = nbformat.writes(notebook) + '\n'
    sys.stdout.buffer.write(notebook_content.encode('utf-8'))
    
    
if __name__ == '__main__':
    if sys.argv[1] == "--titlepage":
        titlepage = True
        notebooks = sys.argv[2:]
    else:
        titlepage = False
        notebooks = sys.argv[1:]

    if not notebooks:
        print(__doc__, file=sys.stderr)
        sys.exit(1)
    
    for notebook in notebooks:
        add_metadata(notebook, titlepage)
