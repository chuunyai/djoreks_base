%% ---------------------------------------------------------------------------
%% sfureport.cls — отчёты СФУ по СТУ 7.5–07–2021
%% «Общие требования к построению, изложению и оформлению документов
%%  учебной деятельности» (отчёты по лабораторным / практическим работам,
%%  практикам, рефераты, контрольные, эссе, КР).
%%
%% Компилировать XeLaTeX или LuaLaTeX (НЕ pdfLaTeX).
%%
%% Опции класса:
%%   onehalf   (по умолчанию) полуторный межстрочный интервал
%%   single    одинарный межстрочный интервал
%%   newpage   каждый раздел (\section) начинать с новой страницы
%%   bysection нумерация рисунков/таблиц/формул в пределах раздела (2.1, 2.2…)
%% ---------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sfureport}[2026/11/16 Отчёты СФУ по СТУ 7.5-07-2021]

\newif\ifstu@single   \stu@singlefalse
\newif\ifstu@newpage  \stu@newpagefalse
\newif\ifstu@bysec    \stu@bysecfalse
\DeclareOption{single}{\stu@singletrue}
\DeclareOption{onehalf}{\stu@singlefalse}
\DeclareOption{newpage}{\stu@newpagetrue}
\DeclareOption{bysection}{\stu@bysectrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

% п. 7.1.1: A4, Times New Roman 14 пт
\LoadClass[14pt,a4paper]{extarticle}

\RequirePackage{iftex}
\ifXeTeX\else\ifLuaTeX\else
  \ClassError{sfureport}{Нужен XeLaTeX или LuaLaTeX}{Смените компилятор (в Overleaf: Menu -> Compiler -> XeLaTeX).}
\fi\fi

\RequirePackage{etoolbox}

%% ---------------------------------------------------------------- шрифты --
\RequirePackage[fleqn]{amsmath}
\RequirePackage{unicode-math}
\defaultfontfeatures{Ligatures=TeX}
% Liberation Serif — метрический клон Times New Roman с кириллицей (есть в Overleaf и Linux).
% В Overleaf «Times New Roman» есть, но без кириллицы, поэтому он не первый.
\IfFontExistsTF{Liberation Serif}%
  {\setmainfont{Liberation Serif}}%
  {\IfFontExistsTF{Times New Roman}%
    {\setmainfont{Times New Roman}}%
    {\setmainfont{TeX Gyre Termes}}}
\IfFontExistsTF{Liberation Mono}%
  {\setmonofont{Liberation Mono}}%
  {\IfFontExistsTF{Courier New}%
    {\setmonofont{Courier New}}%
    {\setmonofont{TeX Gyre Cursor}}}
\IfFontExistsTF{TeX Gyre Termes Math}{\setmathfont{TeX Gyre Termes Math}}{}

%% ------------------------------------------------------------------ язык --
\RequirePackage{polyglossia}
\setmainlanguage{russian}
\setotherlanguage{english}
\gappto\captionsrussian{%
  \renewcommand{\figurename}{Рисунок}%
  \renewcommand{\tablename}{Таблица}%
  \renewcommand{\contentsname}{Содержание}%
  \renewcommand{\refname}{Список использованных источников}}

%% -------------------------------------------------- поля, интервал, абзац --
% п. 7.1.2: левое 30, правое 10, верхнее и нижнее 20 мм
\RequirePackage[a4paper,left=30mm,right=10mm,top=20mm,bottom=20mm,footskip=10mm]{geometry}

\newlength{\stulineskip}   % «одна строка» для отбивок вокруг заголовков и формул
\ifstu@single
  \setlength{\stulineskip}{16pt}
  \renewcommand{\baselinestretch}{1}
\else
  % 17 пт (базовая строка 14 пт) * 1.42 ≈ 24 пт — как «1,5 строки» в Word
  \setlength{\stulineskip}{24pt}
  \renewcommand{\baselinestretch}{1.42}
\fi
\newcommand{\stusingle}{\renewcommand{\baselinestretch}{1}\selectfont}

\setlength{\parindent}{1.25cm}   % абзацный отступ 12,5 мм
\setlength{\parskip}{0pt}
\RequirePackage{indentfirst}
\raggedbottom
\emergencystretch=2em
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}

%% ------------------------------------------------------- нумерация страниц --
% п. 7.2: внизу по центру, без номера на титульном листе, сквозная нумерация
\RequirePackage{fancyhdr}
\fancypagestyle{stu}{%
  \fancyhf{}%
  \fancyfoot[C]{\normalfont\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\normalfont\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}}
