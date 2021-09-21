%Used while compiling and creating log information
\def\fileversion{1.0}
\def\filedate{2020/06/29}

%%%%%Starting point of class
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{RVexam}[\filedate\space Version \fileversion\space by P Narashimaraja]

\RequirePackage{ifthen}

%Answer Display
\newif\ifprintanswers
\printanswersfalse
\DeclareOption{answers}{\printanswerstrue}
\DeclareOption{noanswers}{\printanswersfalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifcancelspace
\cancelspacefalse
\DeclareOption{cancelspace}{\cancelspacetrue}
\DeclareOption{nocancelspace}{\cancelspacefalse}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Points for marks
\newif\if@addpoints
\newif\if@printtotalpoints
\def\addpoints{\global\@addpointstrue\global\@printtotalpointstrue}
\def\noaddpoints{\global\@addpointsfalse}
\@addpointsfalse
\@printtotalpointsfalse
\DeclareOption{addpoints}{\addpoints}

%%%% Passing all the previous Options that the RVexam class revices to article class
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%                         *****************
%                         ** PAGE LAYOUT **
%                         *****************

% We set the parameters in terms of \paperwidth and \paperheight
% so that the options like a4paper, a5paper, etc will all work:

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2in}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}

\setlength{\headheight}{15pt}
\setlength{\headsep}{15pt}
\setlength{\topmargin}{0in}
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\setlength{\footskip}{29pt}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2.2in}

\setlength{\marginparwidth}{.5in}
\setlength{\marginparsep}{5pt}
