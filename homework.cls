%% homework.cls
%%
%% A LaTeX3 class for typesetting homework assignments.

\RequirePackage{expl3, xparse, ifxetex}

\ExplSyntaxOn

%% MARK: Class Metadata
%% Provides information to the LaTeX3 compiler
%% about what our class does.
\tl_const:Nn \c__homework_class_name_tl         {homework}
\tl_const:Nn \c__homework_class_version_tl      {1.2.0}
\tl_const:Nn \c__homework_class_date_tl         {2017/09/16}
\tl_const:Nn \c__homework_class_description_tl  {A~LaTeX3~class~for~typesetting~homework~assignments}
\tl_const:Nn \c__homework_class_parent_class_tl {article}

\ProvidesExplClass{\c__homework_class_name_tl}          % Class name
                  {\c__homework_class_date_tl}          % date
                  {\c__homework_class_version_tl}       % version
                  {\c__homework_class_description_tl}   % description

%% MARK: Class Data
%% Data set by the user about the course or assignment.
%% Used to create title page.
\tl_new:N	\g_homework_author_tl
\tl_new:N	\g_homework_title_tl
\tl_new:N	\g_homework_date_tl
\tl_new:N	\g_homework_course_tl

\tl_gset:Nn	\g_homework_author_tl	{Your~name}
\tl_gset:Nn	\g_homework_title_tl	{Title}
\tl_gset:Nn	\g_homework_date_tl	{\today}
\tl_gset:Nn	\g_homework_course_tl	{Course}