\pagestyle{stu}

%% ----------------------------------------------------------------- заголовки --
% п. 7.4, 7.5: арабские цифры, с абзацного отступа, прописная первая буква,
% полужирный, без точки, без переносов, отбивка в одну строку
\RequirePackage{titlesec}
\newcommand{\stu@headfmt}{\normalfont\bfseries\hyphenpenalty=10000\exhyphenpenalty=10000\rightskip=0pt plus 1fil\relax}
\titleformat{\section}[block]{\stu@headfmt}{\thesection}{0.5em}{}
\titleformat{\subsection}[block]{\stu@headfmt}{\thesubsection}{0.5em}{}
\titleformat{\subsubsection}[block]{\stu@headfmt}{\thesubsubsection}{0.5em}{}
\titlespacing{\section}{1.25cm}{\stulineskip}{\stulineskip}
\titlespacing{\subsection}{1.25cm}{\stulineskip}{\stulineskip}
\titlespacing{\subsubsection}{1.25cm}{\stulineskip}{\stulineskip}

\ifstu@newpage
  \let\stu@oldsection\section
  \renewcommand{\section}{\clearpage\stu@oldsection}
\fi

% п. 6.1: структурные элементы — по центру, ПРОПИСНЫМИ, полужирным, без номера,
% с новой страницы. В содержании — «Введение», «Заключение» и т.д.
\newcommand{\structsection}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{section}{#1}%
  {\centering\normalfont\bfseries\MakeUppercase{#1}\par}%
  \nopagebreak\vspace{\stulineskip}\nopagebreak}

%% ---------------------------------------------------------------- содержание --
% п. 6.4: разделы с начала строки, подразделы со сдвигом на 2 знака, отточие
\RequirePackage{tocloft}
\renewcommand{\cftdotsep}{2.5}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsubsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\normalfont}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftbeforesubsubsecskip}{0pt}
\setlength{\cftsecindent}{0pt}
\setlength{\cftsecnumwidth}{1.2em}
\setlength{\cftsubsecindent}{1em}
\setlength{\cftsubsecnumwidth}{2.4em}
\setlength{\cftsubsubsecindent}{2em}
\setlength{\cftsubsubsecnumwidth}{3.4em}

\newcommand{\stutoc}{%
  \clearpage
  {\centering\normalfont\bfseries\MakeUppercase{Содержание}\par}%
  \vspace{\stulineskip}%
  {\stusingle\@starttoc{toc}}}

