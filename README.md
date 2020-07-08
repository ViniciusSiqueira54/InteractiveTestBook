[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ViniciusSiqueira54/InteractiveTestBook/master)

# InteractiveTestBook

## About this book

This is a Kick-off of an interactive book to address software testing subjects.

## A book with multiple purposes
you can use this book in different ways, for now we have been provided two ways to begin:
* you can read the chapters in your browser; or
* you can interact with the chapters as Jupyter Notebooks, with this you can edit or/and extend the code and execute this live in your browser.

## Who this Book is for
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultricies nisl ante, quis tempus turpis tristique sit amet. Donec purus erat, finibus et egestas eget, viverra ac sapien. Ut tristique molestie fringilla. Aenean ac arcu et leo bibendum tempor. Mauris tristique efficitur auctor. Vivamus et odio sem. Morbi consectetur lorem vitae malesuada pharetra. Praesent id arcu quis est luctus vestibulum. Nullam elementum malesuada egestas.

## News
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultricies nisl ante, quis tempus turpis tristique sit amet. Donec purus erat, finibus et egestas eget, viverra ac sapien. Ut tristique molestie fringilla. Aenean ac arcu et leo bibendum tempor. Mauris tristique efficitur auctor. Vivamus et odio sem. Morbi consectetur lorem vitae malesuada pharetra. Praesent id arcu quis est luctus vestibulum. Nullam elementum malesuada egestas.

## About the Authors
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultricies nisl ante, quis tempus turpis tristique sit amet. Donec purus erat, finibus et egestas eget, viverra ac sapien. Ut tristique molestie fringilla. Aenean ac arcu et leo bibendum tempor. Mauris tristique efficitur auctor. Vivamus et odio sem. Morbi consectetur lorem vitae malesuada pharetra. Praesent id arcu quis est luctus vestibulum. Nullam elementum malesuada egestas.

## New Chapters

To add new chapters to our book, you can submit a new Pull Request to our project. In this PR is necessary:

### Add new file

1. Add the markdown file (the new chapter content) on the `#/docs/chapters`.

For example, the directory structure is as follows:

```text
	.
	└── docs
	    └── chapters
	        ├── cap00.md
	        ├── cap01.md
	        ├── cap02.md
	        └── NewCapEg.md
```

### Update Sidebar

2. Update the `_sidebar.md` file to show the new chapter added on the sidebar menu:

```markdown
* <!-- The Interactive Book -->
    * [Aprendendo Markdown](chapters/cap00.md "Introdução")
    * [JUnit + Hamcrest](chapters/cap01.md "Cap 01")
    * [Capítulo 2](chapters/cap02.md "Cap 02")
    * [The New Chapter](NewCapEg.md "New Chapter")
    * [Siga-nos no Twitter](chapters/Twitter.md "Siga-nos")
```


## TODO

- [ ] Fix search tool
- [ ] Check Twitter PlugIn
- [ ] Automate the addition of new chapters
