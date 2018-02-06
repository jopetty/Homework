%% homework.cls

\RequirePackage{expl3, xparse, ifxetex}

\ExplSyntaxOn

%% Define class metadata
\tl_const:Nn \c__homework_class_name_tl		{homework}
\tl_const:Nn \c__homework_class_version_tl	{1.2.0}
\tl_const:Nn \c__homework_class_date_tl		{2017/09/16}
\tl_const:Nn \c__homework_class_description_tl	{A~LaTeX3~class~for~typesetting~homework~assignments}
\tl_const:Nn \c__homework_class_parent_class_tl	{article}

\ProvidesExplClass{\c__homework_class_name_tl}			% Class name
		  {\c__homework_class_date_tl}			% date
		  {\c__homework_class_version_tl}		% version
		  {\c__homework_class_description_tl}		% description

%% Define class commands
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
\str_gset:Nn	\g_homework_fontsize_str {11pt}

\DeclareOption{10pt}{
	\str_gset:Nn	\g_homework_fontsize_str {10pt}
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
\RequirePackage{framed}
\RequirePackage{xcolor}
\definecolor{shadecolor}{rgb}{0.95,0.95,0.95}
\RequirePackage{enumitem}

% Math (will always be loaded)
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{bm}

% Define custom shortcuts
\NewDocumentCommand\e{}		{\mathrm{e}} % To conform to ISO 80000-2
\NewDocumentCommand\bbr{}	{\mathbb{R}}
\NewDocumentCommand\bbc{}	{\mathbb{C}}
\NewDocumentCommand\bbz{}	{\mathbb{Z}}
\NewDocumentCommand\bbq{}	{\mathbb{Q}}

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
\NewDocumentCommand\note{ m }	{\colorbox{yellow}{#1}}

% Fonts (xelatex)
\ifxetex
	\RequirePackage{fontspec}
\fi

%% Environments
% Problem
\newcounter{problemCounter}
\theoremstyle{definition}
\newtheorem{theoremproblem}[problemCounter]{\g_homework_problemlabel_tl}
% \numberwithin{equation}{theoremproblem}
\NewDocumentEnvironment{problem}
		       {}
		       {\begin{shaded*}\begin{theoremproblem}}
		       {\end{theoremproblem}\end{shaded*}}

\NewDocumentCommand\problemnumber{ m }	{\setcounter{problemCounter}{#1 - 1}}
\NewDocumentEnvironment{solution}
		       {}
		       {\noindent}
		       {}

\NewDocumentCommand\final{ m } {\boxed{#1}}

\NewDocumentEnvironment{parts}
		       {}
		       {\begin{enumerate}[label=\textup{(\alph*)}, labelwidth=4.5em, labelsep=0.5em, resume]}
		       {\end{enumerate}}

\def\part{\@ifnextchar[{\@with}{\@without}}
\def\@with[#1]{\item\label{#1}}
\def\@without{\item}

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
