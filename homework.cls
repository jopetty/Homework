% homework.cls
% A LaTeX class for typesetting homework assignments

% CLASS IDENTIFICATION
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2017/03/01 v0.1 A LaTeX class for typesetting homework assignments]

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CLASS DECLARATION %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

% PACKAGES
% Class Programming
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

% EVALUATE OPTIONS
\SetupKeyvalOptions{
	family=HW,
	prefix=HW@,
}

\DeclareBoolOption{qed} % Display QED symbol at the end of each Solution
\DeclareBoolOption{newpage} % Put each Problem on a new page
\DeclareBoolOption{hidesolutions} % Only display Problem
\DeclareBoolOption{noboxes} % Remove boxes around Problem
\DeclareBoolOption{grid} % Show background grid
\DeclareBoolOption{bib} % Print an MLA bibliography from references.bib

% Options for paper style
\newcommand{\@formatType}{pset}
\DeclareVoidOption{pset}{\renewcommand{\@formatType}{pset}}
\DeclareVoidOption{mla}{\renewcommand{\@formatType}{mla}}

\ProcessKeyvalOptions*

\ifdefstring{\@formatType}{mla}
{
	\LoadClass[12pt]{article}
}{
	\LoadClass{article}
}

% Text
\RequirePackage{kantlipsum}
\RequirePackage[bookmarks=true, hidelinks]{hyperref}
\RequirePackage{fontspec}
\RequirePackage{ragged2e}
\RequirePackage{titlesec}

% Tables
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}

% Time
\RequirePackage{datetime}

% Physics
\RequirePackage{physics}
\RequirePackage{siunitx}

% Math
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}

% Diagrams
\RequirePackage{tikz}
\RequirePackage[american, siunitx]{circuitikz}

% Code
\RequirePackage{minted}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}

% Formatting
\RequirePackage{framed}
\RequirePackage[pass]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}