%% ---------------------------------------------------------- приложения (7.11) --
\newcounter{stuappendix}
% буквы без Ё, З, Й, О, Ч, Ь, Ы, Ъ
\newcommand{\stuappletter}[1]{\ifcase#1\or А\or Б\or В\or Г\or Д\or Е\or Ж\or И\or К\or Л\or М\or Н\or П\or Р\or С\or Т\or У\or Ф\or Х\or Ц\or Ш\or Щ\or Э\or Ю\or Я\else ?\fi}
\newcommand{\stuappendix}[2][]{%
  \clearpage
  \refstepcounter{stuappendix}%
  \setcounter{figure}{0}\setcounter{table}{0}\setcounter{equation}{0}\setcounter{section}{0}%
  \renewcommand{\thefigure}{\stuappletter{\value{stuappendix}}.\arabic{figure}}%
  \renewcommand{\thetable}{\stuappletter{\value{stuappendix}}.\arabic{table}}%
  \renewcommand{\theequation}{\stuappletter{\value{stuappendix}}.\arabic{equation}}%
  \renewcommand{\thesection}{\stuappletter{\value{stuappendix}}.\arabic{section}}%
  \phantomsection
  \addcontentsline{toc}{section}{Приложение \stuappletter{\value{stuappendix}}\ #2}%
  {\centering\normalfont\bfseries ПРИЛОЖЕНИЕ \stuappletter{\value{stuappendix}}\par
   \if\relax\detokenize{#1}\relax\else{\normalfont\mdseries(#1)}\par\fi
   #2\par}%
  \nopagebreak\vspace{\stulineskip}\nopagebreak}

%% ------------------------------------------------ перечисления (п. 7.4.3) --
\RequirePackage{enumitem}
% буквы по алфавиту без ё, з, й, о, ч, ь, ы, ъ
\newcommand{\@stuasbuk}[1]{\ifcase#1\or а\or б\or в\or г\or д\or е\or ж\or и\or к\or л\or м\or н\or п\or р\or с\or т\or у\or ф\or х\or ц\or ш\or щ\or э\or ю\or я\else ?\fi}
\newcommand{\stuasbuk}[1]{\@stuasbuk{\csname c@#1\endcsname}}
\AddEnumerateCounter{\stuasbuk}{\@stuasbuk}{ю}
\setlist{itemsep=0pt,parsep=0pt,topsep=0pt,partopsep=0pt,leftmargin=0pt,labelindent=0pt,align=left}
\setlist[itemize,1]{label={-},labelwidth=0.6em,labelsep=0.4em,itemindent=\dimexpr1.25cm+1em\relax}
\setlist[enumerate,1]{label=\stuasbuk*),labelwidth=1em,labelsep=0.4em,itemindent=\dimexpr1.25cm+1.4em\relax}
\setlist[enumerate,2]{label=\arabic*),labelwidth=1em,labelsep=0.4em,itemindent=\dimexpr1.25cm+2.4em\relax}
\setlist[itemize,2]{label={-},labelwidth=0.6em,labelsep=0.4em,itemindent=\dimexpr1.25cm+2em\relax}

%% -------------------------------------------- формулы, рисунки, таблицы --
\setlength{\mathindent}{1.25cm}   % п. 7.6.1: формулы с абзацного отступа
\setlength{\abovedisplayskip}{\stulineskip}
\setlength{\belowdisplayskip}{\stulineskip}
\setlength{\abovedisplayshortskip}{\stulineskip}
\setlength{\belowdisplayshortskip}{\stulineskip}

% пояснение символов: «где» без двоеточия и абзацного отступа (п. 7.6.5)
\newlength{\stu@gdewidth}
\newenvironment{gde}{%
  \settowidth{\stu@gdewidth}{где\ }%
  \list{}{\setlength\leftmargin{\stu@gdewidth}\setlength\itemindent{0pt}%
    \setlength\labelwidth{0pt}\setlength\labelsep{0pt}\setlength\parsep{0pt}%
    \setlength\itemsep{0pt}\setlength\topsep{0pt}\setlength\partopsep{0pt}%
    \setlength\listparindent{0pt}}%
  \item[]\hspace*{-\stu@gdewidth}где\ \ignorespaces}%
 {\endlist}
\newcommand{\gdeitem}{\item[]}

\RequirePackage{graphicx}
\RequirePackage{float}
\floatplacement{figure}{H}
\floatplacement{table}{H}
\setlength{\intextsep}{\stulineskip}
\setlength{\floatsep}{\stulineskip}
\setlength{\textfloatsep}{\stulineskip}

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{stu}{\space\textendash\space}
\captionsetup{font=normalsize,labelfont=normalfont,textfont=normalfont,labelsep=stu}
% рисунок: подпись снизу по центру; таблица: сверху слева без отступа
\captionsetup[figure]{position=bottom,justification=centering,singlelinecheck=false,skip=6pt}
\captionsetup[table]{position=top,justification=raggedright,singlelinecheck=false,skip=3pt}

\RequirePackage{array,longtable,multirow,tabularx}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\centering\arraybackslash}X}
\newcolumntype{Z}{>{\raggedright\arraybackslash}X}
\renewcommand{\arraystretch}{1.15}
% в таблицах шрифт 10–12 пт (п. 7.7.13), одинарный интервал
\AtBeginEnvironment{table}{\small\stusingle}
\AtBeginEnvironment{longtable}{\small\stusingle}
\g@addto@macro\@floatboxreset{\centering}
% единица измерения справа над таблицей, 12 пт (п. 7.7.8)
\newcommand{\tableunit}[1]{\par\nopagebreak\hfill{\small #1}\par\nopagebreak}

%% ------------------------------------------------------------ листинги кода --
\RequirePackage{listings}
\lstset{basicstyle=\ttfamily\small,breaklines=true,columns=fullflexible,keepspaces=true,
  tabsize=4,showstringspaces=false,captionpos=t,frame=single,numbers=left,
  numberstyle=\tiny,xleftmargin=1.5em,framexleftmargin=1.5em,aboveskip=\stulineskip,belowskip=\stulineskip}
\renewcommand{\lstlistingname}{Листинг}
\captionsetup[lstlisting]{position=top,justification=raggedright,singlelinecheck=false,skip=3pt}

%% ------------------------------------------------ список источников (7.10) --
% нумерация арабскими цифрами, с абзацного отступа, сквозная
\renewcommand\@biblabel[1]{#1.}
\renewenvironment{thebibliography}[1]
  {\structsection{Список использованных источников}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \setlength\leftmargin{0pt}\setlength\labelsep{0.5em}%
         \setlength\itemindent{\dimexpr\parindent+\labelwidth+\labelsep\relax}%
         \setlength\itemsep{0pt}\setlength\parsep{0pt}\setlength\topsep{0pt}%
         \setlength\partopsep{0pt}\setlength\listparindent{0pt}%
         \usecounter{enumiv}\let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\clubpenalty4000\@clubpenalty\clubpenalty\widowpenalty4000\sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}\endlist}

%% ----------------------------------------------- нумерация в пределах раздела --
\ifstu@bysec
  \RequirePackage{chngcntr}
  \counterwithin{figure}{section}
  \counterwithin{table}{section}
  \counterwithin{equation}{section}
\fi

%% -------------------------------------------------------------- титульный лист --
% Форма — приложения М / Н СТУ 7.5–07–2021 (отчёт по лабораторной/практической
% работе, реферат, контрольная, эссе и т.п.)
\def\stu@institute{Название института}
\def\stu@department{Название кафедры}
\def\stu@worktype{Отчёт по лабораторной работе}
\def\stu@discipline{}
\def\stu@teacher{Фамилия И. О.}
\def\stu@group{Номер группы, номер зачётной книжки}
\def\stu@city{Красноярск}
\newcommand{\institute}[1]{\def\stu@institute{#1}}
\newcommand{\department}[1]{\def\stu@department{#1}}
\newcommand{\worktype}[1]{\def\stu@worktype{#1}}
\newcommand{\discipline}[1]{\def\stu@discipline{#1}}
\newcommand{\teacher}[1]{\def\stu@teacher{#1}}
\newcommand{\studentgroup}[1]{\def\stu@group{#1}}
\newcommand{\city}[1]{\def\stu@city{#1}}
\date{\number\year}

\newcommand{\stufield}[2]{%
  \par\vspace{0.5\baselineskip}\noindent
  \begin{minipage}{\textwidth}\centering
    #1\\[-0.2ex]\rule{\textwidth}{0.4pt}\\[-0.7ex]
    {\footnotesize #2}%
  \end{minipage}\par}

\renewcommand{\maketitle}{%
  \begin{titlepage}%
    \stusingle
    \centering
    Министерство науки и высшего образования РФ\\
    Федеральное государственное автономное\\
    образовательное учреждение высшего образования\\
    «СИБИРСКИЙ ФЕДЕРАЛЬНЫЙ УНИВЕРСИТЕТ»\par
    \vspace{2\baselineskip}
    \stufield{\stu@institute}{институт}
    \stufield{\stu@department}{кафедра}
    \vfill
    {\MakeUppercase{\stu@worktype}}\par
    \ifx\stu@discipline\@empty\else
      \vspace{\baselineskip}
      \stufield{по \stu@discipline}{наименование дисциплины}
    \fi
    \vspace{\baselineskip}
    \stufield{\@title}{тема}
    \vfill
    \renewcommand{\arraystretch}{1.3}%
    \noindent\begin{tabular}{@{}l@{\hspace{0.6em}}c@{\hspace{0.6em}}c@{\hspace{0.6em}}c@{}}
      Преподаватель & & \underline{\makebox[3cm]{}} & \underline{\makebox[4.2cm][c]{\stu@teacher}}\\[-0.4ex]
        & & {\footnotesize подпись, дата} & {\footnotesize инициалы, фамилия}\\[1.5ex]
      Студент & \underline{\makebox[3.6cm][c]{\stu@group}} & \underline{\makebox[3cm]{}} & \underline{\makebox[4.2cm][c]{\@author}}\\[-0.4ex]
        & {\footnotesize номер группы, зачётной книжки} & {\footnotesize подпись, дата} & {\footnotesize инициалы, фамилия}
    \end{tabular}\par
    \vfill
    \stu@city\ \@date\par
  \end{titlepage}%
  \setcounter{page}{2}}  % титульный лист входит в нумерацию (п. 7.2.2)

%% ------------------------------------------------------------------ гиперссылки --
\RequirePackage[unicode,hidelinks]{hyperref}
\AtBeginDocument{\hypersetup{pdftitle={\@title},pdfauthor={\@author}}}
\endinput