\RenewDocumentCommand\author{ m }	{\tl_gset:Nn \g_homework_author_tl {#1}}
\RenewDocumentCommand\title{ m }	{\tl_gset:Nn \g_homework_title_tl {#1}}
\NewDocumentCommand\due{ m }		{\tl_gset:Nn \g_homework_date_tl {#1}}
\NewDocumentCommand\course{ m }		{\tl_gset:Nn \g_homework_course_tl {#1}}

% problemlabel may need to be redefined (for psets with different parts)
\tl_new:N	\g_homework_problemlabel_tl
\tl_gset:Nn 	\g_homework_problemlabel_tl {Problem}
\NewDocumentCommand\problemlabel{ m }	{\tl_gset:Nn \g_homework_problemlabel_tl {#1}}

%% Class Options 
% Load packages for algorithm/code typesetting
\bool_new:N		\g_homework_loadalg_bool
\bool_gset_false:N	\g_homework_loadalg_bool
\DeclareOption{code}{
	\bool_gset_true:N	\g_homework_loadalg_bool
}

% Load physics packages
\bool_new:N 		\g_homework_loadphys_bool
\bool_gset_false:N	\g_homework_loadphys_bool
\DeclareOption{physics}{
	\bool_gset_true:N	\g_homework_loadphys_bool
}

% Load chemistry package
\bool_new:N		\g_homework_loadchem_bool
\bool_gset_false:N	\g_homework_loadchem_bool
\DeclareOption{chemistry}{
	\bool_gset_true:N	\g_homework_loadchem_bool
}

% Load diagram packages
\bool_new:N		\g_homework_loaddiag_bool
\bool_gset_false:N	\g_homework_loaddiag_bool
\DeclareOption{diagram}{
	\bool_gset_true:N	\g_homework_loaddiag_bool
}

% Font size
\str_new:N	\g_homework_fontsize_str
\str_gset:Nn	\g_homework_fontsize_str {10pt}

\DeclareOption{11pt}{
	\str_gset:Nn	\g_homework_fontsize_str {11pt}
}
\DeclareOption{12pt}{
	\str_gset:Nn	\g_homework_fontsize_str {12pt}
}

% Pass all remaining options to class
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{\c__homework_class_parent_class_tl}
}
\ProcessOptions\relax

%% Load Article Class
\LoadClass[letterpaper, \g_homework_fontsize_str]{\c__homework_class_parent_class_tl}

%% Load Module Packages
% Formatting
\RequirePackage[top = 1.45in, bottom = 1.35in, inner = 1.15in, outer = 2in, marginparwidth=1.4in, marginparsep=0.25in]{geometry}
\RequirePackage{framed}
\RequirePackage{xcolor}
\definecolor{shadecolor}{rgb}{0.95,0.95,0.95}
\RequirePackage{enumitem}

% Math (will always be loaded)
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{thmtools}
\RequirePackage{mathtools}
\RequirePackage{bm}

% Define custom shortcuts
\NewDocumentCommand\e{}     {\mathrm{e}} % To conform to ISO 80000-2
\NewDocumentCommand\bbr{}   {\mathbb{R}}
\NewDocumentCommand\bbc{}   {\mathbb{C}}
\NewDocumentCommand\bbz{}   {\mathbb{Z}}
\NewDocumentCommand\bbq{}   {\mathbb{Q}}
\NewDocumentCommand\bbn{}   {\mathbb{N}}
\NewDocumentCommand\by{}    {\times}

% Physics
\bool_if:NT \g_homework_loadphys_bool{
	\RequirePackage{physics}
	\RequirePackage{siunitx}

	% Declare some non-SI-but-still-useful units
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

	% Custom comands
	\NewDocumentCommand\unit{ m }	{\bm{\hat{\mathbf{#1}}}}
}

% Code/Algorithm
\bool_if:NT \g_homework_loadalg_bool {
	\RequirePackage{minted}
	\usemintedstyle{tango}
	\RequirePackage{algorithm}
	\RequirePackage{algpseudocode}
}

% Chemistry
\bool_if:NT	\g_homework_loadchem_bool {
	\RequirePackage{mhchem}
}

% Diagrams
\bool_if:NT	\g_homework_loaddiag_bool {
	\RequirePackage{tikz}
	\RequirePackage[american, siunitx]{circuitikz}
}

%% Misc. Macros
\NewDocumentCommand\note{ m } {\colorbox{yellow}{#1}}
\NewDocumentCommand\final{ m } {\boxed{#1}}
\RenewDocumentCommand\qedsymbol{} {$\blacksquare$}

% Fonts (xelatex)
\ifxetex
	\RequirePackage[no-math]{fontspec}
\fi

% Parts environment
\NewDocumentEnvironment{parts}{ }
		               {\begin{enumerate}[label=\textup{(\alph*)},
		                                  labelwidth=4.5em,
		                                  labelsep=0.5em,
		                                  leftmargin=2\parindent,
		                                  resume]}
		               {\end{enumerate}}

% \part[]
\RenewDocumentCommand\part{ o }{\IfNoValueTF{#1}
                                            {\item}
                                            {\item\label{#1}}}

%% MARK: - Theorem-like environments
% QED Symbol
\RenewDocumentCommand\qedsymbol{}{$\blacksquare$}

% Solution (clone of proof)
\NewDocumentEnvironment{solution}{ o }
                       {\IfNoValueTF{#1}{\begin{proof}[Solution]}{\begin{proof}[#1]}}
                       {\end{proof}}

% Make shaded theorems have uniform padding
\NewDocumentCommand\headpadding{}{\leftskip=0.2cm\rightskip=0.2cm\vspace{0.4cm}}
\NewDocumentCommand\footpadding{}{\vspace{0.2cm}}
\NewDocumentCommand\theoremvert{}{6pt}

% Lemma style definition
\declaretheoremstyle[
	spaceabove=\theoremvert, spacebelow=\theoremvert,
	headfont=\normalfont\bfseries,
	bodyfont=\normalfont\itshape
]{lemma}

\declaretheorem[style=lemma]{lemma}
\declaretheorem[style=lemma]{theorem}
\declaretheorem[style=lemma]{corollary}
\declaretheorem[style=lemma]{conjecture}

% Definition style theorems
\declaretheoremstyle[
	spaceabove=\theoremvert, spacebelow=\theoremvert,
	headfont=\normalfont\bfseries,
	bodyfont=\normalfont
]{definition}

\declaretheorem[
	style=definition,
	postheadhook=\leftskip=1cm\rightskip=1cm
]{definition}
\declaretheorem[
	style=definition,
	postheadhook=\leftskip=1cm\rightskip=1cm,
	numbered=no
]{notation}
\declaretheorem[
	style=definition,
	postheadhook=\leftskip=1cm\rightskip=1cm,
	title={Abuse~of~notation},
	numbered=no
]{abuse}
\declaretheorem[
	shaded={bgcolor={rgb}{0.95,0.95,0.95}},
	style=definition,
	postheadhook=\headpadding,
	postfoothook=\footpadding
]{problem}
\declaretheorem[
	shaded={bgcolor={rgb}{0.95,0.95,0.95}},
	style=definition,
	postheadhook=\headpadding,
	postfoothook=\footpadding,
	sibling=problem
]{exercise}

% Break style theorems
\declaretheoremstyle[
	spaceabove=\theoremvert, spacebelow=\theoremvert,
	headfont=\normalfont\bfseries,
	bodyfont=\normalfont,
	postheadspace=\newline
]{break}

\declaretheorem[
	shaded={bgcolor={rgb}{1,0.93,0.8}},
	style=break,
	postheadhook=\headpadding,
	postfoothook=\footpadding
]{example}

%% Languages
% Arabic
\ifxetex
	\RequirePackage{bidi}
	\newfontfamily\arabicbody[Script=Arabic]{Scheherazade}
	\NewDocumentCommand\arab{}{\RTL\arabicbody}
	\NewDocumentCommand\arabtext{ m }{{\RTL\arabicbody #1}}
\fi

%% @BeginDocument
\AtBeginDocument{
	\begin{center}
	{\hfill \g_homework_author_tl} \\
	{\hfill \g_homework_course_tl} \\
	{\hfill \g_homework_date_tl} \\
	\vspace{0.5cm}
	{\textsc{\large\g_homework_title_tl}} \\
	\end{center}
}