% CLASS VARIABLES
\newcommand{\getlastpart}[2]{\@getlastpart#1#2 \@nil}
\def\@getlastpart#1#2 #3\@nil{%
	\expandafter\ifx\space#3
		\gdef#1{#2}%
		\expandafter\@gobble
	\else
		\expandafter\@firstofone
	\fi
	{\@getlastpart#1#3 \@nil}%
}
\def\name#1{\gdef\@name{#1}\getlastpart\lastname{#1}}

\newcommand{\@teacher}{TEACHER}
\newcommand{\teacher}[1]{\renewcommand{\@teacher}{#1}}

\newcommand{\@course}{COURSE}
\newcommand{\course}[1]{\renewcommand{\@course}{#1}}

\newcommand{\@due}{\today}
\newcommand{\due}[1]{\renewcommand{\@due}{#1}}

\newcommand{\@assignment}{ASSIGNMENT}
\newcommand{\assignment}[1]{\renewcommand{\@assignment}{#1}}

\newcommand{\@hwType}{Homework}
\newcommand{\hwtype}[1]{\renewcommand{\@hwType}{#1}}

\newcommand{\@problemLabel}{Problem}
\newcommand{\problemLabel}[1]{\renewcommand{\@problemLabel}{#1}}

\newcommand{\@pointLabel}{point}
\newcommand{\pointLabel}[1]{\renewcommand{\@pointLabel}{#1}}

\newcommand{\@solutionLabel}{Solution}
\newcommand{\solutionLabel}[1]{\renewcommand{\@solutionLabel}{#1}}

\newcommand{\@shortTitle}{\@assignment}

%%%%%%%%%%%%%
%%% Units %%%
%%%%%%%%%%%%%
\DeclareSIUnit{\mile}{mi}
\DeclareSIUnit{\gallon}{gallon}
\DeclareSIUnit{\pound}{lb}
\DeclareSIUnit{\foot}{ft}
\DeclareSIUnit{\atmosphere}{atm}
\DeclareSIUnit{\fahrenheit}{\degree F}
\DeclareSIUnit{\atom}{at}
\DeclareSIUnit{\molecule}{molecule}
\DeclareSIUnit{\calorie}{cal}
\DeclareSIUnit{\Calorie}{Cal}
\DeclareSIUnit{\inch}{in}

%%%%%%%%%%%%%%%%%%
%%% FORMATTING %%%
%%%%%%%%%%%%%%%%%%
% General
\usemintedstyle{tango}

% Fonts
\ifdefstring{\@formatType}{pset}
{
	\setmainfont{CMU Serif}
}{
	\setmainfont{Times New Roman}
}

% Time
\ifdefstring{\@formatType}{mla}
{
	\renewcommand{\today}{\number\day \space%
	\ifcase \month \or January\or February\or March\or April\or May%
	\or June\or July\or August\or September\or October\or November\or December\fi \ %
	\number \year}
}{}

% Page Geometry
\ifdefstring{\@formatType}{mla}
{
	\RaggedRight
	\newgeometry{margin=1in}
	\renewcommand{\baselinestretch}{2}
	\setlength{\parindent}{.5in}
	\setlength{\hangindent}{\parindent}
	\setlength{\RaggedRightParindent}{0.5in}
}{}

% Title
\ifdefstring{\@formatType}{pset}
{
	\if@titlepage
		\renewcommand{\maketitle}
		{
		\titlepage
		\begin{center}
			\vspace*{1cm}
			\Huge \@hwType\ \#\@hwnum\\
			\vspace*{1cm}
			\Large\@name\\
			\vspace*{1cm}
			\@course, \@term
		\end{center}
		\endtitlepage
		}
	\else
		\renewcommand{\maketitle}
		{
		\begin{center}
			{\hfill \@name} \\
			{\hfill \@course} \\
			{\hfill \@due} \\
			\vphantom{M}
			{\sc\large\@assignment}
		\end{center}
		}
	\fi
}{}
\ifdefstring{\@formatType}{mla}
{
	\newcommand{\heading}{{\setlength{\parindent}{0cm} \@name \\ \@teacher \\ \@course \\ \@date}}

	\newenvironment{tightcenter}{
		\setlength\topsep{0pt}
		\setlength\partopsep{0pt}
		\setlength\parskip{0pt}
		\begin{center}
	}{
		\end{center}
	}

	\renewcommand{\maketitle}{\heading\begin{tightcenter}\@assignment\end{tightcenter}}
}{}
\AtBeginDocument{\maketitle}

% Header
\ifdefstring{\@formatType}{mla}{
	\def\@fancyvbox#1#2{\vbox{#2}}
	\pagestyle{fancy}
	\lhead{}
	\chead{}
	\rhead{\lastname \ \thepage}
	\lfoot{}
	\cfoot{}
	\rfoot{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}{}

% Sections
\ifdefstring{\@formatType}{mla}{
	\titleformat{\section}[hang]{\normalfont\bf\uppercase	}{}{0em}{}[]
	\titlespacing*{\section}{0pt}{2ex plus 1ex minus .2ex}{0ex plus .2ex}

	\titleformat{\subsection}[runin]{\normalfont\it}{}{0em}{}[.\enspace]
	\titlespacing*{\subsection}{0pt}{0ex plus 1ex minus .2ex}{0ex plus .2ex}
}{}

% Bibliography
\ifdefstring{\@formatType}{mla}{
	\ifHW@bib
	\RequirePackage[style=mla, backend=biber]{biblatex}
	\RequirePackage{hyperref}
	\usepackage{enumitem}
	\addbibresource{references.bib}

	\setlength{\partopsep}{0pt}
	\setlength{\topsep}{0pt}
	\setlength{\parsep}{0pt}

	\defbibenvironment{bibliography}
		{\list
			{}
			{\setlength{\leftmargin}{\bibhang}%
			\setlength{\itemindent}{-\leftmargin}%
			\setlength{\itemsep}{\bibitemsep}%
			\setlength{\parsep}{\bibparsep}%
			\setlength{\partopsep}{0pt}%
			\setlength{\topsep}{0pt}}}
		{\endlist}
		{\item}

	\defbibheading{bibliography}[Works Cited]{\newpage\begin{tightcenter}#1\end{tightcenter}}
	\setlength\bibitemsep{0pt}

	\AtEndDocument{\printbibliography}
	\fi
}{}

% Problem Environment
\newcounter{@problemNumber}
\theoremstyle{definition}
\newtheorem{@problem}{\@problemLabel}
\numberwithin{equation}{@problem}
\newenvironment{problem}[1][]
{
	\stepcounter{@problemNumber}
	\ifHW@newpage
		\ifnum\value{@problemNumber}>1
			\newpage
		\fi
	\fi
	\notbool{HW@noboxes}{\framed\vspace{-1.5ex}}{}
	\@problem[#1]
	\pdfbookmark{\@problemLabel\ \arabic{@problem}}{prob-\arabic{@problem}}
}
{
	\end@problem
	\notbool{HW@noboxes}{\vspace{-1.5ex}\endframed}{}
}

\newcommand{\problemnumber}[1]%
{
	\setcounter{@problem}{#1}
	\addtocounter{@problem}{-1}
}

\newcommand{\@solutionTitleFormat}{\normalfont\bfseries}
\ifHW@hidesolutions
	\RequirePackage{comment}
	\excludecomment{solution}
\else
	\newenvironment{solution}
	{
		\proof[\@solutionTitleFormat\@solutionLabel]%
	}
	{
		\endproof
	}
\fi

% Parts
\newcommand{\@partLabelDefault}{\textup{(\alph*)}}
\newcommand{\@partLabel}{}

\@namedef{partLabel@a}{\renewcommand{\@partLabel}{\textup{(\alph*)}}}
\@namedef{partLabel@A}{\renewcommand{\@partLabel}{\textup{(\Alph*)}}}
\@namedef{partLabel@r}{\renewcommand{\@partLabel}{\textup{(\roman*)}}}
\@namedef{partLabel@R}{\renewcommand{\@partLabel}{\textup{(\Roman*)}}}
\@namedef{partLabel@n}{\renewcommand{\@partLabel}{\textup{(\arabic*)}}}

\newenvironment{parts}[1][a]
{
  \@ifundefined{partLabel@#1}
  {
    \@latex@error{Invalid parts environment option: #1}\@ehc
  }
  {
    \@nameuse{partLabel@#1}
  }
  \
  \enumerate%
  [ label=\@partLabel,
  , itemsep=1pt
  , parsep=1pt
  , topsep=0pt
  , partopsep=100pt
  , labelindent=0pt
  , labelwidth=4.5em
  , labelsep=0.5em
  , resume
  ]%
}
{
  \endenumerate
}
\renewcommand{\part}{\item}
\newcommand{\unresume}{\setcounter{enumi}{0}}

% Final
\newcommand{\final}[1]{\boxed{#1}}
