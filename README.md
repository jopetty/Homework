# Homework
`homework` is a LaTeX class for typesetting homework assignments. It can handle any Unicode input (so no more worrying about accent characters or writing in another language), and works for problem sets, book problems, lab reports, even essays.

## Goals

There's no shortage of homework *TeX classes, but this class is designed to be:

- **Easy To Use**: Writing in LaTeX is already hard enough without having to worry about custom requirements for a class. With this in mind, `homework` tries to abstract away much of the custom configuration required for different use cases, instead providing class options to customize each document while minimizing the extra code that must be written.
- **Semantically Coded**: Along with providing functionality for common parts of a generic homework assignment, `homework` attempts to add meaning to each custom command to improve readability — for example, instead of `\boxedanswer{}`, it makes more sense to call the command what it is: `\final{}`.
- **Unicode Compatible**: Unicode support in LaTeX is, in general, a mess. While there exist a variety of work arounds to support accented Latin characters (`\"{}`, `\'{}`, `\^{}`, etc.), this is an inelegant solution for a couple of reasons: first, it hampers the readability of the document (it's much easier to read/copy/paste `Paul Erdős` than it is `Paul Erd\H{o}s`). Second, it completely ignores the problem of writing in languages which do not use the Latin script, like Greek or Russian. This necessitates the loading of other packages (`babel`, `polyglossia`), each of which come with their own complexity and have the propensity to break the document if package conflict arrises. Instead, `homework` opts for a much nicer solution: to use `XeLaTeX` to allow for fully Unicode-Compatible source documents.

## Documentation

### Prerequisites

To use `homework`, you must have, at minimum, a LaTeX distribution installed on our system. If you want to highlight source code in your LaTeX documents (like documenting `c` code, for example), you will need to install `Python` and the `pygments` python package. If you intend to compile your documents with `xelatex` and want to use a specific font, you must have that font installed on your computer. I reccomend installing the CMU fonts, which expand the default Computer Modern TeX fonts to support unicode.

### Compilation

To compile `homework` documents, run the following commands in your shell:

`pdflatex ROOT` or `xelatex ROOT`, where `ROOT` is the main `*.tex` file, with or without the extension.

If your LaTeX file contains source code to be displayed, you will need to add the `-shell-escape` flag. If you are compiling with xelatex, you will need the additional flag `-8bit` when compiling documents with formatted source code to correct a bug in xelatex which causes tab literals to be encoded correctly.

```bash
# compiling with pdflatex
pdflatex main.tex

# compiling with pdflatex, using pygments to format source code
pdflatex -shell-escape main.tex

# compiling with xelatex
xelatex main.tex

# compiling with xelatex, using pygments to format source code
xelatex -shell-escape -8bit main.tex
 
```

### Usage

A basic `homework` document looks something like this:

```latex
\documentclass[<class-options>]{homework}

\author{YOUR NAME}
\course{COURSE}
\due{\today}

\title{ASSIGNMENT}

\begin{document}

	\begin{problem}
		% ...
	\end{problem}
	\begin{solution}
		% ...
	\end{solution}

\end{document}
```

You can use the template.tex as a starting point for your own homework assignments.

### Class Options
#### Problem/Solution Options

- `qed`: Place a QED marker at the end of each solution
- `newpage`: Place each problem on its own page.
- `hidesolutions`: Don't display the solutions in the resultant PDF.
- `noboxes`: Remove the boxes around each problem.

### Document Macros

| Option          | Description                              | Default Value |
| --------------- | ---------------------------------------- | ------------- |
| `\author{}`       | Your name. This will appear at the beginning of each document and, if in `mla` mode, automatically extract your last name for the header. | `Your Name`   |
| `\course{}`     | The name of the class or course          | `Course`      |
| `\due{}`        | When the assignment is due               | `\today`      |
| `\title{}` | The title of the assignment              | `Title`  |

### Packages Loaded

`homework` loads a number of LaTeX packages by default to simplify the writing workflow.

| Category       | Package         | Options                     |
| -------------- | --------------- | --------------------------- |
| **Text**       | `kantlipsum`    |                             |
|                | `hyperref`      | `bookmarks=true, hidelinks` |
|                | `fontspec`      |                             |
|                | `ragged2e`      |                             |
|                | `titlesec`      |                             |
| **Tables**     | `array`         |                             |
|                | `tabularx`      |                             |
|                | `booktabs`      |                             |
| **Time**       | `datetime`      |                             |
| **Physics**    | `physics`       |                             |
|                | `siunitx`       |                             |
| **Math**       | `amsmath`       |                             |
|                | `amssymb`       |                             |
|                | `amsthm`        |                             |
|                | `mathtools`     |                             |
| **Chemistry**  | `mhchem`        |                             |
| **Diagrams**   | `tikz`          |                             |
|                | `circuitikz`    | `american, siunitx`         |
| **Code**       | `minted`        |                             |
|                | `algorithm`     |                             |
|                | `algpseudocode` |                             |
| **Formatting** | `framed`        |                             |
|                | `geometry`      | `pass`                      |
|                | `fancyhdr`      |                             |
|                | `enumitem`      |                             |

### Custom Functionality

#### New Macros

| Macro      | Usage                                    |
| ---------- | ---------------------------------------- |
| `\final{}` | Places a box around an answer to denote a final answer from other steps in a solution |
| `\note{}`  | Highlights text in yellow

#### Additional Units

`homework` defines several additional units to complement those provided by `siunitx`.

| Command       | Definition  |
| ------------- | ----------- |
| `\mile`       | `mi`        |
| `\gallon`     | `gallon`    |
| `\pound`      | `lb`        |
| `\foot`       | `ft`        |
| `\atmosphere` | `atm`       |
| `\fahrenheit` | `\degree F` |
| `\atom`       | `at`        |
| `\molecule`   | `molecule`  |
| `\calorie`    | `cal`       |
| `\Calorie`    | `Cal`       |
| `\inch`       | `in`        |

## Credits

`homework` is based on the [latex-homework](https://github.com/artemmavrin/latex-homework) project by @artemmavrin.

## License

This code is distributed under the MIT license.

## Change Log

### v1.2.0
- Removed `xelatex` dependency so documents can now also be compiled with `pdflatex`
- Added default values the document macros so that compilation would not silently crash if no values were provided

### v1.1.1
- Adopted semantic versioning
- Change `v1.0` to `v0.1` to correct earlier, erroneous change to pre-1.0.0 versioning

### v1.1
- Updated `\part` to allow to allow an optional argument to serve as the reference label: `\part[q:1:a]` instead of `\part\label{q:1:a}`
- Added `mhchem` package to allow for typesetting chemical equations
- Updated version numbering

### v0.1
- Initial release
