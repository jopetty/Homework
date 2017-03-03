# Homework
`homework` is a LaTeX class for typesetting homework assignments. It can handle any Unicode input (so no more worrying about accent characters or writing in another language), and works for problem sets, book problems, lab reports, even essays.

## Goals

There's no shortage of homework *TeX classes, but this class is designed to be:

- **Easy To Use**: Writing in LaTeX is already hard enough without having to worry about custom requirements for a class. With this in mind, `homework` tries to abstract away much of the custom configuration required for different use cases, instead providing class options to customize each document while minimizing the extra code that must be written.
- **Semantically Coded**: Along with providing functionality for common parts of a generic homework assignment, `homework` attempts to add meaning to each custom command to improve readability — for example, instead of `\boxedanswer{}`, it makes more sense to call the command what it is: `\final{}`.
- **Unicode Compatible**: Unicode support in LaTeX is, in general, a mess. While there exist a variety of work arounds to support accented Latin characters (`\"{}`, `\'{}`, `\^{}`, etc.), this is an inelegant solution for a couple of reasons: first, it hampers the readability of the document (it's much easier to read/copy/paste `Paul Erdős` than it is `Paul Erd\H{o}s`). Second, it completely ignores the problem of writing in languages which do not use the Latin script, like Greek or Russian. This necessitates the loading of other packages (`babel`, `polyglossia`), each of which come with their own complexity and have the propensity to break the document if package conflict arrises. Instead, `homework` opts for a much nicer solution: to use `XeLaTeX` to allow for fully Unicode-Compatible source documents.
- **Flexible**: Not every homework assignment is a problem set, but many existing homework classes provide only a single format for documents. While this can be avoided by using more than one document class and choosing the appropriate one for the assignment at hand, this introduces uneeded complexity. Plus, wouldn't it be nice to still have access to all the same commands, even if the end result was an essay instead of a lab report? `homework` provides the `pset` (default) and `mla` formats, allowing you to switch between a standard problem set and an MLA formatted essay, inluding a properly formatted Works Cited page.

## Documentation

### Prerequisites

To use `homework`, you must have the following installed on your system:

- `XeLaTeX` 
- `Python`
- The `pygments` Python package
- CMU & Times New Roman fonts

### Compilation

To compile `homework` documents, run the following commands in your shell:

`xelatex [-shell-escape] [-8bit] ROOT`, where `ROOT` is the main `*.tex` file, with or without the extension.

- The `-shell-escape` flag allows for `pygments` to be run while compiling the document.
- The `-8bit` flag is necessary to correct a bug in xelatex which causes tab literals to be encoded incorrectly, which messes up code to be displayed in documents.

These flags are required if you are going to be including syntax-highted code in your documents, and can be omitted if not.

### Usage

A basic `homework` document looks something like this:

```latex
\documentclass[<class-options>]{homework}

\name{YOUR NAME}
\teacher{TEACHER}
\course{COURSE}
\due{\today}

\assignment{ASSIGNMENT}

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

#### Formats

- `pset`: This is the default format provided by the class; it uses the CMU Font with wide margins, and is suitable for most STEM related homework assignments.
- `mla`: This makes the document conform to the MLA specifications for a research paper, including 12pt Times New Roman, 1-inch margins, an automatically generated Works Cited page, and a header in the form `Lastname Pagenumber`. 

#### Problem/Solution Options

- `qed`: Place a QED marker at the end of each solution
- `newpage`: Place each problem on its own page.
- `hidesolutions`: Don't display the solutions in the resultant PDF.
- `noboxes`: Remove the boxes around each problem.

#### MLA Options

- `bib`: Load an MLA formatted bibliography from a file named `references.bib`.

### Document Macros

| Option          | Description                              | Default Value |
| --------------- | ---------------------------------------- | ------------- |
| `\name{}`       | Your name. This will appear at the beginning of each document and, if in `mla` mode, automatically extract your last name for the header. | `YOUR NAME`   |
| `\teacher{}`    | Your teacher's name. This is not used in `pset` mode. | `TEACHER`     |
| `\course{}`     | The name of the class or course          | `COURSE`      |
| `\class{}`      | See above                                |               |
| `\due{}`        | When the assignment is due               | `\today`      |
| `\assignment{}` | The title of the assignment              | `ASSIGNMENT`  |

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
