%Used while compiling and creating log information
\def\fileversion{1.0}
\def\filedate{2021/10/15}

%%%%%Starting point of class
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{rvexam}[\filedate\space Version \fileversion\space by P Narashimaraja]

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%--------------------------------------------------------------------

%                          ****************
%                          ** EXTRAWIDTH **
%                          ****************

\newlength\@extrawidth

\newlength\@rightmargin
\setlength{\@rightmargin}{1in}

% We put the argument of \extrawidth into a length so that it will
% work correctly even if it's negative:

\def\extrawidth#1{%
  \@extrawidth=#1
  \advance \textwidth by \@extrawidth
  \divide\@extrawidth by 2
  \advance\oddsidemargin by -\@extrawidth
  \advance\evensidemargin by -\@extrawidth
  \advance\@rightmargin by -\@extrawidth
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%             Making room for large headers and footers

\newlength\@extrahead
\newlength\@extrafoot
\setlength{\@extrahead}{0in}
\setlength{\@extrafoot}{0in}

\newlength\run@exhd
\newlength\fp@exhd
\newlength\run@exft
\newlength\fp@exft
\newlength\covrun@exhd
\newlength\covfp@exhd
\newlength\covrun@exft
\newlength\covfp@exft

\setlength{\run@exhd}{0in}
\setlength{\fp@exhd}{0in}
\setlength{\run@exft}{0in}
\setlength{\fp@exft}{0in}
\setlength{\covrun@exhd}{0in}
\setlength{\covfp@exhd}{0in}
\setlength{\covrun@exft}{0in}
\setlength{\covfp@exft}{0in}

\newcommand*\adj@hdht@ftht{%
  \if@coverpages
    \ifnum\value{page}=1\relax
      \@setheadheight{\covfp@exhd}%
      \@setfootheight{\covfp@exft}%
    \else
      \@setheadheight{\covrun@exhd}%
      \@setfootheight{\covrun@exft}%
    \fi
  \else
    \ifnum\value{page}=1\relax
      \@setheadheight{\fp@exhd}%
      \@setfootheight{\fp@exft}%
    \else
      \@setheadheight{\run@exhd}%
      \@setfootheight{\run@exft}%
    \fi
  \fi
}

\newcommand*\extraheadheight{%
  \@ifnextchar[{\@xtrahd}{\@ytrahd}%
}

\def\@xtrahd[#1]#2{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#2}%
  \adj@hdht@ftht
}

\def\@ytrahd#1{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\extrafootheight{%
  \@ifnextchar[{\@xtraft}{\@ytraft}%
}

\def\@xtraft[#1]#2{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#2}%
  \adj@hdht@ftht
}

\def\@ytraft#1{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextraheadheight{%
  \@ifnextchar[{\cov@xtrahd}{\cov@ytrahd}%
}

\def\cov@xtrahd[#1]#2{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytrahd#1{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextrafootheight{%
  \@ifnextchar[{\cov@xtraft}{\cov@ytraft}%
}

\def\cov@xtraft[#1]#2{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytraft#1{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#1}%
  \adj@hdht@ftht
}

%--------------------------------------------------------------

\def\@appendoutput#1{%
  \output=\expandafter{\the\output #1}%
}

\@appendoutput{\adj@hdht@ftht}

%--------------------------------------------------------------------
%                 \@setheadheight and \@setfootheight:

\def\@setheadheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change in \@extrahead:
    \global\advance\topmargin by -\@extrahead
    \global\advance\textheight by \@extrahead
    \global\advance\@colroom by \@extrahead
    \global\advance\@colht by \@extrahead
    \global\advance\vsize by \@extrahead
%	
    % Set the new value in \@extrahead:
    \def\@temp{#1}
    \def\@spaces{ }
	%\@empty is a primitive in latex
    \ifx\@temp\@empty
      \global\@extrahead=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrahead=0in
      \else
        \global\@extrahead=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\topmargin by \@extrahead
    \global\advance\textheight by -\@extrahead
    \global\advance\@colroom by -\@extrahead
    \global\advance\@colht by -\@extrahead
    \global\advance\vsize by -\@extrahead
%	
  \endgroup
}% @setheadheight

\def\@setfootheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\textheight by \@extrafoot
    \global\advance\@colroom by \@extrafoot
    \global\advance\@colht by \@extrafoot
    \global\advance\vsize by \@extrafoot
% 
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrafoot=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrafoot=0in
      \else
        \global\@extrafoot=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\textheight by -\@extrafoot
    \global\advance\@colroom by -\@extrafoot
    \global\advance\@colht by -\@extrafoot
    \global\advance\vsize by -\@extrafoot
%
  \endgroup
}% @setfootheight

%---------------------------------------------------------------------
%
%                      *************************
%                      ** HEADERS AND FOOTERS **
%                      *************************
% 
% The pagestyles available are head, foot, headandfoot, and empty.
% Eg.,\pagestyle{head} prints the head, and gives an empty foot.

%                            Pagestyles:

\newcommand*\ps@head{%
  \@dohead
  \@nofoot
}

\newcommand*\ps@headandfoot{%
  \@dohead
  \@dofoot
}

\newcommand*\ps@foot{%
  \@nohead
  \@dofoot
}

% \ps@empty is already defined by article.cls, so we'll
% say \def instead of \newcommand*:
\def\ps@empty{%
  \@nohead
  \@nofoot
}

%------------------------------------ Coverpages ------------------
\newif\if@coverpages
\@coverpagesfalse

\newcounter{num@coverpages}
% We'll set this to zero in case there is no coverpages environment:
\setcounter{num@coverpages}{0}

\newenvironment{coverpages}{%
    \ifnum \value{numquestions}>0\relax
      \ClassError{RVexam}{%
        Coverpages cannot be used after questions have begun.\MessageBreak
      }{%
        All question, part, subpart, and subsubpart environments
        \MessageBreak
        must begin after the cover pages are complete.\MessageBreak
      }%
    \fi
    \@coverpagestrue
    \pagenumbering{roman}%
    \adj@hdht@ftht
  }{%
    \clearpage
    \setcounter{num@coverpages}{\value{page}}%
    \addtocounter{num@coverpages}{-1}%
    \pagenumbering{arabic}%
    \@coverpagesfalse
    \adj@hdht@ftht
}

\newcommand*\cover@question@error{%
  \ClassError{RVexam}{%
    No questions are allowed in the cover pages.\MessageBreak
  }{%
    All question, part, subpart, and subsubpart environments
    \MessageBreak
    must begin after the cover pages are complete.\MessageBreak
  }%
}
%------------------------------------ EOF Coverpages ------------------
\newcommand*\@dohead{%
  \def\@oddhead{%
    \if@coverpages
      \ifnum\value{page}=1\relax
        \cov@fullhead
      \else
        \covrun@fullhead
      \fi
    \else
      \ifnum\value{page}=1\relax
        \@fullhead
      \else
        \run@fullhead
      \fi
    \fi
  }% @oddhead
  \let\@evenhead=\@oddhead
}

\newcommand*\@dofoot{%
  \def\@oddfoot{%
    \if@coverpages
      \ifnum\value{page}=1\relax
        \cov@fullfoot
      \else
        \covrun@fullfoot
      \fi
    \else
      \ifnum\value{page}=1\relax
        \@fullfoot
      \else
        \run@fullfoot
      \fi
    \fi
  }% @oddfoot
  \let\@evenfoot=\@oddfoot
}

\newcommand*\@nohead{%
  \def\@oddhead{}%
  \let\@evenhead=\@oddhead
}

\newcommand*\@nofoot{%
  \def\@oddfoot{}%
  \let\@evenfoot=\@oddfoot
}

%--------------------------------------------------------------------
%       \@fullhead, \run@fullhead, \@fullfoot, and \run@fullfoot:

% The bottom code splits the header into 3 parts
\newcommand*\@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
    }% hbox
    \if@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\run@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\run@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\run@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\run@rhead\strut}}%
    }% hbox
    \ifrun@headrule
      \hrule
    \else
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\@fullfoot{%
  \vbox to 0pt{%
    \if@footrule
      \hrule
    \else
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

\newcommand*\run@fullfoot{%
  \vbox to 0pt{%
    \ifrun@footrule
      \hrule
    \else
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\run@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\run@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\run@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%       \cov@fullhead, \covrun@fullhead, \cov@fullfoot, and
%       \covrun@fullfoot: 

\newcommand*\cov@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\cov@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\cov@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\cov@rhead\strut}}%
    }% hbox
    \ifcov@headrule
      \hrule
    \else
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\covrun@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\covrun@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\covrun@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\covrun@rhead\strut}}%
    }% hbox
    \ifcovrun@headrule
      \hrule
    \else
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\cov@fullfoot{%
  \vbox to 0pt{%
    \ifcov@footrule
      \hrule
    \else
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\cov@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\cov@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\cov@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

\newcommand*\covrun@fullfoot{%
  \vbox to 0pt{%
    \ifcovrun@footrule
      \hrule
    \else
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\covrun@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\covrun@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\covrun@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%            ********************************************
%            ** COMMANDS TO DEFINE HEADERS AND FOOTERS **
%            ********************************************
%
% \lhead[#1]{#2} sets the first page left head to #1, and the
%   running left head to #2
% 
% \lhead{#1} sets both the first page left head and the running
%   left head to #1
% 
% \chead, \rhead, \lfoot, \cfoot, and \rfoot work similarly.
% 
% Alternative commands are:
% \firstpageheader{LEFT}{CENTER}{RIGHT}
% \runningheader{LEFT}{CENTER}{RIGHT}
% or
% \header{LEFT}{CENTER}{RIGHT}
% 
% Alternative commands are:
% \firstpagefooter{LEFT}{CENTER}{RIGHT}
% \runningfoother{LEFT}{CENTER}{RIGHT}
% or
% \footer{LEFT}{CENTER}{RIGHT}

\def\firstpageheader#1#2#3{%
  \def\@lhead{#1}%
  \def\@chead{#2}%
  \def\@rhead{#3}%
}

\def\runningheader#1#2#3{%
  \def\run@lhead{#1}%
  \def\run@chead{#2}%
  \def\run@rhead{#3}%
}

\def\header#1#2#3{%
  \firstpageheader{#1}{#2}{#3}%
  \runningheader{#1}{#2}{#3}%
}

\def\firstpagefooter#1#2#3{%
  \def\@lfoot{#1}%
  \def\@cfoot{#2}%
  \def\@rfoot{#3}%
}

\def\runningfooter#1#2#3{%
  \def\run@lfoot{#1}%
  \def\run@cfoot{#2}%
  \def\run@rfoot{#3}%
}

\def\footer#1#2#3{%
  \firstpagefooter{#1}{#2}{#3}%
  \runningfooter{#1}{#2}{#3}%
}

\def\lhead{\@ifnextchar[{\@xlhead}{\@ylhead}}
\def\@xlhead[#1]#2{\def\@lhead{#1}\def\run@lhead{#2}}
\def\@ylhead#1{\def\run@lhead{#1}\def\@lhead{#1}}

\def\chead{\@ifnextchar[{\@xchead}{\@ychead}}
\def\@xchead[#1]#2{\def\@chead{#1}\def\run@chead{#2}}
\def\@ychead#1{\def\run@chead{#1}\def\@chead{#1}}

\def\rhead{\@ifnextchar[{\@xrhead}{\@yrhead}}
\def\@xrhead[#1]#2{\def\@rhead{#1}\def\run@rhead{#2}}
\def\@yrhead#1{\def\run@rhead{#1}\def\@rhead{#1}}

\def\lfoot{\@ifnextchar[{\@xlfoot}{\@ylfoot}}
\def\@xlfoot[#1]#2{\def\@lfoot{#1}\def\run@lfoot{#2}}
\def\@ylfoot#1{\def\run@lfoot{#1}\def\@lfoot{#1}}

\def\cfoot{\@ifnextchar[{\@xcfoot}{\@ycfoot}}
\def\@xcfoot[#1]#2{\def\@cfoot{#1}\def\run@cfoot{#2}}
\def\@ycfoot#1{\def\run@cfoot{#1}\def\@cfoot{#1}}

\def\rfoot{\@ifnextchar[{\@xrfoot}{\@yrfoot}}
\def\@xrfoot[#1]#2{\def\@rfoot{#1}\def\run@rfoot{#2}}
\def\@yrfoot#1{\def\run@rfoot{#1}\def\@rfoot{#1}}


%                    Initialize head and foot:

\pagestyle{headandfoot}

\lhead{}
\chead{}
\rhead{}
\lfoot{}
\cfoot[]{Page \thepage}
\rfoot{}

%--------------------------------------------------------------------
%                    Coverpage headers and footers
%
% \coverlhead[#1]{#2} sets the first cover page left head to #1, and the
%   running cover left head to #2
% 
% \coverlhead{#1} sets both the first cover page left head and the running
%   cover left head to #1
% 
% \coverchead, \coverrhead, \coverlfoot, \covercfoot, and \coverrfoot
% work similarly.
% 
% Alternative commands are:
% \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
% \coverrunningheader{LEFT}{CENTER}{RIGHT}
% or
% \coverheader{LEFT}{CENTER}{RIGHT}
% 
% Alternative commands are:
% \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
% \coverrunningfoother{LEFT}{CENTER}{RIGHT}
% or
% \coverfooter{LEFT}{CENTER}{RIGHT}

\def\coverfirstpageheader#1#2#3{%
  \def\cov@lhead{#1}%
  \def\cov@chead{#2}%
  \def\cov@rhead{#3}%
}

\def\coverrunningheader#1#2#3{%
  \def\covrun@lhead{#1}%
  \def\covrun@chead{#2}%
  \def\covrun@rhead{#3}%
}

\def\coverheader#1#2#3{%
  \coverfirstpageheader{#1}{#2}{#3}%
  \coverrunningheader{#1}{#2}{#3}%
}

\def\coverfirstpagefooter#1#2#3{%
  \def\cov@lfoot{#1}%
  \def\cov@cfoot{#2}%
  \def\cov@rfoot{#3}%
}

\def\coverrunningfooter#1#2#3{%
  \def\covrun@lfoot{#1}%
  \def\covrun@cfoot{#2}%
  \def\covrun@rfoot{#3}%
}

\def\coverfooter#1#2#3{%
  \coverfirstpagefooter{#1}{#2}{#3}%
  \coverrunningfooter{#1}{#2}{#3}%
}

\def\coverlhead{\@ifnextchar[{\cov@xlhead}{\cov@ylhead}}
\def\cov@xlhead[#1]#2{\def\cov@lhead{#1}\def\covrun@lhead{#2}}
\def\cov@ylhead#1{\def\covrun@lhead{#1}\def\cov@lhead{#1}}

\def\coverchead{\@ifnextchar[{\cov@xchead}{\cov@ychead}}
\def\cov@xchead[#1]#2{\def\cov@chead{#1}\def\covrun@chead{#2}}
\def\cov@ychead#1{\def\covrun@chead{#1}\def\cov@chead{#1}}

\def\coverrhead{\@ifnextchar[{\cov@xrhead}{\cov@yrhead}}
\def\cov@xrhead[#1]#2{\def\cov@rhead{#1}\def\covrun@rhead{#2}}
\def\cov@yrhead#1{\def\covrun@rhead{#1}\def\cov@rhead{#1}}

\def\coverlfoot{\@ifnextchar[{\cov@xlfoot}{\cov@ylfoot}}
\def\cov@xlfoot[#1]#2{\def\cov@lfoot{#1}\def\covrun@lfoot{#2}}
\def\cov@ylfoot#1{\def\covrun@lfoot{#1}\def\cov@lfoot{#1}}

\def\covercfoot{\@ifnextchar[{\cov@xcfoot}{\cov@ycfoot}}
\def\cov@xcfoot[#1]#2{\def\cov@cfoot{#1}\def\covrun@cfoot{#2}}
\def\cov@ycfoot#1{\def\covrun@cfoot{#1}\def\cov@cfoot{#1}}

\def\coverrfoot{\@ifnextchar[{\cov@xrfoot}{\cov@yrfoot}}
\def\cov@xrfoot[#1]#2{\def\cov@rfoot{#1}\def\covrun@rfoot{#2}}
\def\cov@yrfoot#1{\def\covrun@rfoot{#1}\def\cov@rfoot{#1}}


%                 Initialize coverpage head and foot:

\coverlhead{}
\coverchead{}
\coverrhead{}
\coverlfoot{}
\covercfoot{}
\coverrfoot{}

%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                      Headrules and footrules:

\newif\if@headrule
\newif\ifrun@headrule

\def\firstpageheadrule{\@headruletrue}
\def\nofirstpageheadrule{\@headrulefalse}

\def\runningheadrule{\run@headruletrue}
\def\norunningheadrule{\run@headrulefalse}

\def\headrule{\@headruletrue\run@headruletrue}
\def\noheadrule{\@headrulefalse\run@headrulefalse}

\newif\if@footrule
\newif\ifrun@footrule

\def\firstpagefootrule{\@footruletrue}
\def\nofirstpagefootrule{\@footrulefalse}

\def\runningfootrule{\run@footruletrue}
\def\norunningfootrule{\run@footrulefalse}

\def\footrule{\@footruletrue\run@footruletrue}
\def\nofootrule{\@footrulefalse\run@footrulefalse}

%                             Initialize:

\noheadrule
\nofootrule

%                 Cover page headrules and footrules:

\newif\ifcov@headrule
\newif\ifcovrun@headrule

\def\coverfirstpageheadrule{\cov@headruletrue}
\def\nocoverfirstpageheadrule{\cov@headrulefalse}

\def\coverrunningheadrule{\covrun@headruletrue}
\def\nocoverrunningheadrule{\covrun@headrulefalse}

\def\coverheadrule{\cov@headruletrue\covrun@headruletrue}
\def\nocoverheadrule{\cov@headrulefalse\covrun@headrulefalse}

\newif\ifcov@footrule
\newif\ifcovrun@footrule

\def\coverfirstpagefootrule{\cov@footruletrue}
\def\nocoverfirstpagefootrule{\cov@footrulefalse}

\def\coverrunningfootrule{\covrun@footruletrue}
\def\nocoverrunningfootrule{\covrun@footrulefalse}

\def\coverfootrule{\cov@footruletrue\covrun@footruletrue}
\def\nocoverfootrule{\cov@footrulefalse\covrun@footrulefalse}

%                             Initialize:

\nocoverheadrule
\nocoverfootrule

%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                \numpages, \iflastpage, and \oddeven
%     Also: \numpoints, \numquestions, \numparts, and \numsubparts
%                    Also also: \pointsofquestion
%     Also: \numcoverpages and \totalnumpages

\def\numpages{\@ifundefined{exam@lastpage}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@lastpage
}% numpages

% Change 2011/04/01: We added a ``0'' in front of mbox when \exam@lastcoverpage isn't defined.  So that the construction \romannumeral\numcoverpages won't generate an error on the first run of latex.
\def\numcoverpages{\@ifundefined{exam@lastcoverpage}%
  {0\mbox{\normalfont\bfseries ??}}%
  \exam@lastcoverpage
}% numpages

\def\totalnumpages{\@ifundefined{exam@totalpages}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@totalpages
}% numpages

\def\numpoints{\@ifundefined{exam@numpoints}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numpoints
}% numpoints
\def\numbonuspoints{\@ifundefined{exam@numbonuspoints}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numbonuspoints
}% numbonuspoints

\def\numquestions{\@ifundefined{exam@numquestions}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numquestions
}% numquestions

\def\numparts{\@ifundefined{exam@numparts}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numparts
}% numparts

\def\numsubparts{\@ifundefined{exam@numsubparts}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numsubparts
}% numsubparts

\def\numsubsubparts{\@ifundefined{exam@numsubsubparts}%
  {\mbox{\normalfont\bfseries ??}}%
  \exam@numsubsubparts
}% numsubsubparts

\def\pointsofquestion#1{\@ifundefined{pointsofq@\romannumeral #1}%
  {\mbox{\normalfont\bfseries ??}}%
  {\csname pointsofq@\romannumeral #1\endcsname}%
}% pointsofquestion
\def\bonuspointsofquestion#1{\@ifundefined{bonuspointsofq@\romannumeral #1}%
  {\mbox{\normalfont\bfseries ??}}%
  {\csname bonuspointsofq@\romannumeral #1\endcsname}%
}% bonuspointsofquestion

% For use in \combinedgradetable and \combinedpointtable, ...

\def\pointsonpage#1{\@ifundefined{pointsonpage@\romannumeral #1}%
  {0}%
  {\csname pointsonpage@\romannumeral #1\endcsname}%
}% pointsonpage
\def\bonuspointsonpage#1{\@ifundefined{bonuspointsonpage@\romannumeral #1}%
  {0}%
  {\csname bonuspointsonpage@\romannumeral #1\endcsname}%
}% bonuspointsonpage

\newif\if@pointschanged
\@pointschangedfalse

\newcommand*{\CheckIfChanged@hlf}[2]{%
  % The first argument is the name of a half counter.
  % The second argument expands to the name of the control sequence holding the previous value.
  \@ifundefined{#2}%
    {\global\@pointschangedtrue}%
    {%
    % OK; it's defined.  See if it's changed:
    \begingroup
      \set@hlfcntr{tmp@hlfcntr}{\csname #2\endcsname}%
      \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
      \edef\pt@check{\prtaux@hlfcntr{#1}}%
      \ifx \pt@check \othpt@check
        % Do nothing
      \else
        \global\@pointschangedtrue
      \fi
    \endgroup
    }%
}% CheckIfChanged@hlf


\AtEndDocument{%
  \clearpage
  \if@filesw
    \advance\c@page-1
    \immediate\write\@mainaux
      {\string\gdef\string\exam@lastpage{\arabic{page}}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@lastcoverpage{\arabic{num@coverpages}}}%
    % We can now trash the value of num@coverpages:
    \addtocounter{num@coverpages}{\value{page}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@totalpages{\arabic{num@coverpages}}}%
    \advance\c@page+1 % In case some other package looks at \c@page
    %
    \immediate\write\@mainaux
        {\string\gdef\string\exam@numpoints{%
                            \prtaux@hlfcntr{numpoints}}}%
    % See if this has changed from the last run of LaTeX:
    \CheckIfChanged@hlf{numpoints}{exam@numpoints}%
    \immediate\write\@mainaux
        {\string\gdef\string\exam@numbonuspoints{%
                            \prtaux@hlfcntr{numbonuspoints}}}%
    % See if this has changed from the last run of LaTeX:
    \CheckIfChanged@hlf{numbonuspoints}{exam@numbonuspoints}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numquestions{\thenumquestions}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numparts{\thenumparts}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numsubparts{\thenumsubparts}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numsubsubparts{\thenumsubsubparts}}%
    \ifnum \thepageof@pagepoints > 0\relax
      \immediate\write\@mainaux
          {\string\gdef\string\pointsonpage@\romannumeral
                          \csname c@pageof@pagepoints\endcsname
             {\prtaux@hlfcntr{@pagepoints}}}%
      % See if this has changed from the last run of LaTeX:
      \CheckIfChanged@hlf{@pagepoints}{pointsonpage@\romannumeral
                          \csname c@pageof@pagepoints\endcsname}%
    \fi
    \ifnum \thepageof@pagebonuspoints > 0\relax
      \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsonpage@\romannumeral
                          \csname c@pageof@pagebonuspoints\endcsname
             {\prtaux@hlfcntr{@pagebonuspoints}}}%
      \CheckIfChanged@hlf{@pagebonuspoints}{bonuspointsonpage@\romannumeral
                          \csname c@pageof@pagebonuspoints\endcsname}%
    \fi
    \immediate\write\@mainaux
      {\string\gdef\string\lastpage@withpoints{\page@withpoints}}%
	% See if this has changed from the last run of LaTeX:
    \@ifundefined{lastpage@withpoints}%
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \edef\othpt@check{\page@withpoints}%
        \edef\pt@check{\lastpage@withpoints}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \immediate\write\@mainaux
      {\string\gdef\string\lastpage@withbonuspoints{\page@withbonuspoints}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{lastpage@withbonuspoints}%
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \edef\othpt@check{\page@withbonuspoints}%
        \edef\pt@check{\lastpage@withbonuspoints}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
  \fi
  % Echo numbers of questions, parts, and subparts:
  \typeout{This exam contains \thenumquestions\space questions
    with \thenumparts\space parts, \thenumsubparts\space subparts,
    and \thenumsubsubparts\space subsubparts.}
  % If counting points, echo total points:
  \if@printtotalpoints
    \begingroup
      \def\typ@expnd{%
        \thenumpoints
        \ifnumpoints@half
          \space and a half%
        \fi
      }
      \typeout{This exam has a total of \typ@expnd\space points.}
      \def\typ@expnd{%
        \thenumbonuspoints
        \ifnumbonuspoints@half
          \space and a half%
        \fi
      }
      \typeout{This exam has a total of \typ@expnd\space bonus points.}
    \endgroup
  \fi
  \if@pointschanged
    \ClassWarningNoLine{rvexam}{Point totals have changed.
               Rerun to get point totals right}%
  \fi
}% AtEndDocument

% We define \iflastpage so that it can safely be used in headers and footers:
\def\iflastpage#1#2{%
  \@ifundefined{exam@lastpage}{\def\@@lastpage{-1}}%
          {\edef\@@lastpage{\exam@lastpage}}%
  \ifnum\value{page}=\@@lastpage\relax
    #1%
  \else
    #2%
  \fi
}% iflastpage

\def\oddeven#1#2{%
  \ifodd\value{page}%
    #1%
  \else
    #2%
  \fi
}% oddeven

%--------------------------------------------------------------------
%				\PgInfo, \PgInfo@write and \PgInfo@get

\def\PgInfo@write#1{%
  \begingroup
    \edef\reserved@a{\write\@mainaux
      {\string\PgInfo{#1}{\noexpand\thepage}}}%
    \reserved@a
  \endgroup
}

\def\PgInfo#1#2{\expandafter\gdef\csname Pg@#1\endcsname{#2}}

\def\PgInfo@get#1{\csname Pg@#1\endcsname}

\def\set@counter@to@pageof#1#2{%
  \@ifundefined{Pg@#2}%
  {\setcounter{#1}{-1}}%
  {\setcounter{#1}{\csname Pg@#2\endcsname}}%
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%                 \ifcontinuation, \ContinuedQuestion,
%                \ifincomplete, and \IncompleteQuestion
%%\ifcontinuation
\def\ifcontinuation#1#2{%
  % If there's a \noquestionsonthispage command on this page, then we assume that we're not continuing anything:
  \@ifundefined{No@Questions@Pg@\thepage}%
    {\chk@contin{#1}{#2}}%
    {#2}%
}% \ifcontinuation

\def\chk@contin#1#2{%
  \expandafter\ifx\csname Pg@question@1\endcsname\relax
    % No page info yet; assume not a continuation
    #2%
  \else
    \ifnum \thepage < \csname Pg@question@1\endcsname\relax
      % We're before the page with question 1:
      #2%
    \else
      \expandafter\ifx\csname Contin@\thepage\endcsname\ref@relax
        #2%
      \else
        % See if we're after a \nomorequestions command:
        \@ifundefined{Pg@@endquestions}%
        {#1}%
        {\ifnum \thepage > \PgInfo@get{@endquestions}\relax
          % We're after a \nomorequestions:
          #2%
         \else
           % We actually are incomplete:
           #1%
         \fi
        }%
      \fi
    \fi 
  \fi
}% chk@contin

\def\nomorequestions{%
  \PgInfo@write{@endquestions}%
}% nomorequestions

\def\noquestionsonthispage{%
  \write\@mainaux{\string\expandafter\string\gdef
    \string\csname\space No@Questions@Pg@\thepage\string\endcsname
    {No questions here}}%
}% noquestionsonthispage

%--------------------------------------------------------------------

\def\ref@relax{\relax}

\def\ContinuedQuestion{%
  \expandafter\ifx\csname Contin@\thepage\endcsname\relax
    % continues whichever question was last begun on or before this page.
    \find@latestques
    \thelatest@ques
  \else
    \expandafter\ifx\csname Contin@\thepage\endcsname\ref@relax
      % This page begins with a new question,
      -1\relax
    \else
      % if Contin@\thepage has been defined to be a macro that expands to Q. No. that continues onto this page
      \csname Contin@\thepage\endcsname
    \fi
  \fi
}

\newcounter{latest@ques}

\newcommand\find@latestques{%
  % Has to find the last question that begun on or before the current page, rather than just before the current page.
  \ifnum 1 > \value{question}\relax
    \setcounter{latest@ques}{-1}%
  \else
    \expandafter\ifx\csname Pg@question@\arabic{question}\endcsname\relax
      \setcounter{latest@ques}{-1}%
    \else
      \setcounter{latest@ques}{\value{question}}%
      \decr@latest@ques
    \fi
  \fi
}

\def\decr@latest@ques{%
  \ifnum \thepage < \PgInfo@get{question@\thelatest@ques}\relax
    % Nope; latest@ques starts on a later page
    \addtocounter{latest@ques}{-1}%
    \ifnum \thelatest@ques < 1\relax
      \setcounter{latest@ques}{-1}%
      \let\next@dlq=\relax
    \else
	  %Recursive call
      \let\next@dlq=\decr@latest@ques
    \fi
  \else
    % latest@ques starts on this page or earlier
    \let\next@dlq=\relax
  \fi
  \next@dlq
}

\newcounter{ques@end}
\newcounter{last@object}

\def\find@quesend{%
  \find@latestques % Set the Q.no. of the ct. page
  \ifnum \value{latest@ques} < 0\relax % Must be an early run of LaTeX, before we have \PgInfo commands in the .aux file:
    \setcounter{ques@end}{-1}%
  \else
    % We now know that this question has at least one object: Find its highest numbered object by setting last@object = 2 and then call \find@lastobject to recursively
    \setcounter{last@object}{2}%
    \find@lastobject
    \setcounter{ques@end}{\PgInfo@get{question\thelatest@ques
               @object\thelast@object}}%
  \fi
}% find@quesend

\def\find@lastobject{%
  \@ifundefined{Pg@question\thelatest@ques @object\thelast@object}%
    {\addtocounter{last@object}{-1}%
      \let\nextfind@lastobject=\relax
    }%
    {\addtocounter{last@object}{1}%
      \let\nextfind@lastobject=\find@lastobject
    }%
  \nextfind@lastobject
}% find@lastobject

\newcounter{incmp@ques}

\def\IncompleteQuestion{%
  \Find@Incmp@ques
  % If there's no incomplete question, the counter incmp@ques will be set to -1:
  \theincmp@ques
}

\def\Find@Incmp@ques{%
  % If we're on the last page, then there's no incomplete question:
  \iflastpage{\setcounter{incmp@ques}{-1}}{\chk@incomp}%
}% Find@Incmp@ques
\newcounter{next@ques}
\newcounter{next@page}

\def\chk@incomp{%
  \find@quesend % Sets 'latest@ques' to last Q.no. and 'ques@end' to Page no. containing last ques@object
  \ifnum \theques@end > \thepage\relax
    % This question has a part (or sub...) starting on a later page
    \setcounter{incmp@ques}{\value{latest@ques}}%
  \else
    \chk@incompi
  \fi
}% chk@incomp

\def\chk@incompi{%
  \setcounter{next@ques}{\thelatest@ques}%
  \addtocounter{next@ques}{1}%
  \expandafter\ifx\csname Pg@question@\thenext@ques \endcsname\relax
    \@ifundefined{exam@lastpage}%
      {\setcounter{next@page}{-1}}%
      {\setcounter{next@page}{\exam@lastpage}}%
  \else
    \setcounter{next@page}{\PgInfo@get{question@\thenext@ques}}%
    \addtocounter{next@page}{-1}%
  \fi
  % See if that's after a \nomorequestions command:
  \@ifundefined{Pg@@endquestions}%
    {}%
    {\ifnum \PgInfo@get{@endquestions} < \value{next@page}\relax
       \setcounter{next@page}{\PgInfo@get{@endquestions}}%
     \fi
    }%
  % OK, the counter next@page now contains the last page to check.
  \chk@incompii
}% chk@incompi

\def\chk@incompii{%
  \ifnum \value{next@page} > \value{page}\relax
    % Checks if there are any pages between the ct. Q and next Q  - using \noquestionsonthispage
    \@ifundefined{No@Questions@Pg@\arabic{next@page}}%
    {\setcounter{incmp@ques}{\value{latest@ques}}%
      \let\next@incompii=\relax
    }%
    {\addtocounter{next@page}{-1}%
      \let\next@incompii = \chk@incompii
    }%
  \else
    % There's no incomplete question:
    \setcounter{incmp@ques}{-1}%
    \let\next@incompii=\relax
  \fi
  \next@incompii
}% chk@incompii

\def\ifincomplete#1#2{%
  % Save the arg.s in macros so they won't be messed up by the call to \Find@Incmp@ques:
  \def\incomp@first{#1}%
  \def\incomp@second{#2}%
  % If there's a \noquestionsonthispage command on this page, then assume nothing from this page is incomplete:
  \@ifundefined{No@Questions@Pg@\thepage}%
    {\chk@ifincomp}%
    {\incomp@second}%
}% ifincomplete

\def\chk@ifincomp{%
  \Find@Incmp@ques
  % If there's no incomplete question, \Find@Incmp@ques sets the counter incmp@ques to -1:
  \ifnum \theincmp@ques < 0\relax
    \incomp@second
  \else
    % Are we after a page with \nomorequestions?
    \@ifundefined{Pg@@endquestions}%
      {\incomp@first}%
      {\ifnum \thepage < \PgInfo@get{@endquestions}\relax
         \incomp@first
       \else
         \incomp@second
       \fi
      }%
  \fi
}% chk@ifincomp

%--------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Points Counter %%%%%%%%%%%%%%%%%%%%%%%%%
%
% The commands:
%
% \new@hlfcntr{countername}
% \set@hlfcntr{countername}{value}
% \copy@hlfcntr{tocounter}{fromcounter}
% \addto@hlfcntr{countername}{value}
% \add@hlfcntrtohlfcntr{getsaddedto}{whatsadded}
% \ifhlfcntr@pos{countername}
% \prtaux@hlfcntr{countername}
% \prt@hlfcntr{countername}
%
% Examples of valid values:
%   0; 0\half; 1; 1\half; etc.


% To create a hlfcntr:
\newcommand*\new@hlfcntr[1]{%
  \newcounter{#1}%
  \expandafter\newif\csname if#1@half\endcsname
}% new@hlfcntr


% A scratch hlfcntr:
\new@hlfcntr{tmp@hlfcntr}

\newcommand*\horiz@half{$\frac{1}{2}$}
\newcommand*\slanted@half{%
  $\raise0.6ex\hbox{$\scriptstyle 1$}\kern -.2em/\kern -.2em
     \raise-0.5ex\hbox{$\scriptstyle 2$}$%
}% slanted@half
\newcommand*\useslantedhalf{\global\let\half\slanted@half}
\newcommand*\usehorizontalhalf{\global\let\half\horiz@half}
\newcommand*\half{\slanted@half}

\newcommand*\set@hlfcntr[2]{%#1: counter; #2: value
  \begingroup
    \global\csname #1@halffalse\endcsname
    % If there as a `\half' present, it will be executed right after the digit part of #2 to the counter #1.
    \def\half{%May be to make '\half' local and Not to conflict with 1318, '\begingroup' is used
      \global\csname #1@halftrue\endcsname
    }%
    % We insert a `0' in case there are no digits present: We avoid using \setcounter, because calc.sty redefines
    % \setcounter in a way that conflicts with the \half trick we're using: \setcounter{#1}{0#2}\relax
    \global\csname c@#1\endcsname 0#2\relax
  \endgroup
}% set@hlfcntr

\newcommand*\copy@hlfcntr[2]{%#1: Destination; #2: Source
  \setcounter{#1}{\value{#2}}%
  \csname if#2@half\endcsname
    \global\csname #1@halftrue\endcsname
  \else
    \global\csname #1@halffalse\endcsname
  \fi
}% copy@hlfcntr

\newcommand*\addto@hlfcntr[2]{%#1: counter; #2: value
  \begingroup
    \def\half{\add@half{#1}}%May be to make '\half' local and Not to conflict with 1318, '\begingroup' is used
    \global\advance\csname c@#1\endcsname 0#2\relax
  \endgroup
}% addto@hlfcntr

\newcommand*\add@hlfcntrtohlfcntr[2]{%
  % We add the hlfcntr #2 to the hlfcntr #1
  \addtocounter{#1}{\value{#2}}%
  \csname if#2@half\endcsname
    \add@half{#1}%
  \fi
}% add@hlfcntrtohlfcntr

\newcommand*\add@half[1]{% Adds 0.5 to #1 and removes \half; Eg.1\half+0.5=2(1+1)
  \csname if#1@half\endcsname
    \addtocounter{#1}{1}%
    \global\csname #1@halffalse\endcsname
  \else
    \global\csname #1@halftrue\endcsname
  \fi
}% add@half

% Important reminder about \ifhlfcntr@pos: Do not use it inside another conditional! 
%------------------------- Used to print in .Aux file
\newcounter{ifpos@cntr}

\def\ifhlfcntr@pos#1{%% The argument must be a hlfcntr 
  \setcounter{ifpos@cntr}{\value{#1}}%
  \csname if#1@half\endcsname
    \addtocounter{ifpos@cntr}{1}%This action is equivalent to \add@half
  \fi
  \ifnum \value{ifpos@cntr} > 0\relax
}% ifhlfnctr@pos

% \prtaux@hlfcntr is used inside the argument of a \write command for writing to the .aux file:
\newcommand*\prtaux@hlfcntr[1]{%
  % We don't want a \relax after the 0 in the following line, because it would sometimes appear in the aux file:
  \ifnum \value{#1} = 0 
    % We have to make the following a macro, because if we don't do this part, the \fi will cause confusion, since there's no \if visible until the \csname is expanded:
    \prtaux@halforzero{#1}%
  \else
    \arabic{#1}% Convert to number to be written in .Aux file
    \prtaux@halforblank{#1}%
  \fi
}% prtaux@hlfcntr

\newcommand*\prtaux@halforzero[1]{%
  \csname if#1@half\endcsname
    \string\half
  \else
    0%
  \fi
}% prtaux@hlforzero
\newcommand*\prtaux@halforblank[1]{%
  \csname if#1@half\endcsname
    \string\half
  \fi
}% prtaux@halforblank

\newcommand*\prt@hlfcntr[1]{%
  \ifnum \value{#1} = 0 
    \prt@halforzero{#1}%
  \else
    \arabic{#1}%
    \prt@halforblank{#1}%
  \fi
}% prt@hlfcntr

\newcommand*\prt@halforzero[1]{%
  \csname if#1@half\endcsname
    \half
  \else
    0%
  \fi
}% prt@hlforzero

\newcommand*\prt@halforblank[1]{%
  \csname if#1@half\endcsname
    \half
  \fi
}% prt@halforblank

% End of the commands for dealing with hlfcntr's
%--------------------------------------------------------------------
%---------------------------------------------------------------------
%
%                    ***************************
%                    ** CO & BT **
%                    ***************************
\newcounter{num@cos}
\newcounter{num@bts}
\newcounter{temp@cobt}
\setcounter{num@cos}{5}% Default value: 4+1
\setcounter{num@bts}{6}% Default value: 6
\setcounter{temp@cobt}{0}% Default value

\newcommand*{\numofcos}[1]{% Check if it's an integer
	\ifnum \isint{#1} > 0 \relax
		\ifnum #1 > 4 \relax
			\setcounter{num@cos}{#1}
			\addtocounter{num@cos}{1}
		\else
			\ClassWarning{rvexam}{%
				I found that the value of #1 is not more than 4. So I will set it to 4.
			}
		\fi
	\else
		\ClassError{rvexam}{%
			I found a #1 is not an integer.\MessageBreak
		}{%
			Use \protect\numofcos with an integer.\MessageBreak
      }%
	\fi
}
%--------------------------- Integer check [def] ---------------------------
\def\isint#1{
	\if\relax\detokenize\expandafter{\romannumeral-0#1}\relax
		1% return 1 if integer
	\else
		0
	\fi
}
%---------------------------- Sets the COs -----------------------------------
\def\set@cos{%
  \addtocounter{temp@cobt}{1}%
  \ifnum \thetemp@cobt < \thenum@cos\relax
    \new@hlfcntr{co@\thetemp@cobt}%
    \set@hlfcntr{co@\thetemp@cobt}{0}% default value
    \let\next@setcos = \set@cos
  \else
    \let\next@setcos = \relax
  \fi
  \next@setcos
}% set@cos

\set@cos%
%---------------------------- Set BT ------------------------------------
% Hoping that there are only 6 BTs
\setcounter{temp@cobt}{0}% reset
\def\set@bts{%
  \addtocounter{temp@cobt}{1}%
  \ifnum \thetemp@cobt < 7\relax
    \new@hlfcntr{bt@\thetemp@cobt}%
    \set@hlfcntr{bt@\thetemp@cobt}{0}% default value
    \let\next@setbts = \set@bts
  \else
    \let\next@setbts = \relax
  \fi
  \next@setbts
}% set@cos

\set@bts%
%---------------------------------------------------------------------
%
%                    ***************************
%                    ** QUESTION ENVIRONMENTS **
%                    ***************************

% We use the counter name `partno' for the parts environment so that we will not interfere with the counter `part' used by the article document class.

\newcounter{question}
\newcounter{partno}
\newcounter{subpart}
\newcounter{subsubpart}
\newcounter{choice}
\new@hlfcntr{numpoints}
\set@hlfcntr{numpoints}{0}
\new@hlfcntr{numbonuspoints}
\set@hlfcntr{numbonuspoints}{0}
\new@hlfcntr{pointsof@thisquestion}
\set@hlfcntr{pointsof@thisquestion}{0}
\new@hlfcntr{bonuspointsof@thisquestion}
\set@hlfcntr{bonuspointsof@thisquestion}{0}
\newcounter{numquestions}
\newcounter{numparts}
\newcounter{numsubparts}
\newcounter{numsubsubparts}
\newcounter{Curr@Page}

% @pagepoints accumulates the points on a single page:
\new@hlfcntr{@pagepoints}
\set@hlfcntr{@pagepoints}{0}
\new@hlfcntr{@pagebonuspoints}
\set@hlfcntr{@pagebonuspoints}{0}
\newcounter{pageof@pagepoints}
\setcounter{pageof@pagepoints}{0}
\newcounter{pageof@pagebonuspoints}
\setcounter{pageof@pagebonuspoints}{0}

% latest@points is a holding area for points until we know whether they'll land on the same page as the points currently counted in @pagepoints:
\new@hlfcntr{latest@points}
\set@hlfcntr{latest@points}{0}
\new@hlfcntr{latest@bonuspoints}
\set@hlfcntr{latest@bonuspoints}{0}

% Whenever we meet a new page with points defined, we'll redefine \page@withpoints to expand to that page.  
% At the end of the document, it will hold the last page that has points, and we'll write a \gdef\lastpage@withpoints command to the .aux file.
% We initialize \page@withpoints here:
\def\page@withpoints{0}%
\def\page@withbonuspoints{0}%

% \pageinfo@commands is used by each question ... subsubpart to insert into everypar 
%% the \PgInfo@write command to put its page number into the .aux file, 
%% the \PgInfo@get command to read the page number into the counter Curr@Page, and to test and set \Contin@\theCurr@Page.  

% \temp@toks is used by part, ... subsubpart to append all that to \pageinfo@commands, rather than deleting whatever may have been put into \pageinfo@commands by the current question and/or part and/or subpart.

\newtoks\pageinfo@commands
\newtoks\temp@toks

% \pagepoint@commands holds the commands to manage the counting of the number of points defined on each page.
\newtoks\pagepoint@commands

% \point@toks holds the commands to print the points at the proper location on the page (except that it's not used by the \qformat option).
\newtoks\point@toks

% We'll use \greeknum to number subsubparts
\def\greeknum#1{\expandafter\lc@greek\csname c@#1\endcsname}
\def\lc@greek#1{%
  \ifcase #1
  \or $\alpha$\or $\beta$\or $\gamma$\or $\delta$\or
  $\epsilon$\or $\zeta$\or $\eta$\or $\theta$\or $\iota$\or
  $\kappa$\or $\lambda$\or $\mu$\or $\nu$\or $\xi$\or o\or $\pi$\or
  $\rho$\or $\sigma$\or $\tau$\or $\upsilon$\or $\phi$\or $\chi$\or
  $\psi$\or $\omega$\else \@ctrerr
  \fi
}% lc@greek

% Both \prepend@toklist and \append@toklist take two arguments, both of which should be token lists.

\def\prepend@toklist#1#2{% prepends #2 to #1
  \edef\do@it{\noexpand#1={\the#2\the#1}}%
  \do@it
}% prepend@toklist

\def\append@toklist#1#2{% appends #2 to #1
  \edef\do@it{\noexpand#1={\the#1\the#2}}%
  \do@it
}% append@toklist

% The \qformat command: \thepoints will be replaced by ``\@points \@pointname'' if the pts are specified by the Q at location using "conditional @placepoints" 
\newif\if@qformat
\@qformatfalse
\newif\if@bonusqformat
\@bonusqformatfalse

\def\qformat#1{%
  \global\@qformattrue
  \gdef\@questionformat{#1}%
}% qformat
\def\bonusqformat#1{%
  \global\@bonusqformattrue
  \gdef\@bonusquestionformat{#1}%
}% bonusqformat

\newcommand\noqformat{%
  \global\@qformatfalse
}% noqformat
\newcommand\nobonusqformat{%
  \global\@bonusqformatfalse
}% nobonusqformat

% \thepoints: for use in either a \qformat command or a \pointformat command (or a \bonusqformat command).
\newcommand\thepoints{%
  \if@placepoints% it's used in a \qformat command it won't print anything if there are no points:
    \if@bonus
      \@points \@bonuspointname
    \else
      \@points \@pointname
    \fi
  \fi
}% thepoints

% \themarginpoints: is for use only in a \pointformat command, and so it doesn't need the \if@placepoints bit in \thepoints:
\newcommand\themarginpoints{%
  \if@bonus
    \@points \@marginbonuspointname
  \else
    \@points \@marginpointname
  \fi
}% themarginpoints

% We define the \subpart and \subsubpart commands when we enter a questions environment (rather than waiting until we enter a subparts
% or subsubparts environment) so that we can signal an error if a \subpart or \subsubpart command appears outside of the corresponding environment.  
% (We don't do this for the \part command so that the user can use the standard sectioning \part command outside of a parts environment.)

% ques@object: count the items in each question, where an item is defined as either the question itself, or a part, or ... choice.  
% This will be used by \find@quesend to find the last page occupied by the last question begun on or before the current page:
\newcounter{ques@object}

\newcommand{\first@questionobject}{% used by the \question command
  \setcounter{ques@object}{1}%
  % \PgInfo@write expands it's argument, so we don't need edef:
  \PgInfo@write{question\arabic{question}@object\arabic{ques@object}}%
}% first@questionobject

% Used by each part, subpart, and subsubpart, and can also be used by the user to mark the end of a question that spills over onto the next page without any part, subpart, etc. starting on that page:

\newcommand{\addquestionobject}{%
  \addtocounter{ques@object}{1}%
  \PgInfo@write{question\arabic{question}@object\arabic{ques@object}}%
}% addquestionobject

% Used by each choice, as well as by any \part, \subpart, or \subsubpart that's inside of a solution.  
% Uses the questionobject to check if we're the first one on the current page, since choices (and questions etc. inside sol env) don't have labels the way that questions, ... subsubparts do (which use the label to check if they're the first thing on the page).

\newcommand{\questionobject@pluspagecheck}{%
  % We don't want to do any of this if we're both inside a sol env and not printing answers (to avoid incrementing ques@object):
  \if@insolution
    \ifprintanswers
      \doqobj@ppchk
    \fi
  \else
    \doqobj@ppchk
  \fi
}% questionobject@pluspagecheck

\newcommand{\doqobj@ppchk}{%
  \addtocounter{ques@object}{1}%
  % We need the edef because we check the page of \q@object@label:
  \edef\q@object@label{%
    question\arabic{question}@object\arabic{ques@object}}%
  \PgInfo@write{\q@object@label}%
  \set@counter@to@pageof{Curr@Page}{\q@object@label}%
  \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
    % We're the first \question, \part, \subpart, \subsubpart,
    % or choice on this page:
    \global\expandafter\edef\csname
    Contin@\theCurr@Page\endcsname{\arabic{question}}%
  \fi
}% doqobj@ppchk                               

% true when we're doing a bonusquestion or bonuspart or etc. Also used to distinguish b/w \\gradetable and \\bonusgradetable (and b/w \\pointtable and \\bonuspointtable, etc.), and b/w \\pointsinrange and \\bonuspointsinrange:

\newif\if@bonus
\@bonusfalse

%-----------------------------Adv. Users: to customize the list parameters ------------------------------
% The following are for advanced users who want to customize the list parameters (\topsep, \partopsep, \itemsep, \parsep, etc.) for the lists that these environments create.  They are all defined to be empty, but the user can change them using \renewcommand.

\newcommand\questionshook{}
\newcommand\partshook{}
\newcommand\subpartshook{}
\newcommand\subsubpartshook{}
\newcommand\choiceshook{}
\newcommand\checkboxeshook{}

\newenvironment{questions}{%
  % \@queslevel is used for two purposes:
  % (1) Check that every \question, \part, \subpart, and \subsubpart command appears inside the appropriate environment, and generate an error if one appears in the wrong place.
  % (2) If a \qformat is being used and if \@queslevel tells us that we're currently processing a question, then we set \global \point@toks={} to avoid setting the points for a question other than via the qformat command.
  \def\@queslevel{question}%
  \def\titledquestion##1{%
    \@bonusfalse
    \def\thequestiontitle{##1}%
    \process@question
  }%
  \def\bonustitledquestion##1{%
    \@bonustrue
    \def\thequestiontitle{##1}%
    \process@question
  }%
  \def\question{%
    \@bonusfalse
    \def\thequestiontitle{\csname p@question\endcsname
                          \csname thequestion\endcsname}%
    \process@question
  }%
  \def\bonusquestion{%
    \@bonustrue
    \def\thequestiontitle{\csname p@question\endcsname
                          \csname thequestion\endcsname}%
    \process@question
  }%
  \def\process@question{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{question}%
    \addtocounter{numquestions}{1}%
    % Write the sum of points of the previous question (if any) to the .aux file. (At this point, Q counter has not yet been incremented, so \\value{question} is the number of the question that was just completed.)
    \if@filesw
      \ifnum \value{question} > 0\relax
        % First do regular points:
        \immediate\write\@mainaux
          {\string\gdef\string\pointsofq@
            \romannumeral \csname c@question\endcsname
              {\prtaux@hlfcntr{pointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{pointsof@thisquestion}{pointsofq@\romannumeral
                            \csname c@question\endcsname}%
        % Now do bonus points:
        \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsofq@
            \romannumeral \csname c@question\endcsname
              {\prtaux@hlfcntr{bonuspointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{bonuspointsof@thisquestion}%
                           {bonuspointsofq@\romannumeral
                             \csname c@question\endcsname}%
      \fi
    \fi
    \set@hlfcntr{pointsof@thisquestion}{0}%
    \set@hlfcntr{bonuspointsof@thisquestion}{0}%
    % If there was a question with points immediately preceding this question (i.e., there were no parts in the previous question), then @placepoints will still be true, and we need to cancel it. 
    \global \@placepointsfalse
    % point@toks will normally be empty at this point, but it might be nonempty if there were points somewhere in the previous question that never made it onto the page.
    \global \point@toks={}%
    % Important: Don't leave any blank lines inside of \pageinfo@commands!!  This token list will be dumped into horizontal mode by \everypar, and so any blank lines will cause paragraph breaks. 
    \pageinfo@commands={%
      \edef\@queslabel{question@\arabic{question}}%
      \PgInfo@write{\@queslabel}%
      \first@questionobject
      % In addition to the \PgInfo@write we use \label cmd
      \begingroup % to confine the change to \@currentlabel
        \def\@currentlabel{\thequestiontitle}%
        \label{\@queslabel}%
      \endgroup
      \set@counter@to@pageof{Curr@Page}{\@queslabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, \subsubpart, or choice on this page:
        \global\expandafter\edef
               \csname Contin@\theCurr@Page\endcsname{\relax}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% pageinfo@commands
    \ifhmode
      % Remove any skips at the end of the previous paragraph that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem% checks for [ and calls '\@readpoints', else calls '\item@points@pageinfo'
  }% process@question
  \def\subpart{%
    \@bonusfalse
    \process@subpart
  }%
  \def\bonussubpart{%
    \@bonustrue
    \process@subpart
  }%
  \def\process@subpart{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{subpart}%
    \if@insolution
      % We don't count this subpart, so no addtocounter{numsubparts}.
      \temp@toks={%
        \questionobject@pluspagecheck
        \global \pageinfo@commands={}%
        % We omit the pagepoint@commands
      }% temp@toks
    \else
      \addtocounter{numsubparts}{1}%
      % Important: Don't leave any blank lines inside of \pageinfo@commands!!  This token list will be dumped into horizontal mode by \everypar, and so any blank lines will cause paragraph breaks. 
      \temp@toks={%
        \edef\@subpartlabel{subpart@\arabic{question}%
          @\arabic{partno}@\arabic{subpart}}%
        \PgInfo@write{\@subpartlabel}%
        \addquestionobject
        \label{\@subpartlabel}%
        \set@counter@to@pageof{Curr@Page}{\@subpartlabel}%
        \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
          \global\expandafter\edef\csname
                         Contin@\theCurr@Page\endcsname{\arabic{question}}%
        \fi
        \the\pagepoint@commands
        \global \pageinfo@commands={}%
      }% temp@toks
    \fi
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@subpart
  \def\subsubpart{%
    \@bonusfalse
    \process@subsubpart
  }%
  \def\bonussubsubpart{%
    \@bonustrue
    \process@subsubpart
  }%
  \def\process@subsubpart{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{subsubpart}%
    \if@insolution
      % We don't count this subsubpart, so no addtocounter{numsubsubparts}.
      \temp@toks={%
        \questionobject@pluspagecheck
        \global \pageinfo@commands={}%
        % We omit the pagepoint@commands
      }% temp@toks
    \else
      \addtocounter{numsubsubparts}{1}% 
      \temp@toks={%
        \edef\@subsubpartlabel{subsubpart@\arabic{question}%
          @\arabic{partno}@\arabic{subpart}@\arabic{subsubpart}}%
        \PgInfo@write{\@subsubpartlabel}%
        \addquestionobject
        \label{\@subsubpartlabel}%
        \set@counter@to@pageof{Curr@Page}{\@subsubpartlabel}%
        \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
          \global\expandafter\edef\csname
                         Contin@\theCurr@Page\endcsname{\arabic{question}}%
        \fi
        \the\pagepoint@commands
        \global \pageinfo@commands={}%
      }% temp@toks
    \fi
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@subsubpart
  \list{\question@number}%
    {\usecounter{question}%
    \settowidth{\leftmargin}{10.\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \partopsep=0pt
    \questionshook
    }%
  }% End of the first argument of \newenvironment{questions}
  {%
    \endlist
    % Write the number of points of the final question to the .aux file:
    \if@filesw
      \ifnum \value{question} > 0\relax
        % First do the regular points:
        \immediate\write\@mainaux
          {\string\gdef\string\pointsofq@\romannumeral
                                \csname c@question\endcsname
            {\prtaux@hlfcntr{pointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{pointsof@thisquestion}%
                           {pointsofq@\romannumeral
                            \csname c@question\endcsname}%
        % Now do the bonus points:
        \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsofq@\romannumeral
                                \csname c@question\endcsname
            {\prtaux@hlfcntr{bonuspointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{bonuspointsof@thisquestion}%
                           {bonuspointsofq@\romannumeral
                            \csname c@question\endcsname}%
      \fi
    \fi
  }% End of the second argument of \newenvironment{questions}

\def\question@number{%
  \if@bonus
    \if@bonusqformat
      \makebox[\hsize][s]{\@bonusquestionformat}\hskip-\labelsep
    \else
      \questionlabel
    \fi
  \else
    \if@qformat
      \makebox[\hsize][s]{\@questionformat}\hskip-\labelsep
    \else
      \questionlabel
    \fi
  \fi
}
\newcommand\questionlabel{\thequestion.}

\newenvironment{parts}{%
  \def\@queslevel{part}%
  % If Q.no.s are being inserted via a \qformat, and if a Q is beginning with a parts env, then we need to enter H mode to get the qformat printed on the page.
  \if@bonus
    \if@bonusqformat
      \if@inlabel% tells us if we are still waiting to enter H mode after seeing a \question command.
        \leavevmode
        \@inlabelfalse
      \fi
      % The following is just in case the question had points, in which case @placepoints will still be true...
      \global \@placepointsfalse
    \fi
  \else
    \if@qformat
      \if@inlabel
        \leavevmode
        \@inlabelfalse
      \fi
      \global \@placepointsfalse 
    \fi
  \fi
  \def\part{%
    \@bonusfalse
    \process@part
  }%
  \def\bonuspart{%
    \@bonustrue
    \process@part
  }%
  \def\process@part{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{part}%
    \if@insolution
      % We don't count this part, so no addtocounter{numparts}.
      \temp@toks={%
        \questionobject@pluspagecheck
        \global \pageinfo@commands={}%
        % We omit the pagepoint@commands
      }% temp@toks
    \else
      \addtocounter{numparts}{1}% 
      \temp@toks={%
        \edef\@partlabel{part@\arabic{question}@\arabic{partno}}%
        \PgInfo@write{\@partlabel}%
        \addquestionobject
        \label{\@partlabel}%
        \set@counter@to@pageof{Curr@Page}{\@partlabel}%
        \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
          \global\expandafter\edef\csname
              Contin@\theCurr@Page\endcsname{\arabic{question}}%
        \fi
        \the\pagepoint@commands
        \global \pageinfo@commands={}%
      }% temp@toks
    \fi
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@part
  \list{\partlabel}%
    {%
    \usecounter{partno}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{(m)\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    \partshook
    }%
  }% newenvironment{parts}
  {\endlist}
\newcommand\partlabel{(\thepartno)}
\def\thepartno{\alph{partno}}

\newenvironment{subparts}{%
  \def\@queslevel{subpart}%
  \list{\subpartlabel}%
    {%
    \usecounter{subpart}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{vii.\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    \subpartshook
    }%
  }%
  {\endlist}
\newcommand\subpartlabel{\thesubpart.}
\def\thesubpart{\roman{subpart}}

\newenvironment{subsubparts}{%
  \def\@queslevel{subsubpart}%
  \list{\subsubpartlabel}%
    {%
    \usecounter{subsubpart}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{($\psi$)\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    \subsubpartshook
    }%
  }%
  {\endlist}
\newcommand\subsubpartlabel{\thesubsubpart)}
\def\thesubsubpart{\greeknum{subsubpart}}

\pagepoint@commands={%
  \ifhlfcntr@pos{latest@points}%
    % We're putting a question (or part, etc.) with points onto this page: 
    \ifnum \theCurr@Page > \thepageof@pagepoints\relax
      % These points go on a later page than the points currently counted in @pagepoints:
      \ifnum \thepageof@pagepoints = 0\relax
        % Do nothing...
      \else
        \immediate\write\@mainaux
          {\string\gdef\string\pointsonpage@
           \romannumeral \csname c@pageof@pagepoints\endcsname
             {\prtaux@hlfcntr{@pagepoints}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{@pagepoints}{pointsonpage@\romannumeral
                            \csname c@pageof@pagepoints\endcsname}%
      \fi
      % The following is a macro because \theCurr@Page and \thepageof@pagepoints might differ by more than 1:
      \increment@pageof@pagepoints
      \label{firstpoints@onpage@\arabic{Curr@Page}}%
    \else
      % These points go on the same page as the points currently counted in @pagepoints:
      \add@hlfcntrtohlfcntr{@pagepoints}{latest@points}%
      \set@hlfcntr{latest@points}{0}%
    \fi
  \fi
  \ifhlfcntr@pos{latest@bonuspoints}%
    \ifnum \theCurr@Page > \thepageof@pagebonuspoints\relax
      % These bonus points go on a later page than the points currently counted in @pagebonuspoints:
      \ifnum \thepageof@pagebonuspoints = 0\relax
        % Do nothing...
      \else
        \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsonpage@
           \romannumeral \csname c@pageof@pagebonuspoints\endcsname
             {\prtaux@hlfcntr{@pagebonuspoints}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{@pagebonuspoints}%
                           {bonuspointsonpage@\romannumeral
                            \csname c@pageof@pagebonuspoints\endcsname}%
      \fi
      \increment@pageof@pagebonuspoints
      \label{firstbonuspoints@onpage@\arabic{Curr@Page}}%
    \else
      \add@hlfcntrtohlfcntr{@pagebonuspoints}{latest@bonuspoints}%
      \set@hlfcntr{latest@bonuspoints}{0}%
    \fi
  \fi
}% pagepoint@commands

\def\increment@pageof@pagepoints{%
  \addtocounter{pageof@pagepoints}{1}%
  \ifnum \theCurr@Page > \thepageof@pagepoints\relax
    \immediate\write\@mainaux
        {\string\gdef\string\pointsonpage@
         \romannumeral \csname c@pageof@pagepoints\endcsname{0}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{pointsonpage@\romannumeral
                        \csname c@pageof@pagepoints\endcsname}
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral 
                  \csname c@pageof@pagepoints\endcsname\endcsname}%
        \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
        \def\pt@check{0}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \let\next@incr@pageof = \increment@pageof@pagepoints
  \else
    \copy@hlfcntr{@pagepoints}{latest@points}%
    \set@hlfcntr{latest@points}{0}%
    % \page@withpoints will be used to find the last page that has points, which will be written to the .aux file via \AtEndDocument:
    \global\edef\page@withpoints{\thepageof@pagepoints}%
    \let\next@incr@pageof = \relax
  \fi
  \next@incr@pageof
}% increment@pageof@pagepoints

\def\increment@pageof@pagebonuspoints{%
  \addtocounter{pageof@pagebonuspoints}{1}%
  \ifnum \theCurr@Page > \thepageof@pagebonuspoints\relax
    \immediate\write\@mainaux
        {\string\gdef\string\bonuspointsonpage@
         \romannumeral \csname c@pageof@pagebonuspoints\endcsname{0}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{bonuspointsonpage@\romannumeral
                        \csname c@pageof@pagebonuspoints\endcsname}
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \set@hlfcntr{tmp@hlfcntr}{\csname bonuspointsonpage@\romannumeral 
                  \csname c@pageof@pagebonuspoints\endcsname\endcsname}%
        \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
        \def\pt@check{0}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \let\next@incr@pageof = \increment@pageof@pagebonuspoints
  \else
    \copy@hlfcntr{@pagebonuspoints}{latest@bonuspoints}%
    \set@hlfcntr{latest@bonuspoints}{0}%
    % \page@withbonuspoints will be used to find the last page that has bonus points, which will be written to the .aux file via \AtEndDocument:
    \global\edef\page@withbonuspoints{\thepageof@pagebonuspoints}%
    \let\next@incr@pageof = \relax
  \fi
  \next@incr@pageof
}% increment@pageof@pagebonuspoints

\def\@checkqueslevel#1{%
  \begingroup
    \def\exam@temp{#1}%
    \ifx\exam@temp\@queslevel
      % Everything's fine; do nothing.
    \else
      \ClassError{rvexam}{%
        I found a #1 where I expected to find a
        \@queslevel\MessageBreak
      }{%
        Both #1 and \@queslevel \space can be used only inside the
        correct \MessageBreak \space \space
        environment and outside of any smaller environment
        \MessageBreak
      }%
    \fi
  \endgroup
}

\def\@doitem{\@ifnextchar[{\@readpoints}%
                          {\item@points@pageinfo}%
}

\newcounter{temp@cos}

\def\@readpoints[#1][#2][#3]{%
% We use \def for \@points instead of \edef because we don't want \half (if present) to be expanded yet, so that the command \points can figure out how to deal with it:
  \def\@points{#1}%
  \gdef\@co{#2}
  \gdef\@bt{#3}
  \global \@placepointstrue
  \if@addpoints
    \if@bonus
      \addto@hlfcntr{numbonuspoints}{\@points}%
      \addto@hlfcntr{bonuspointsof@thisquestion}{\@points}%
      % latest@bonuspoints is a holding area for bonus points to be added to @pagepoints after we check whether they're on the same page as the points currently counted by @pagepoints:
      \addto@hlfcntr{latest@bonuspoints}{\@points}%
    \else
      \addto@hlfcntr{numpoints}{\@points}%
      \addto@hlfcntr{pointsof@thisquestion}{\@points}%
      \addto@hlfcntr{latest@points}{\@points}%
    \fi
  \fi
 \setcounter{temp@cos}{\@co}
 \add@cos{\@points}
 \setcounter{temp@cos}{\@bt}
 \add@bts{\@points}
 \item@points@pageinfo
}

\def\lmt{6}
\def\add@cos#1{%
\ifnum \value{temp@cos} > \lmt\relax
\ClassError{rvexam}{%
              You can't have BTs and COs more than 6.\MessageBreak
              \MessageBreak
            }{%
              Sorry for the limitations in BT and CO.\MessageBreak
            }%
\else
	\expandafter\@ifundefined{c@co@\thetemp@cos}{%
      \ClassError{rvexam}{%
         This can't happen, see if the \protect\numofcos\space command is defined.\MessageBreak
              \MessageBreak
       }{%
         Define \protect\numofcos\space with value greater than 4 and less than 7 in the preamble section.\MessageBreak
        }%
	  }
	  {\addto@hlfcntr{co@\thetemp@cos}{#1}}
\fi 
}

\def\add@bts#1{%
\ifnum \value{temp@cos} > \lmt\relax
\ClassError{rvexam}{%
       You can't have BTs and COs more than 6.\MessageBreak
       \MessageBreak
     }{%
       Sorry for the limitations in BT and CO.\MessageBreak
      }%
  \else
	{\addto@hlfcntr{bt@\thetemp@cos}{#1}}
  \fi
}

\def\item@points@pageinfo{%
  \item
  \if@placepoints
    % After setting up \point@toks, we do \@placepointsfalse, but \point@block isn't actually expanded until we enter horizontal mode.  Thus, we define \padded@point@block, and use that instead of \point@block.
    \if@bonus
      \def\padded@point@block{%
        \begingroup
          \@placepointstrue
          \bonuspoint@block
        \endgroup
      }%
    \else
      \def\padded@point@block{%
        \begingroup
          \@placepointstrue
          \point@block
        \endgroup
      }%
    \fi
    % \setup@point@toks puts commands into \point@toks to place \padded@point@block at the correct spot. It doesn't append anything to \everypar (we do that in this macro, below). 
    \if@pointsdropped
      % Do nothing!
    \else
      \if@bonus
        \if@bonusqformat
          \ifx\ques@ref\@queslevel
            % Do nothing
          \else
            \setup@point@toks
          \fi
        \else
          \setup@point@toks
        \fi
      \else
        \if@qformat
          \ifx\ques@ref\@queslevel
            % Do nothing
          \else
            \setup@point@toks
          \fi
        \else
          \setup@point@toks
        \fi
      \fi
    \fi
    \global \@placepointsfalse
  \fi
  % Instead of appending  \the \pageinfo@commands \the \point@toks to \everypar, we insert them into the box \@labels. The \item command in those environments throws away the previous contents of \everypar, and so the tokens \the\pageinfo@commands \the\point@toks didn't get inserted where we expected.  
  % List environments *do* preserve the contents of the box \@labels, though.
  \global\setbox\@labels\hbox{\unhbox\@labels
    \the \pageinfo@commands
    \the \point@toks}%See org code for above explanation
}
%------------------- Initialize \@points:-------------------------------
\def\@points{0}
%------------------- setup@point@toks [def]-----------------------------
\def\setup@point@toks{%
% We set the token list \point@toks = sequence of cmds needed to put \padded@point@block at the correct location, followed by the tokens ``\global \point@toks={}''.  The \question, \part, \subpart, or \subsubpart cmd then adds the two tokens: ``\the\point@toks'' to \everypar.
  \if@pointstwosided
    % Set \csname \q@label \endcsname equal to the thing that expands to the pg no of the ct (Q or ...subsubpart; whatever it is), but do it carefully because, if we don't yet have page info, then it won't be defined:
    \ifx\@queslevel\ques@ref
      \def\q@label{Pg@question@\arabic{question}}
    \else
      \ifx\@queslevel\part@ref
        \def\q@label{Pg@part@\arabic{question}@\arabic{partno}}
      \else
        \ifx\@queslevel\subpart@ref
          \def\q@label{Pg@subpart@\arabic{question}%
            @\arabic{partno}@\arabic{subpart}}
        \else
          \ifx\@queslevel\subsubpart@ref
            \def\q@label{Pg@subsubpart@\arabic{question}%
              @\arabic{partno}@\arabic{subpart}@\arabic{subsubpart}}
          \else
            \ClassError{rvexam}{%
              This can't happen in function \protect\setup@point@toks
              \MessageBreak
            }{%
              An unexplained error occurred in rvexam.cls;\MessageBreak
              please inform the package maintainer, and send along
              \MessageBreak
              the LaTeX file that shows the error.\MessageBreak
            }%
          \fi
        \fi
      \fi
    \fi
    % 
    \expandafter\ifx \csname \q@label \endcsname\relax
      % No page info yet; put it into the right margin
      \@pointsinrightmargintrue
      \@pointsinleftmarginfalse
    \else
      \ifodd \csname \q@label \endcsname\relax
        \if@pointsinoutsidemargin
          \@pointsinrightmargintrue
          \@pointsinleftmarginfalse
        \else
          \@pointsinrightmarginfalse
          \@pointsinleftmargintrue
        \fi
      \else
        \if@pointsinoutsidemargin
          \@pointsinrightmarginfalse
          \@pointsinleftmargintrue
        \else
          \@pointsinrightmargintrue
          \@pointsinleftmarginfalse
        \fi
      \fi
    \fi
  \fi
  % That ends the \if@pointstwosided.
  % Now we actually setup \point@toks:
  \if@pointsinleftmargin
    \point@toks={%
          \llap{\padded@point@block 
                \hskip\@totalleftmargin
                \hskip\marginpointssep
          }%
          \global \point@toks={}%
    }%
  \else
    \if@pointsinrightmargin
      \point@toks={%
            \rlap{\hskip-\@totalleftmargin
                  \hskip\textwidth
                  \hskip\@rightmargin
                  \hskip-0.5\rightpointsmargin
                  \llap{\padded@point@block}%
            }%
            \global \point@toks={}%
      }%
    \else
      % The points just go after the question number:
      \point@toks={%
            \padded@point@block
            \enspace
            \global \point@toks={}%
      }%
    \fi
  \fi
}% setup@point@toks
%---------------------------- droppoints [def]--------------------------------
\def\droppoints{%
  \par\leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-0.5\rightpointsmargin
        \llap{\padded@point@block}%
  }% rlap
  \par
}
%---------------------------- droptotalpoints [def]--------------------------------
\def\droptotalpoints{%
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\total@block}%
  }% rlap
  \par
}% droptotalpoints
\def\droptotalbonuspoints{%
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\bonustotal@block}%
  }% rlap
  \par
}% droptotalbonuspoints

% The following is the default definition; it can be changed by a \totalformat command.
%--------------------------total@block [def]-----------------------------------
\def\total@block{%
  Total for Question \thequestion: \totalpoints\@marginpointname
}% total@block
\def\bonustotal@block{%
  Total for Question \thequestion: \totalbonuspoints\@marginbonuspointname
}% bonustotal@block
%--------------------------totalformat#1 [def]-----------------------------------
\def\totalformat#1{%
  \gdef\total@block{\begingroup #1\endgroup}%
}% totalformat
\def\bonustotalformat#1{%
  \gdef\bonustotal@block{\begingroup #1\endgroup}%
}% bonustotalformat
%--------------------------------------------------
% The following is for use in the argument to a \totalformat command:
\def\totalpoints{\pointsofquestion{\arabic{question}}}
\def\totalbonuspoints{\bonuspointsofquestion{\arabic{question}}}

\newif\if@placepoints %True: when we encounter a question (or part, etc.) that has points; False: Ref org for explanation
\@placepointsfalse

\newlength\marginpointssep %used if the user says \pointsinleftmargin; distance from whatever encloses the points (parentheses, brackets, or a box) to the left margin:
\setlength{\marginpointssep}{5pt}

\newlength\rightpointsmargin %used if the user says \pointsinrightmargin; distance from whatever encloses the point (parentheses, brackets, or a box) to the right edge of the paper
\setlength{\rightpointsmargin}{1cm}

\newif\if@pointsdropped
\newif\if@pointsinleftmargin
\newif\if@pointsinrightmargin
\newif\if@pointstwosided
\newif\if@pointsinoutsidemargin

% If we have \@pointstwosidedtrue and \@pointsinoutsidemarginfalse, then the points will be printed on the inside margin (left on odd numbered pages, right on even numbered pages).
% If we have \@pointstwosidedfalse, then \if@pointsinoutsidemargin is ignored.
% If we have \@pointstwosidedtrue, then both \@pointsinleftmargin and \@pointsinrightmargin will be flipped back and forth, as needed, in \setup@point@toks.

\def\pointsinleftmargin{\global\@pointsinleftmargintrue 
                    \global\@pointsinrightmarginfalse
                    \global\@pointsdroppedfalse
                    \global\@pointstwosidedfalse
                    \gdef\pt@name{\@marginpointname}%
                    \gdef\bnspt@name{\@marginbonuspointname}}
\def\pointsinrightmargin{\global\@pointsinrightmargintrue
                         \global\@pointsinleftmarginfalse
                         \global\@pointsdroppedfalse
                         \global\@pointstwosidedfalse
                         \gdef\pt@name{\@marginpointname}%
                         \gdef\bnspt@name{\@marginbonuspointname}}
\def\nopointsinmargin{\global\@pointsinleftmarginfalse
                      \global\@pointsinrightmarginfalse
                      \global\@pointsdroppedfalse
                      \global\@pointstwosidedfalse
                      \gdef\pt@name{\@pointname}%
                      \gdef\bnspt@name{\@bonuspointname}}
\def\pointsdroppedatright{\global\@pointsdroppedtrue
                          \global\@pointsinleftmarginfalse
                          \global\@pointsinrightmarginfalse
                          \global\@pointstwosidedfalse
                          \gdef\pt@name{\@marginpointname}%
                          \gdef\bnspt@name{\@marginbonuspointname}}
\def\pointstwosided{\global\@pointstwosidedtrue
                    \global\@pointsinoutsidemargintrue
                    \global\@pointsdroppedfalse
                    \gdef\pt@name{\@marginpointname}%
                    \gdef\bnspt@name{\@marginbonuspointname}}
\def\pointstwosidedreversed{\global\@pointstwosidedtrue
                            \global\@pointsinoutsidemarginfalse
                            \global\@pointsdroppedfalse
                            \gdef\pt@name{\@marginpointname}%
                            \gdef\bnspt@name{\@marginbonuspointname}}
\let\pointsinmargin=\pointsinleftmargin
\let\nopointsinrightmargin=\nopointsinmargin
\let\nopointsinleftmargin=\nopointsinmargin

%Initialize:
\nopointsinmargin

% Will the points be displayed inside parentheses (the default), or will they be boxed or bracketed, or customized using pointformat:
\def\boxedpoints{%
  \gdef\point@block{\fbox{\@points\pt@name}}%
  \gdef\bonuspoint@block{\fbox{\@points\bnspt@name}}%
}
\def\noboxedpoints{%
%  \gdef\point@block{\hbox to 0.4\rightpointsmargin{\vbox{M\par\@points}}\hbox to 0.4\rightpointsmargin{\vbox{C\par\;\@co}}\hbox to 0.2\rightpointsmargin{\vbox{L\par\;\@bt}}}%
  \gdef\point@block{(M\@points:CO\@co:L\@bt)}%
  \gdef\bonuspoint@block{(\@points\bnspt@name)}%
}
\def\bracketedpoints{%
  \gdef\point@block{[\@points\pt@name]}%
  \gdef\bonuspoint@block{[\@points\bnspt@name]}%
}
\let\nobracketedpoints=\noboxedpoints

%Initialize:
\noboxedpoints

\def\pointformat#1{%
  % We don't have to worry about the user putting things like \bfseries, etc. into \point@block, because \padded@point@block encloses \point@block in a group, which confines the effects of anything here:
  \gdef\point@block{#1}%
}

\def\bonuspointformat#1{%
  \gdef\bonuspoint@block{#1}%
}

\def\pointname#1{\gdef\@pointname{#1}}
\def\bonuspointname#1{\gdef\@bonuspointname{#1}}

% Initialize to leave a space, and then the word `points':
% Note the space before the \points in the following; it's intentional!
\pointname{ \points}
\bonuspointname{ \bonuspoints}

%--------------------------
\newcommand\point@sing{point}% Singular if point = 1; point is just a dummy variable (non expandable)
\newcommand\point@plur{points}% Plural if points > 1
\newcommand\pointpoints[2]{%
  \renewcommand\point@sing{#1}%
  \renewcommand\point@plur{#2}%
}

\newcommand\bonuspoint@sing{point (bonus)}% ; point (bonus) is just a dummy variable (non expandable)
\newcommand\bonuspoint@plur{points (bonus)}
\newcommand\bonuspointpoints[2]{%
  \renewcommand\bonuspoint@sing{#1}%
  \renewcommand\bonuspoint@plur{#2}%
}

%---------------------- The command \points: --------------------------------

\newcommand\points{%0 points, one half point, 1 point, 1 and a half points, etc.:
  \begingroup
    \let\half=\relax
    \edef\pt@string{\@points}%
    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half}}
          {\point@sing}{\point@plur}%
  \endgroup
}% \points
\newcommand\bonuspoints{%
  \begingroup
    \let\half=\relax
    \edef\pt@string{\@points}%
    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half}}
          {\bonuspoint@sing}{\bonuspoint@plur}%
  \endgroup
}% \bonuspoints
 
% We used to define a command named \marks that works like \points, except that it expands to either ``mark'' or ``marks'', but that conflicts with some package or other. Thus, we'll implement \marksnotpoints using the \pointpoints command instead:
\newcommand\marksnotpoints{%
  \pointpoints{mark}{marks}%
  \bonuspointpoints{mark (bonus)}{marks (bonus)}%
}% \marksnotpoints

% \@marginpointname is used in place of \@pointname if any of \@pointsinmargin, \@pointsinrightmargin, and \@pointsdropped are true:
\def\marginpointname#1{\gdef\@marginpointname{#1}}
\marginpointname{}
\def\marginbonuspointname#1{\gdef\@marginbonuspointname{#1}}
\marginbonuspointname{ (bonus)}

%--------------------------------------------------------------------
%         choices (for multiple choice) and checkboxes

\renewcommand\thechoice{\Alph{choice}}
\newcommand\choicelabel{\thechoice.}

% We will have \@correctchoicetrue when we're printing solutions and we're printing the correct choice of a choices or oneparchoices environment.
% We'll say \begingroup before saying \@correctchoicetrue and we'll say \endgroup at either the next \choice or \correctchoice or the end of the choices or oneparchoices environment.
% Thus, we'll never again need to say \@correctchoicefalse
\newif\if@correctchoice
\@correctchoicefalse

\newcommand\CorrectChoiceEmphasis[1]{%
  \def\CorrectChoice@Emphasis{#1}%
}
\CorrectChoiceEmphasis{\bfseries}
\let\correctchoiceemphasis\CorrectChoiceEmphasis

% Note: \do@choice@pageinfo is used in both the choices and the checkboxes environments.
\newtoks\choice@toks

\def\do@choice@pageinfo{%
  \choice@toks={%
    \questionobject@pluspagecheck
    \choice@toks={}%
  }%
  % Instead of appending stuff to \everypar, we insert \the \pageinfo@commands and \the \point@toks into the box \@labels:
  \global\setbox\@labels\hbox{\unhbox\@labels
    \the \choice@toks}%
}% do@choice@pageinfo

\newenvironment{choices}%
  {\list{\choicelabel}%
     {\usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
       \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 2.5em}%
       \def\choice{%
         \if@correctchoice
           \color@endgroup
           \endgroup
         \fi
         \item
         \do@choice@pageinfo
       } % choice
       \def\CorrectChoice{%
         \if@correctchoice
           \color@endgroup
           \endgroup
         \fi
         \ifprintanswers
           \refstepcounter{choice}%
           \item[{\color@begingroup \CorrectChoice@Emphasis
                  \choicelabel \color@endgroup}]%
           \begingroup \color@begingroup \@correctchoicetrue
           \CorrectChoice@Emphasis
         \else
            \item
         \fi
         \do@choice@pageinfo
       } % CorrectChoice
       \let\correctchoice\CorrectChoice
       \labelwidth\leftmargin\advance\labelwidth-\labelsep
       \topsep=0pt
       \partopsep=0pt
       \choiceshook
     }%
  }%
  {\if@correctchoice \color@endgroup \endgroup \fi \endlist}

\newenvironment{oneparchoices}%
  {%
    \setcounter{choice}{0}%
    \def\choice{%
      \if@correctchoice \endgroup \fi
      \refstepcounter{choice}%
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \choicelabel
      % No need to put the following into a token string; we just put the choicelabel onto the page, so we're at the spot whose page number we want to record:
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% choice
    \def\CorrectChoice{%
      \if@correctchoice \endgroup \fi
      \refstepcounter{choice}%
      \ifprintanswers
        \begingroup \@correctchoicetrue 
        \CorrectChoice@Emphasis
      \fi
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \choicelabel
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% CorrectChoice
    \let\correctchoice\CorrectChoice
    \let\par\@empty
    % If we're continuing the paragraph containing the question, then leave a bit of space before the first choice:
    \ifvmode\else\enskip\fi
    \ignorespaces
  }%
  {\if@correctchoice \endgroup \fi}

\newcommand{\checkboxchar}[1]{\def\checkbox@char{#1}}
\newcommand{\checkedchar}[1]{\def\checked@char{#1}}
\checkboxchar{$\bigcirc$}
\checkedchar{$\surd$}

\newenvironment{checkboxes}%
  {\list{\checkbox@char}%
     {%
       \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 2.5em}%
       \def\choice{%
         \if@correctchoice
           \color@endgroup \endgroup
         \fi
         \item
         \do@choice@pageinfo
       } % choice
       \def\CorrectChoice{%
         \if@correctchoice
           \color@endgroup \endgroup
         \fi
         \ifprintanswers
           \ifhmode \unskip\unskip\unvbox\voidb@x \fi
           \item[{\color@begingroup\CorrectChoice@Emphasis\checked@char
                 \color@endgroup}]%
           \begingroup \color@begingroup \@correctchoicetrue
           \CorrectChoice@Emphasis
         \else
           \item
         \fi
         \do@choice@pageinfo
       } % CorrectChoice
       \let\correctchoice\CorrectChoice
       \labelwidth\leftmargin\advance\labelwidth-\labelsep
       \topsep=0pt
       \partopsep=0pt
       \checkboxeshook
     }%
  }%
  {\if@correctchoice \color@endgroup \endgroup \fi \endlist}

\newenvironment{oneparcheckboxes}%
  {%
    % Although we're not printing numbers for the choices, we use the choice counter to keep track of whether a choice is the first one (in which case we don't leave any additional space) or a later one (in which case we do leave additional space):    
    \setcounter{choice}{0}%
    \def\choice{%
      \if@correctchoice \endgroup \fi
      \stepcounter{choice}%
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \checkbox@char
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% choice
    \def\CorrectChoice{%
      \if@correctchoice \endgroup \fi
      \stepcounter{choice}%
      \ifprintanswers
        \begingroup \@correctchoicetrue 
        \CorrectChoice@Emphasis
      \fi
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \ifprintanswers
        \checked@char
      \else
        \checkbox@char
      \fi
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% CorrectChoice
    \let\correctchoice\CorrectChoice
    \let\par\@empty
    \ifvmode\else\enskip\fi
    \ignorespaces
  }%
  {\if@correctchoice \endgroup \fi}

%--------------------------------------------------------------------
%             Answer Lines (for short answer questions)

% Note: \ques@ref is also used in \item@points@pageinfo, and all four of the following are used in \setup@point@toks

\def\ques@ref{question}
\def\part@ref{part}
\def\subpart@ref{subpart}
\def\subsubpart@ref{subsubpart}

% Note: \answerclearance is also used by \fillin

\newlength\answerlinelength
\newlength\answerskip
\newlength\answerclearance
\setlength\answerlinelength{1in}
\setlength\answerskip{2ex}
\setlength\answerclearance{0.2ex}

\newcommand\answerline[1][{}]{%
  % One optional argument, the default value of which is empty.
  \ifx\@queslevel\ques@ref
    \let\ans@l=\questionlabel
  \else
    \ifx\@queslevel\part@ref
      \let\ans@l=\partlabel
    \else
      \ifx\@queslevel\subpart@ref
        \let\ans@l=\subpartlabel
      \else
        \ifx\@queslevel\subsubpart@ref
          \let\ans@l=\subsubpartlabel
        \else
          % Oops; no question level defined. We must be outide of the questions environment. Just leave out the label, I guess:
          \def\ans@l{}%
        \fi
      \fi
    \fi
  \fi
  \par \nobreak \vskip \answerskip
  \hfill 
  \ifprintanswers
    \ans@l~\hbox to 0pt{\hbox to \answerlinelength{\hrulefill}\hss}%
    \raise \answerclearance\hbox to \answerlinelength{%
      % 2016/05/10: Added \color@begingroup and \color@endgroup:
      \color@begingroup
      \CorrectChoice@Emphasis \hfil #1\hss
      \color@endgroup}%
  \else
    \ans@l~\hbox to \answerlinelength{\hrulefill}%
  \fi
  \par
}% answerline

%--------------------------------------------------------------------
%               \fillin, for fill-in-the-blank questions

\newlength\fillinlinelength
\setlength\fillinlinelength{1in}

% \fillin can take two optional arguments: 1st optional arg is the ans to be printed above the line when \printanswers is in effect; the default value is empty. 2nd optional arg is the length of the line that we print; the default value is \fillinlinelength.

\newcommand\fillin[1][{}]{%
   \def\fillin@ans{#1}%
   \fillin@relay
}% fillin

\newcommand\fillin@relay{%
  % If \exam@ifnextchar (variation on \@ifnextchar) encounters one or more space characters followed by a [, then those spaces are ignored (just as they would be by \@ifnextchar). However, if one or more space characters are followed by a non-space character other than [, then \exam@ifnextchar inserts a space following the {\@fillin@relay[\fillinlinelength]} that is the third argument to \exam@ifnextchar.
  \exam@ifnextchar[{\@fillin@relay}
                   {\@fillin@relay[\fillinlinelength]}%
}% fillin@relay

\def\@fillin@relay[#1]{%
  % The first argument is in \fillin@ans, the second is #1.
  \leavevmode
  \ifprintanswers
    \rlap{\raise -\answerclearance \hbox to #1{\hrulefill}}%
    \begingroup
      \setbox0 \hbox{\color@begingroup
             \CorrectChoice@Emphasis \fillin@ans \color@endgroup}%
      \ifdim\wd0 > #1\relax
        \hbox{\color@begingroup\CorrectChoice@Emphasis \fillin@ans
              \color@endgroup}%
      \else
        \hbox to #1{\color@begingroup\CorrectChoice@Emphasis 
                    \hfil \fillin@ans \hfil\color@endgroup}%
      \fi
    \endgroup
  \else
    \raise -\answerclearance \hbox to #1{\hrulefill}%
  \fi
}% @fillin@relay

% \exam@ifnextchar is used by \fillin; does not always ignore space tokens.  If \exam@ifnextchar encounters one or more space tokens, it makes note of that (with the command \@tempswatrue). If the first non-space character encountered matches argument #1, then any spaces that had been encountered are ignored. However, if one or more spaces are encountered and the first non-space character found does not match argument #1, then \exam@ifnextchar produces argument #3 followed by a space character.

\long\def\exam@ifnextchar#1#2#3{%
  \let\reserved@d=#1%
  \def\reserved@a{#2}%
  \def\reserved@b{#3}%
  % The following says we haven't yet seen any spaces:
  \@tempswafalse
  \futurelet\@let@token\exam@ifnch
}% exam@ifnextchar

\def\exam@ifnch{%
  \ifx\@let@token\@sptoken
    % Signal that we've found a space:
    \@tempswatrue
    \let\reserved@c\exam@xifnch % this gobbles the space
  \else
    \ifx\@let@token\reserved@d
      \let\reserved@c\reserved@a
    \else
      \if@tempswa
        \def\reserved@c{\expandafter\reserved@b\space}%
      \else 
        \let\reserved@c\reserved@b
      \fi
    \fi
  \fi
  \reserved@c
}% exam@ifnch

% The following defines \exam@xifnch so that it will eat a space following it and then call \exam@ifnch:
{% keep redefinition of \: local
  \def\:{\exam@xifnch}
  \expandafter\gdef\: {\futurelet\@let@token\exam@ifnch}
}

%--------------------------------------------------------------------
%                            \fillwithlines


% \fillwithlines takes one argument, which is either a length or \fill or \stretch{number}, and it fills that much vertical space with horizontal lines that run the length of the current line, extending from the ct. left margin (which depends on whether we're in a question, part, subpart, or subsubpart) to the right margin.

\newlength\linefillheight
\newlength\linefillthickness
\setlength\linefillheight{.25in}
\setlength\linefillthickness{0.1pt}

\newif\if@colorfillwithlines
\@colorfillwithlinesfalse

\def\colorfillwithlines{%
  \@ifundefined{definecolor}
  {%
    \ClassError{rvexam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorfillwithlines
      \MessageBreak
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{FillWithLinesColor}{gray}{0.8}
    \@colorfillwithlinestrue
  }%
}% \colorfillwithlines
\def\nocolorfillwithlines{\@colorfillwithlinesfalse}

\newcommand\fillwithlines[1]{%
  \if@colorfillwithlines
    \color@begingroup
      \color{FillWithLinesColor}%
      \do@fillwithlines{#1}%
    \color@endgroup
  \else
    \do@fillwithlines{#1}%
  \fi
}% \fillwithlines

\newcommand\linefill{\leavevmode
    \leaders\hrule height \linefillthickness \hfill\kern\z@}

% \do@fillwithlines is called only by \fillwithlines
\def\do@fillwithlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \linefillheight depth \z@ width \z@
          \linefill}%
  % We use \cleaders (rather than \leaders) so that a given vertical space will always produce the same number of lines no matter where on the page it happens to start:
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}% \do@fillwithlines

%--------------------------------------------------------------------
%                         \fillwithdottedlines

\newlength\dottedlinefillheight
\setlength\dottedlinefillheight{.25in}

\newif\if@colorfillwithdottedlines
\@colorfillwithdottedlinesfalse

\def\colorfillwithdottedlines{%
  \@ifundefined{definecolor}
  {%
    \ClassError{rvexam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorfillwithdottedlines
      \MessageBreak
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{FillWithDottedLinesColor}{gray}{0.8}
    \@colorfillwithdottedlinestrue
  }%
}% \colorfillwithdottedlines
\def\nocolorfillwithdottedlines{\@colorfillwithdottedlinesfalse}

\newcommand\fillwithdottedlines[1]{%
  \if@colorfillwithdottedlines
    \color@begingroup
      \color{FillWithDottedLinesColor}%
      \do@fillwithdottedlines{#1}%
    \color@endgroup
  \else
    \do@fillwithdottedlines{#1}%
  \fi
}% \fillwithdottedlines

% \do@fillwithdottedlines is called only by \fillwithdottedlines
\def\do@fillwithdottedlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \dottedlinefillheight depth \z@ width \z@
          \dotfill}%
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}% \do@fillwithdottedlines

%--------------------------------------------------------------------
%                            \fillwithgrid

\newif\if@colorgrids

\newcommand\colorgrids{%
  \@ifundefined{definecolor}
  {%
    \ClassError{rvexam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorgrids
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{GridColor}{gray}{0.8}
    \@colorgridstrue
  }%
}% \colorgrids
\newcommand\nocolorgrids{\@colorgridsfalse}
\nocolorgrids

\newlength\gridsize
\newlength\gridlinewidth
\setlength{\gridsize}{5mm}
\setlength{\gridlinewidth}{0.1pt}

\def\fillwithgrid#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak

  % We first set box0 equal to an \hbox which, when printed, is a square with width and height equal to \gridsize+\gridlinewidth,

  \setlength{\@tempdima}{\gridsize}
  \addtolength{\@tempdima}{\gridlinewidth}
  \setlength{\@tempdimb}{\gridsize}
  \addtolength{\@tempdimb}{-\gridlinewidth}
  \setbox0=\hbox{%
    \rlap{\vrule height \gridsize depth \gridlinewidth width \gridlinewidth}%
    \rlap{\vrule height \gridsize depth -\@tempdimb width \@tempdima}%
    \vrule height 0pt depth \gridlinewidth width \@tempdima
    \llap{\vrule height \gridsize depth \gridlinewidth width \gridlinewidth}%
  }%
  \wd0=\gridsize
  \dp0=0pt
  
  % Now we set box1 equal to an \hbox containing a single line of copies of box0.  We use \leaders (instead of \cleaders) so that if we use it twice on a page, once with a question and once with a part, the boxes will line up vertically.  We add a kern of \gridlinewidth at the right because the rightmost vertical line appears to the right of where the \leaders command thinks that it appears.
  
  \setbox1=\hbox to \textwidth{%
    \color@begingroup
    \if@colorgrids
      \color{GridColor}%
    \fi
    \hskip \@totalleftmargin \leaders\copy0\hfil \kern\gridlinewidth
    \color@endgroup
  }%
  
  % Finally: We create the grid, using \cleaders: We use \cleaders (rather than \leaders) so that a given vertical space will always produce the same number of lines no matter where on the page it happens to start.  We add a kern of \gridlinewidth because the bottommost horizontal line appears below where the \cleaders command thinks that it appears.
  
  \cleaders \copy1 \vskip #1 \kern \gridlinewidth \hbox{}%
  \endgroup
}% fillwithgrid

%--------------------------------------------------------------------
%                            \makeemptybox

% \makeemptybox takes one argument, which is a length, and it creates an empty box of width the length of the current line and of height equal to the argument. 

\newlength\minboxheight
\setlength\minboxheight{.1in}

\newcommand\makeemptybox[1]{%
  \if@colorsolutionboxes
    \color@begingroup
      \color{SolutionBoxColor}%
      \do@emptybox{#1}%
    \color@endgroup
  \else
    \do@emptybox{#1}%
  \fi
}

% The command \do@emptybox is called only by \makeemptybox.
\newcommand\do@emptybox[1]{%
  \par
  \hbox to \hsize{\hskip\@totalleftmargin \leaders\hrule\hfill}%
  \nointerlineskip
  \begingroup
    \setbox0=\hbox to \hsize{\hskip\@totalleftmargin
                           \vrule height\minboxheight \hfill \vrule}%
    % The vertical size desired may not be an exact multiple of \minboxheight, and so \cleaders might leave a gap between the vertical lines and the horizontal lines above and below it. Thus, we put a single copy of \box0 immediately below the horizontal line above and we'll also put a single copy of \box0 immediately above the horizontal line below.
	%
    \copy0
    \nobreak
    \vskip -\minboxheight
    \cleaders \copy0 \vskip #1
    \vskip -\minboxheight
    \nointerlineskip
    \copy0
  \endgroup
  \nointerlineskip
  \hbox to \hsize{\hskip\@totalleftmargin \leaders\hrule\hfill}%
}

%--------------------------------------------------------------------
%                      \uplevel and \fullwidth
%           and the EnvUplevel and EnvFullwidth environments:

% \uplevel is used to print text at the indentation level of the enclosing environment. For example, to precede a question with directions about how that question should be answered, you would say \uplevel{Answer this question correctly.}
% 
% \fullwidth is similar, but uses the full page of text on the page.

% The EnvUplevel environment is similar to the \uplevel command, but it has the advantage that you can include verbatim material (using, e.g., the \verb command) in the environment.  (You can't include verbatim material in the argument of an \uplevel command.)

% The EnvFullwidth environment is similar to the \fullwidth command, but it has the advantage that you can include verbatim material (using, e.g., the \verb command) in the environment.

\long\def\uplevel#1{%
  \par\bigskip
  \vbox{%
    % We entered internal vertical mode, and so we get \parshape=0.
    % We set \leftskip to provide the correct left margin for whatever is in the argument of the \uplevel command:
    \leftskip=\@totalleftmargin
    \advance\leftskip-\leftmargin
    % We adjust \@totalleftmargin and linewidth in case there's a solution environment inside of the argument to the \uplevel:
    \advance\@totalleftmargin-\leftmargin
    \advance\linewidth\leftmargin
    #1%
  }% vbox
  \nobreak
}

\newenvironment{EnvUplevel}
  {\par\bigskip\vbox\bgroup
    % We set \leftskip to provide the correct left margin for whatever is inside of the environment:
    \leftskip=\@totalleftmargin
    \advance\leftskip-\leftmargin
    % We adjust \@totalleftmargin (and linewidth?) in case there's a solution environment inside of the environment:
    \advance\@totalleftmargin-\leftmargin
    \advance\linewidth\leftmargin
  }
  {\egroup\nobreak}


\long\def\fullwidth#1{%
  \par\bigskip
  \vbox{%
    % We entered internal vertical mode, and so we get \parshape=0.
    \leftskip=0pt \rightskip=0pt
    \advance\linewidth\@totalleftmargin
    \@totalleftmargin=0pt
    #1%
  }% vbox
  \nobreak
}

\newenvironment{EnvFullwidth}
  {\par\bigskip\vbox\bgroup
    % We entered internal vertical mode, and so we get \parshape=0.
    \leftskip=0pt \rightskip=0pt
    \advance\linewidth\@totalleftmargin
    \@totalleftmargin=0pt
  }
  {\egroup\nobreak}
  
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%                        ********************
%                        ** GRADING TABLES **
%                        ********************

\newcounter{@iterator}
\newlength\@cellwidth

\def\cellwidth#1{\@cellwidth=#1}
\def\gradetablestretch#1{\def\@gtblstretch{#1}}

% \settabletotalpoints allows the user to specify a total number of points to appear in a table that may be different from the sum of the points in the table:
\newcommand\prt@tablepoints{\prt@hlfcntr{tbl@points}}
\newcommand\settabletotalpoints[1]{%
  \def\prt@tablepoints{#1}%
}% \settabletotalpoints

% \settabletotalbonuspoints is similar to \settabletotalpoints:
\newcommand\prt@tablebonuspoints{\prt@hlfcntr{tbl@bonuspoints}}
\newcommand\settabletotalbonuspoints[1]{%
  \def\prt@tablebonuspoints{#1}%
}% \settabletotalbonuspoints

% All of the following that begin with `h' are for horizontal tables,
% and all of them that begin with `v' are for vertical tables:
\def\hqword#1{\def\@hqword{#1}}
\def\hpword#1{\def\@hpword{#1}}
\def\hsword#1{\def\@hsword{#1}}
\def\htword#1{\def\@htword{#1}}
\def\hpgword#1{\def\@hpgword{#1}}

\def\vqword#1{\def\@vqword{#1}}
\def\vpword#1{\def\@vpword{#1}}
\def\vsword#1{\def\@vsword{#1}}
\def\vtword#1{\def\@vtword{#1}}
\def\vpgword#1{\def\@vpgword{#1}}


% The following are the versions for bonusgradetable:
\def\bhqword#1{\def\@bhqword{#1}}
\def\bhpword#1{\def\@bhpword{#1}}
\def\bhsword#1{\def\@bhsword{#1}}
\def\bhtword#1{\def\@bhtword{#1}}
\def\bhpgword#1{\def\@bhpgword{#1}}

\def\bvqword#1{\def\@bvqword{#1}}
\def\bvpword#1{\def\@bvpword{#1}}
\def\bvsword#1{\def\@bvsword{#1}}
\def\bvtword#1{\def\@bvtword{#1}}
\def\bvpgword#1{\def\@bvpgword{#1}}

% The following are the versions for combinedgradetable:
\def\chqword#1{\def\@chqword{#1}}
\def\chpword#1{\def\@chpword{#1}}
\def\chbpword#1{\def\@chbpword{#1}}
\def\chsword#1{\def\@chsword{#1}}
\def\chtword#1{\def\@chtword{#1}}
\def\chpgword#1{\def\@chpgword{#1}}

\def\cvqword#1{\def\@cvqword{#1}}
\def\cvpword#1{\def\@cvpword{#1}}
\def\cvbpword#1{\def\@cvbpword{#1}}
\def\cvsword#1{\def\@cvsword{#1}}
\def\cvtword#1{\def\@cvtword{#1}}
\def\cvpgword#1{\def\@cvpgword{#1}}

%----------------------------- Initialize: ------------------------
\cellwidth{2em}
\gradetablestretch{1.5}

\hqword{Question:}
\hpgword{Page:}
\hpword{Points:}
\hsword{Score:}
\htword{Total}
\vpword{Points}
\vsword{Score}
\vtword{Total:}
\vqword{Question}
\vpgword{Page}

\bhqword{Question:}
\bhpgword{Page:}
\bhpword{Bonus Points:}
\bhsword{Score:}
\bhtword{Total}
\bvqword{Question}
\bvpgword{Page}
\bvpword{Bonus Points}
\bvsword{Score}
\bvtword{Total:}

\chqword{Question:}
\chpgword{Page:}
\chpword{Points:}
\chbpword{Bonus Points:}
\chsword{Score:}
\chtword{Total}
\cvqword{Question}
\cvpgword{Page}
\cvpword{Points}
\cvbpword{Bonus Points}
\cvsword{Score}
\cvtword{Total:}

% The possibilities are

%   \gradetable[v][questions]
%   \gradetable[v][pages]
%   \gradetable[h][questions]
%   \gradetable[h][pages]

%   \partialgradetable{whatever}[v][questions]
%   \partialgradetable{whatever}[v][pages]
%   \partialgradetable{whatever}[h][questions]
%   \partialgradetable{whatever}[h][pages]

%   \begingradingrange{whatever}
%   \endgradingrange{whatever}
%
%   \pointsinrange{whatever}
%   \bonuspointsinrange{whatever}
%
%    \firstqinrange{whatever}
%    \lastqinrange{whatever}
%    \numqinrange{whatever}
%
% where ``whatever'' is a label chosen by the user.
% 
% \def\multirowgradetable{numcols}[questions or pages]
%
% \def\multirowpartialgradetable{numcols}{rangename}[questions or pages]
%
% \def\multicolumngradetable{numrows}[questions or pages]
% 
% \def\multicolumnpartialgradetable{numrows}{rangename}[questions or pages]

% If one or both optional arguments are omitted, the defaults are `[v]' and `[questions]'.

% \@scorestrue means we're doing \gradetable
% \@scoresfalse mans we're doing \pointtable
\newif\if@scores

% \@partialtrue means we're doing \partialgradetable, \partialbonusgradetable, \partialcombinedgradetable, \partialpointtable, \partialbonuspointtable, or \partialcombinedpointtable:

\newif\if@partial

% \@combinedtrue means we're doing \combinedgradetable, \combinedpointtable, \partialcombinedgradetable, or \partialcombinedpointtable:

\newif\if@combined

% It's OK to use the counter num@cols as a scratch counter in \begingradingrange and \endgradingrange because it's only used in typesetting tables:

% \@cobttrue means we will print CO BT table.

\newif\if@cobt

\def\begingradingrange#1{%
  \setcounter{num@cols}{\value{question}}%
  \addtocounter{num@cols}{1}%
  \immediate\write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space range@#1@firstq\string\endcsname
      {\arabic{num@cols}}}%
  \write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space range@#1@firstp\string\endcsname
      {\thepage}}%
}% begingradingrange

\def\endgradingrange#1{%
  \setcounter{num@cols}{\value{question}}%
  \immediate\write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space range@#1@lastq\string\endcsname
      {\arabic{num@cols}}}%
  \write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space range@#1@lastp\string\endcsname
      {\thepage}}%
}% endgradingrange

% Now that grading tables may be for only part of the exam, we need the counter 'tbl@points' to add up the total points for the questions (or pages) that appear on the table:

\new@hlfcntr{tbl@points}

\new@hlfcntr{tbl@bonuspoints}

%--------------------------------------------------------------------
% multirow tables, non-partial:

\def\multirowgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowpointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowbonusgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowbonuspointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowcombinedgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowcombinedpointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

%--------------------------------------------------------------------
% multirow tables, partial:

\def\multirowpartialgradetable#1#2{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowpartialpointtable#1#2{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowpartialbonusgradetable#1#2{%
  \@cobtfalse
  \@scorestrue
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowpartialbonuspointtable#1#2{%
  \@cobtfalse
  \@scoresfalse
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowpartialcombinedgradetable#1#2{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#2}%
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

\def\multirowpartialcombinedpointtable#1#2{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#2}%
  \setcounter{num@rows}{#1}%
  \i@gtable[h]%
}

%--------------------------------------------------------------------
%  multicolumn tables, non-partial:

\def\multicolumngradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnpointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnbonusgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnbonuspointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumncombinedgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumncombinedpointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

%--------------------------------------------------------------------
% multicolumn tables, partial:

\def\multicolumnpartialgradetable#1#2{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnpartialpointtable#1#2{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnpartialbonusgradetable#1#2{%
  \@cobtfalse
  \@scorestrue
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnpartialbonuspointtable#1#2{%
  \@cobtfalse
  \@scoresfalse
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#2}%
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnpartialcombinedgradetable#1#2{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#2}%
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

\def\multicolumnpartialcombinedpointtable#1#2{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#2}%
  \setcounter{num@cols}{#1}%
  \i@gtable[v]%
}

%--------------------------------------------------------------------
% partial single row (and column) tables:

\def\partialgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  % We don't yet know if the table is vertical or horizontal, and so we don't know if we need to set num@cols or num@rows.  We'll set them both, and we'll later on just ignore the value of the one that we didn't need to set here:
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  % If the user doesn't include the optional argument choosing between vertical and horizontal, we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialgradetable

\def\partialbonusgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialbonusgradetable

\def\partialcombinedgradetable#1{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#1}%
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialcombinedgradetable

\def\partialpointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialpointtable

\def\partialbonuspointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialbonuspointtable

\def\partialcombinedpointtable#1{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#1}%
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialcombinedpointtable

%--------------------------------------------------------------------
% single row (and column) tables, non-partial:

\def\gradetable{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% gradetable

\def\bonusgradetable{%
  \@cobtfalse
  \@scorestrue
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonusgradetable

\def\combinedgradetable{%
  \@cobtfalse
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonusgradetable

\def\pointtable{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% pointtable

\def\bonuspointtable{%
  \@cobtfalse
  \@scoresfalse
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonuspointtable

\def\combinedpointtable{%
  \@cobtfalse
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonuspointtable

\def\cobttable{%
  \@cobttrue
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  \setcounter{num@cols}{1}%
  \setcounter{num@rows}{1}%
  \tbl@pgsfalse
  \hqword{COs\;\&\;BTs}
  \hpword{Marks:}
  \@scorestrue
  \i@gtable[h]%
}% cobttable
%--------------------------------------------------------------------

% \i@gtable and \ii@gtable insert any missing optional arguments (the defaults being [v] and [questions]) and then make sure that the user said \addpoints and that this isn't the first run of LaTeX.
% \find@p@or@q@range then branches, depending on whether the user selected [questions] or [pages].

\def\i@gtable[#1]{%
  % If the user doesn't include the second optional argument, which chooses between questions and pages, we give them questions:
  \@ifnextchar[{\ii@gtable{#1}}{\ii@gtable{#1}[questions]}%
}

\def\ii@gtable#1[#2]{%
  % We get here from \i@gtable.
  % We make sure the user said \addpoints, and then make sure that this isn't the first run of LaTeX (by checking that \exam@numpoints is defined).  If both of those are OK, we go to \find@p@or@q@range to see whether we're doing a table indexed by questions or by pages.
  \if@addpoints
    \@ifundefined{exam@numpoints}%
      {\ClassWarning{rvexam}%
        {%
          You must run LaTeX again to produce the table.\MessageBreak
        }%
        \fbox{Run \LaTeX{} again to produce the table}%
      }%
      {\find@p@or@q@range{#1}{#2}}%
  \else
    \ClassError{rvexam}{%
      You must give the command \protect\addpoints\MessageBreak
      \space\space in order to create a grade table.\MessageBreak
      }{%
      If you don't give the command \protect\addpoints\MessageBreak
      \space\space then we're not keeping track of point values.
      \MessageBreak
      }%
  \fi
}% ii@gtable

\def\@questionsref{questions}

\def\@pagesref{pages}

\def\find@p@or@q@range#1#2{%
  % We get here from \ii@gtable.
  % See whether we're doing a table indexed by questions (go to \find@qrange) or by pages (go to \find@prange):
  \begingroup
    % We've begun a group that will contain the construction of the table, to confine the effect of any \def's that we use.
    \def\exam@temp{#2}%
    \ifx\exam@temp\@questionsref
      \tbl@pgsfalse
      \find@qrange{#1}%
    \else
      \ifx\exam@temp\@pagesref
        \tbl@pgstrue
        \find@prange{#1}%
      \else
        \ClassError{rvexam}{%
          Grade and point tables can be indexed\MessageBreak
          \space\space by either `questions' or `pages',\MessageBreak
          \space\space but not by `#2'.\MessageBreak
        }{%
          Grade tables and point tables can be indexed by questions or
          pages;\MessageBreak
          \space\space for others, you're on your own.\MessageBreak
        }%
        \fbox{\textbf{Error:} grade or point table: Invalid argument
              `#2' must be `questions' or `pages'.}%
      \fi
    \fi
  \endgroup
}% find@p@or@q@range

% \range@undefined can be called from either \find@qrange or \find@prange
\def\range@undefined{%
  \fbox{Warning: grading range `\tbl@range ' not defined;
                               run \LaTeX{} again.}%
  \ClassWarning{rvexam}{%
    Grading range `\tbl@range' not defined.\MessageBreak
    \space\space Run LaTeX again to produce the table.\MessageBreak
  }%
}% range@undefined

%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Grade and point tables indexed by question numbers:

% When we get to \find@qrange, we know we're doing a table indexed by Q no.s and that this is not the first run of latex.  The argument is either ``v'' or ``h''.
%%  If we're not doing a partial table, then \find@qrange sets \tbl@firstq and \first@pq@index to 1 and \tbl@lastq and \last@pq@index to \numquestions.
%%  Otherwise, \find@qrange makes sure the grading range is defined and that its last question isn't before its first question.  \find@qrange then calls \tbl@v@or@h, passing along the argument that is either ``v'' or ``h''.

\def\find@qrange#1{%
  % We get here from \find@p@or@q@range.
  % We're doing a table indexed by question numbers.
  \if@partial
    \@ifundefined{range@\tbl@range @firstq}%
      {%
        \range@undefined
      }%
      {%
        \@ifundefined{range@\tbl@range @lastq}%
          {%
            \range@undefined
          }%
          {%
            \edef\tbl@firstq{\csname range@\tbl@range @firstq\endcsname}% range@\tbl@range @firstp is set by '\firstqinrang'
            \edef\tbl@lastq{\csname range@\tbl@range @lastq\endcsname}%
            \let\first@pq@index=\tbl@firstq
            \let\last@pq@index=\tbl@lastq
            % Check that firstq precedes or equals lastq:
            \ifnum \tbl@firstq > \tbl@lastq\relax
              \fbox{\textbf{Error:} Grading Range `\tbl@range':
                      Last question precedes first question.}%
              \ClassError{rvexam}{%
                In grading range `\tbl@range',
                                the last question\MessageBreak
                \space\space comes before the first question.\MessageBreak
                }{%
                  \string\begingradingrange \space must precede
                  \string\endgradingrange \space by at
                             least one question.\MessageBreak
                }%
            \else
              \tbl@v@or@h{#1}%
            \fi
          }%
      }%
  \else
    \def\tbl@firstq{1}%
    \let\first@pq@index=\tbl@firstq
    % \numquestions is always defined, even if this is the first run of LaTeX and \exam@numquestions isn't defined.
    \if@cobt
      \setcounter{temp@cos}{\value{num@cos}}
      \addtocounter{temp@cos}{\value{num@bts}}
      \addtocounter{temp@cos}{-1}% adjusted to get Total column
      \def\tbl@lastq{\thetemp@cos}%
    \else	
      \def\tbl@lastq{\numquestions}%
	  \fi  
    \let\last@pq@index=\tbl@lastq
    \tbl@v@or@h{#1}%
  \fi
}% find@qrange

\def\@vref{v}
\def\@href{h}

\def\tbl@v@or@h#1{%
  % \first@pq@index=\tbl@firstq or \tbl@firstp and \last@pq@index=\tbl@lastq or \tbl@lastp have already been set.
  % The argument should be either `v' or `h', and we branch accordingly.
  \def\exam@temp{#1}%
  \ifx\exam@temp\@vref
    \check@num@cols@v
  \else
    \ifx\exam@temp\@href
      \check@num@rows@h
    \else
      \ClassError{rvexam}{%
        Grade or point table: the argument `#1'\MessageBreak
        \space\space must be `v' or `h'.
        \MessageBreak
      }{%
        Grade tables and point tables can be either vertical or
        horizontal;\MessageBreak
        \space\space no diagonals allowed.\MessageBreak
      }%
      \fbox{\textbf{Error:} grade or point table: Invalid argument
            `#1' must be `v' or `h'.}%
    \fi
  \fi
}% tbl@v@or@h

%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Grade and point tables indexed by page numbers:

% The only pages listed are those on which there are a nonzero no. of pts. We check pages \tbl@firstp through \tbl@lastp Once we've checked that, e.g., \lastpage@withpoints and \pointsonpage@\romannumeral{\lastpage@withpoints} are defined, we can safely (we think) check \pointsonpage@\romannumeral{n} for all n between \tbl@firstp and \tbl@lastp without generating errors.
%
% Actually: Since we added the notion of half points and half counters, there won't be any errors even if \pointsonpage@\romannumeral{n} isn't defined, since it's tested by the lines:
%   \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
%                          \csname c@@iterator\endcsname\endcsname}%
%   \ifhlfcntr@pos{tmp@hlfcntr}%
% and if 
%   \csname pointsonpage@\romannumeral
%             \csname c@@iterator\endcsname\endcsname
% isn't defined, tmp@hlfcntr gets the value zero (because of the way that \set@hlfcntr is written).

% \find@prange makes sure the grading range is defined and that its last page isn't before its first page (if it's a partial table).  In any case, it then sets \tbl@firstp and \tbl@lastp, and calls \check@secondrun.

\def\find@prange#1{% The argument is either ``v'' or ``h''.
  % We get here from \find@p@or@q@range.
  %
  % We first determine the first and last page of the range, storing those in \first@pq@index=\tbl@firstp and \last@pq@index=\tbl@lastp. 
  % If not a partial table, we set \first@pq@index=\tbl@firstp to 1 and \last@pq@index=\tbl@lastp to the last page with the appropriate points (and so if it's a combined table, it's the last page to have either bonus or non-bonus points).
  % We then call \check@secondrun, passing it the argument that we received (i.e., we say \check@secondrun{#1}) to make sure  we've done at least two runs of latex (so that we'll have the information we need about which pages have points on them).
  %
  \if@partial
    \@ifundefined{range@\tbl@range @firstp}%
      {%
        \range@undefined
      }%
      {%
        \@ifundefined{range@\tbl@range @lastp}%
          {%
            \range@undefined
          }%
          {%
            \edef\tbl@firstp{\csname range@\tbl@range @firstp\endcsname}%  range@\tbl@range @firstp is set by '\firstqinrang'
            \edef\tbl@lastp{\csname range@\tbl@range @lastp\endcsname}%
            \let\first@pq@index=\tbl@firstp
            \let\last@pq@index=\tbl@lastp
            % Check that firstp precedes or equals lastp:
            \ifnum \tbl@firstp > \tbl@lastp\relax
              \fbox{\textbf{Error:} Grading Range `\tbl@range ':
                      Last page precedes first page.}%
              \ClassError{rvexam}{%
                In grading range `\tbl@range', the last page\MessageBreak
                \space\space comes before the first page.\MessageBreak
                }{%
                  \string\begingradingrange \space must precede
                  \string\endgradingrange.\MessageBreak
                }%
            \else
              \check@secondrun{#1}%
            \fi
          }%
      }%
  \else
    % It's not a partial table:
    \def\tbl@firstp{1}%
    \let\first@pq@index=\tbl@firstp
    % We never get here on the first run of LaTeX, and \lastpage@withbonuspoints is defined on the second and later runs.
    \def\tbl@lastp{\lastpage@withpoints}%
    \let\last@pq@index=\tbl@lastp
    \if@bonus
      \def\tbl@lastp{\lastpage@withbonuspoints}%
      \let\last@pq@index=\tbl@lastp
    \fi
    \if@combined
      \ifnum \lastpage@withbonuspoints > \lastpage@withpoints\relax
        \def\tbl@lastp{\lastpage@withbonuspoints}%
        \let\last@pq@index=\tbl@lastp
      \fi        
    \fi
    \check@secondrun{#1}%
  \fi
}% find@prange

\def\check@secondrun#1{%
  % The function \ii@gtable already made sure that this isn't the first run of latex.  To do a table indexed by pages, though, we have to also make sure it's not the second run of latex.
  % We get here from \find@prange; the argument is either ``v'' or ``h''.
  % Check that there's enough info from the .aux file to do a page indexed grade table.  If so, call \tbl@v@or@h{#1}:
  \@ifundefined{pointsonpage@\romannumeral
               \csname lastpage@withpoints\endcsname}%
    {\@ifundefined{bonuspointsonpage@\romannumeral
               \csname lastpage@withbonuspoints\endcsname}%
        {\ClassWarning{rvexam}{%
           You must run LaTeX again to produce the table.\MessageBreak}%
           \fbox{Run \LaTeX{} again to produce the table}%
        }%
        {\tbl@v@or@h{#1}%
        }%
    }%
    {\tbl@v@or@h{#1}%
    }%
}% check@secondrun

%--------------------------------------------------------------------
% Indexed by pages:

% For a table indexed by pages, we need to know how many pages there are with points on them.  The argument to \count@pgswpts should be the name of a counter; we set that counter equal to the number of pages with the appropriate kind of points.

\def\count@pgswpts#1{%
  % Set the counter #1 equal to the number of pages in the range with the appropriate type of points.
  % We're called by \@computenumcols@h and \@computenumrows@v.
  \setcounter{#1}{0}%
  \setcounter{@iterator}{\tbl@firstp}%
  \addtocounter{@iterator}{-1}%
  \if@bonus
    \docount@pgswbpts{#1}%
  \else
    \if@combined
      \docount@pgswcpts{#1}%
    \else
      \docount@pgswpts{#1}%
    \fi
  \fi
}% count@pgswpts

\def\docount@pgswcpts#1{%
  % Called by \count@pgswpts
  % Count the number of pages in range with any kind of point (bonus or non-bonus):
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{#1}{1}%
  \else
    \check@bnsptpage{#1}%
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \def\nextdocount@pgswcpts{\docount@pgswcpts{#1}}%
  \else
    \let\nextdocount@pgswcpts=\relax
  \fi
  \nextdocount@pgswcpts
}% docount@pgswcpts

\def\check@bnsptpage#1{%
  % We need to hide this inside of a macro because if \ifhlfcntr@pos isn't expanded (because this stuff is being skipped in the outer conditional), then TeX doesn't see the \ifnum hidden inside the \ifhlfcntr@pos, but it does see the \fi, and so it get confused.
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{#1}{1}%
  \fi
}% check@bnsptpage

\def\docount@pgswpts#1{%
  % Called by \count@pgswpts.
  % Count the number of pages in range with regular points.
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{#1}{1}%
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \def\nextdocount@pgswpts{\docount@pgswpts{#1}}%
  \else
    \let\nextdocount@pgswpts=\relax
  \fi
  \nextdocount@pgswpts
}% docount@pgswpts

\def\docount@pgswbpts#1{%
  % Called by \count@pgswpts
  % Count the number of pages in range with bonus points.
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{#1}{1}%
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \def\nextdocount@pgswbpts{\docount@pgswbpts{#1}}%
  \else
    \let\nextdocount@pgswbpts=\relax
  \fi
  \nextdocount@pgswbpts
}% docount@pgswbpts

%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Multirow horizontal tables, indexed by question numbers:

\newcounter{pq@index}
% In tables indexed by page numbers, it holds a page number. In tables indexed by question numbers, it holds a question number.

\newcounter{pq@index@pts}
% In h tables, this holds either the ct pg no or the ct q no. as we put the pt values for that pg or q no into the table.
% In v tables, this holds the index for the first column of the current row.

\newcounter{pq@index@bpts}
% used to set bonus point values in h tables.  Often used as scratch elsewhere.

\def\hidden@ampersand{&}
% Needed because an ampersand can't appear in the replacement text of a conditional.

\newif\iftbl@pgs
% \tbl@pgstrue means a table indexed by page numbers; \tbl@pgsfalse means a table indexed by question numbers

\newcounter{num@cols}
\newcounter{num@rows}
\newcounter{current@row}

\newcounter{cols@done}
% Holds the number of columns done in the current row.

%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Stuff to unify tables indexed by questions and tables indexed by pages:

% \first@pq@index and \last@pq@index will hold either \tbl@firstq and \tbl@lastq or \tbl@firstp and \tbl@lastp.

\def\increment@index#1{%
  % If we're doing a table indexed by question numbers, we increment the counter #1.
  % If we're doing a table indexed by page numbers, we increase the counter #1 by at least 1 to either number the next pg. containing the appropriate kind of points, or to something greater than \tbl@lastp.
  \iftbl@pgs
    \find@nextpagewithpoints{#1}%
  \else
    \addtocounter{#1}{1}%
  \fi
}% increment@index

\def\nextcolumn@index@v#1{% Used only for multicolumn tables.
  % If we're doing a table indexed by question numbers, we increase the counter #1 by num@cols.
  % If we're doing a table indexed by page numbers, we use \find@nextcolumnpage@v to increment the counter #1 to either the (num@rows)'th page number after #1 that contains the appropriate kind of points or to a value greater than \tbl@lastp.
  \iftbl@pgs
    \find@nextcolumnpage@v{#1}%
  \else
    \addtocounter{#1}{\value{num@rows}}%
  \fi
}% nextcolumn@index@v

\def\pointsof@index#1{%
  \iftbl@pgs
    \pointsonpage{\arabic{#1}}%
  \else
    \pointsofquestion{\arabic{#1}}%
  \fi
}% pointsof@index

\def\bonuspointsof@index#1{%
  \iftbl@pgs
    \bonuspointsonpage{\arabic{#1}}%
  \else
    \bonuspointsofquestion{\arabic{#1}}%
  \fi
}% bonuspointsof@index

\def\refto@index#1{%
  \iftbl@pgs
    \if@combined
      % Need to hide this inside of a macro:
      \refto@comb@index{#1}%
    \else
      \if@bonus
        \pageref{firstbonuspoints@onpage@\arabic{#1}}%
      \else
        \pageref{firstpoints@onpage@\arabic{#1}}%
      \fi
    \fi
  \else
    \ref{question@\arabic{#1}}%
  \fi
}% refto@index

\def\refto@comb@index#1{%
  % We're called only by \refto@index.
  % We can't have the \ifhlfcntr@pos...\fi inside of another conditional, so we're hiding it in this macro.
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\arabic{#1}}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pageref{firstpoints@onpage@\arabic{#1}}%
  \else
    % In theory, there *must* be bonus points on this page, because there aren't any plain points, but there are allegedly *some* points. We're being brave and assuming that's correct, and not checking (which we'd have to hide inside a macro, because it would use \ifhlfcntr@pos):
    \pageref{firstbonuspoints@onpage@\arabic{#1}}%
  \fi
}% refto@comb@index

%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Multirow tables:

%--------------------------------------------------------------------
% Check that the number of rows is OK, and compute the number of columns:

\def\check@num@rows@h{%
  % We get here from \tbl@v@or@h.
  % We make sure the number of rows is a positive integer.  If it is, we go on to \@computenumcols@h
  \ifnum \value{num@rows} < 1\relax
    \ClassError{rvexam}{%
      The number of rows in a table must be positive.\MessageBreak
    }{%
      The number of rows must be a positive integer.\MessageBreak
    }%
    \fbox{\textbf{Error:} Multirow table with no rows!}%
  \else
    \@computenumcols@h
  \fi
}% check@num@rows@h

\def\@computenumcols@h{%
  % We get here from \check@num@rows@h.
  % Compute the number of columns. First: set num@cols to one more than either (the number of pages with the appropriate type of points) or (the number of questions), to have slots for the total along with the questions:
  \if@cobt
    \setcounter{num@cols}{\value{num@cos}}%
    \addtocounter{num@cols}{\value{num@bts}}%
  \else  
    \iftbl@pgs
      \count@pgswpts{num@cols}%
      \addtocounter{num@cols}{1}%
    \else
      \setcounter{num@cols}{\tbl@lastq}%
      \addtocounter{num@cols}{-\tbl@firstq}%
      \addtocounter{num@cols}{2}%
    \fi
  \fi
  % Save the number of slots needed in pq@index (used for scratch), to check for truncation:
  \setcounter{pq@index}{\value{num@cols}}%
  % Divide the number of slots needed by num@rows:
  \divide \csname c@num@cols\endcsname by
    \csname c@num@rows\endcsname
  % Division truncates: See if there was truncation. Use @iterator as a scratch counter.
  \setcounter{@iterator}{\value{num@cols}}%
  \multiply \csname c@@iterator\endcsname by
    \csname c@num@rows\endcsname
  \ifnum \value{@iterator} < \value{pq@index}\relax
    % There was truncation; add a column to num@cols:
    \addtocounter{num@cols}{1}%
  \fi
  \@multirowtable
}% @computenumcols@h

%--------------------------------------------------------------------
% Construct the actual table:

\def\@multirowtable{%
  % We get here from \@computenumcols@h.
  \renewcommand\arraystretch{\@gtblstretch}%
  \set@hlfcntr{tbl@points}{0}%
  \set@hlfcntr{tbl@bonuspoints}{0}%
  \setcounter{pq@index}{\first@pq@index}%
  \addtocounter{pq@index}{-1}%
  \setcounter{pq@index@pts}{\value{pq@index}}%
  \setcounter{pq@index@bpts}{\value{pq@index}}%
  \setcounter{current@row}{0}%
  \begin{tabular}{|l|*{\value{num@cols}}{c|}}
    \hline
    \if@combined
      \do@comblines@h
    \else
      \do@lines@h
    \fi
}% @multirowtable


\def\do@lines@h{%
  % Called only by \@multirowtable.
  % It's either bonus or regular, but not combined:
  \addtocounter{current@row}{1}% Set to the number of the current row
  \iftbl@pgs
    \if@bonus
      \@bhpgword
    \else
      \@hpgword
    \fi
  \else
    \if@bonus
      \@bhqword
    \else
      \@hqword
    \fi
  \fi
  \setcounter{cols@done}{0}%
  \do@pq@indexloop@h
  % When we finish \do@pq@indexloop@h, either we've finished a complete row of page numbers (or questions), or we've done all the page numbers (or questions) through \last@pq@index, or both:
  \ifnum \value{cols@done} < \value{num@cols}\relax
    % We've inserted all the page or question numbers, and there's room remaining on the current line for \@htword (or \@bhtword):
    \ifnum \value{current@row} = \value{num@rows}\relax
      % This is the last row; put in the total:
      \do@htword@h
    \else
      % This isn't the last row.  We insert (\value{num@cols} - \value{cols@done}) ampersands.
      \setcounter{@iterator}{\value{num@cols}}%
      \addtocounter{@iterator}{-\value{cols@done}}%
      \do@emptycols@h
    \fi
  \fi
  \\
  \hline
  % Point values go here!
  \setcounter{cols@done}{0}%
  \if@bonus
    \@bhpword
    \do@bptloop@h
  \else
    \@hpword
    \do@ptloop@h
  \fi
  % When we finish \do@ptloop@h or \do@bptloop@h, either we've finished a complete row of point values, or we've done all the question (or page) numbers through \last@pq@index, or both:  
  \ifnum \value{cols@done} < \value{num@cols}\relax
    % We've inserted all the point values, and there's room remaining on the current line for Total Points:
    \ifnum \value{current@row} = \value{num@rows}\relax
      % This is the last row; put in the total:
      \if@bonus
        \do@totalbpts@h
      \else
        \do@totalpts@h
      \fi
    \else
      % This isn't the last row.  We insert (\value{num@cols} - \value{cols@done}) ampersands.
      \setcounter{@iterator}{\value{num@cols}}%
      \addtocounter{@iterator}{-\value{cols@done}}%
      \do@emptycols@h
    \fi
  \fi
  % We hold off on putting in the "\\ \hline" because we may want to immediately follow it with either an "\end{tabular}" or another "\hline".
  % Scores?
  \if@scores
    \\
    \hline
    \if@bonus
      \@bhsword \hidden@ampersand
    \else
      \@hsword \hidden@ampersand
    \fi
    \setcounter{cols@done}{0}%
    \do@sloop@h
  \fi
  \ifnum \value{current@row} = \value{num@rows}\relax
    % This is the last line!  End the tabular:
    \\
    \hline
    \end{tabular}%
  \else
    % Don't end the tabular:
    \\
    \hline\hline
  \fi
  % Check if we should repeat:
  \ifnum \value{current@row} < \value{num@rows}\relax
    \let\nextdo@lines@h=\do@lines@h
  \else
    \let\nextdo@lines@h=\relax
  \fi
  \nextdo@lines@h
}% do@lines@h

\def\do@comblines@h{%
  % Called only by \@multirowtable.
  % Combined tables.
  \addtocounter{current@row}{1}% Set to the number of the current row
  \iftbl@pgs
    \@chpgword
  \else
    \@chqword
  \fi
  \setcounter{cols@done}{0}%
  \do@pq@indexloop@h
  % When we finish \do@pq@indexloop@h, either we've finished a complete row of page (or question) numbers, or we've done all the page (or question) numbers through \last@pq@index, or both: 
  \ifnum \value{cols@done} < \value{num@cols}\relax
    % We've inserted all the question (or page) numbers, and there's room remaining on the current line for \@chtword:
    \ifnum \value{current@row} = \value{num@rows}\relax
      % This is the last row; put in the total:
      \do@htword@h
    \else
      % This isn't the last row.  We insert (\value{num@cols} - \value{cols@done}) ampersands.
      \setcounter{@iterator}{\value{num@cols}}%
      \addtocounter{@iterator}{-\value{cols@done}}%
      \do@emptycols@h
    \fi
  \fi
  \\
  \hline
  % Point values go here!
  \@chpword
  \setcounter{cols@done}{0}%
  \do@ptloop@h
  % When we finish \do@ptloop@h, either we've finished a complete row of point values, or we've done all the question (or page) numbers through \last@pq@index, or both:   
  \ifnum \value{cols@done} < \value{num@cols}\relax
    % We've inserted all the point values, and there's room remaining on the current line for Total Points:
    \ifnum \value{current@row} = \value{num@rows}\relax
      % This is the last row; put in the total:
      \do@totalpts@h
    \else
      % This isn't the last row.  We insert (\value{num@cols} - \value{cols@done}) ampersands.
      \setcounter{@iterator}{\value{num@cols}}%
      \addtocounter{@iterator}{-\value{cols@done}}%
      \do@emptycols@h
    \fi
  \fi
  \\
  \hline
  % Bonus point values go here!
  \@chbpword
  \setcounter{cols@done}{0}%
  \do@bptloop@h
  \ifnum \value{cols@done} < \value{num@cols}\relax
    \ifnum \value{current@row} = \value{num@rows}\relax
      % This is the last row; put in the total:
      \do@totalbpts@h
    \else
      \setcounter{@iterator}{\value{num@cols}}%
      \addtocounter{@iterator}{-\value{cols@done}}%
      \do@emptycols@h
    \fi
  \fi
  \if@scores
    \\
    \hline
    \@chsword \hidden@ampersand
    \setcounter{cols@done}{0}%
    \do@sloop@h
  \fi
  \ifnum \value{current@row} = \value{num@rows}\relax
    % This is the last line!  End the tabular:
    \\
    \hline
    \end{tabular}%
  \else
    % Don't end the tabular:
    \\
    \hline\hline
  \fi
  % Check if we should repeat:
  \ifnum \value{current@row} < \value{num@rows}\relax
    \let\nextdo@comblines@h=\do@comblines@h
  \else
    \let\nextdo@comblines@h=\relax
  \fi
  \nextdo@comblines@h
}% do@comblines@h

\newcounter{temp@col}
\setcounter{temp@col}{0}

\def\do@pq@indexloop@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We insert at most one row of pq@index:
  \increment@index{pq@index}%
  \ifnum \value{pq@index} > \last@pq@index\relax
    % Do nothing!
  \else
    \hidden@ampersand
    \if@cobt
	    \addtocounter{cols@done}{1}%
      \ifnum \value{cols@done} < \value{num@cos}\relax
        CO\thecols@done
      \else
	      \setcounter{temp@col}{\value{cols@done}}%
		    \addtocounter{temp@col}{-\value{num@cos}}%
		    \addtocounter{temp@col}{1}%
        L\thetemp@col
      \fi
    \else	
      \refto@index{pq@index}%
      \addtocounter{cols@done}{1}%
	  \fi    
  \fi
  \ifnum \value{pq@index} < \last@pq@index\relax
    \ifnum \value{cols@done} < \value{num@cols}\relax
      \let\nextdo@pq@indexloop@h=\do@pq@indexloop@h
    \else
      \let\nextdo@pq@indexloop@h=\relax
    \fi
  \else
    \let\nextdo@pq@indexloop@h=\relax
  \fi
  \nextdo@pq@indexloop@h
}% do@pq@indexloop@h

\def\do@ptloop@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We insert at most one row of non-bonus point values:
  \increment@index{pq@index@pts}%
  \ifnum \value{pq@index@pts} > \last@pq@index\relax
    % Do nothing!
  \else
    \hidden@ampersand
    \addtocounter{cols@done}{1}%
    \if@cobt
      \ifnum \value{cols@done} < \value{num@cos}\relax
        \the\value{co@\thecols@done}%
        \addto@hlfcntr{tbl@points}{\the\value{co@\thecols@done}}%
      \else
    	  \setcounter{temp@col}{\value{cols@done}}%
        \addtocounter{temp@col}{-\value{num@cos}}%
        \addtocounter{temp@col}{1}%
        \the\value{bt@\thetemp@col}%
      \fi
    \else	
      \pointsof@index{pq@index@pts}%
      \addto@hlfcntr{tbl@points}{\pointsof@index{pq@index@pts}}%
    \fi
  \fi
  \ifnum \value{pq@index@pts} < \last@pq@index\relax
    \ifnum \value{cols@done} < \value{num@cols}\relax
      \let\nextdo@ptloop@h=\do@ptloop@h
    \else
      \let\nextdo@ptloop@h=\relax
    \fi
  \else
    \let\nextdo@ptloop@h=\relax
  \fi
  \nextdo@ptloop@h
}% do@ptloop@h

\def\do@bptloop@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We insert at most one row of bonus point values:
  \increment@index{pq@index@bpts}%
  \ifnum \value{pq@index@bpts} > \last@pq@index\relax
    % Do nothing!
  \else
    \hidden@ampersand
    \addtocounter{cols@done}{1}%
    \bonuspointsof@index{pq@index@bpts}%
    \addto@hlfcntr{tbl@bonuspoints}{\bonuspointsof@index{pq@index@bpts}}%
  \fi
  \ifnum \value{pq@index@bpts} < \last@pq@index\relax
    \ifnum \value{cols@done} < \value{num@cols}\relax
      \let\nextdo@bptloop@h=\do@bptloop@h
    \else
      \let\nextdo@bptloop@h=\relax
    \fi
  \else
    \let\nextdo@bptloop@h=\relax
  \fi
  \nextdo@bptloop@h
}% do@bptloop@h

\def\do@htword@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We insert (\value{num@cols} - \value{cols@done}) ampersands, and then either \@htword or \@bhtword or \@chtword:
  \setcounter{@iterator}{\value{num@cols}}%
  \addtocounter{@iterator}{-\value{cols@done}}%
  \do@emptycols@h
  \if@combined
    \@chtword
  \else
    \if@bonus
      \@bhtword
    \else
      \@htword
    \fi
  \fi
}% do@htword@h

\def\do@totalpts@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We insert (\value{num@cols} - \value{cols@done}) ampersands and then the total points:
  \setcounter{@iterator}{\value{num@cols}}%
  \addtocounter{@iterator}{-\value{cols@done}}%
  \do@emptycols@h
  \prt@tablepoints
}% do@totalpts@h

\def\do@totalbpts@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We insert (\value{num@cols} - \value{cols@done}) ampersands,
  % and then the total bonus points:
  \setcounter{@iterator}{\value{num@cols}}%
  \addtocounter{@iterator}{-\value{cols@done}}%
  \do@emptycols@h
  \prt@tablebonuspoints
}% do@totalbpts@h

\def\do@emptycols@h{%
  % Called by \do@lines@h, \do@comblines@h, \do@htword@h, \do@totalpts@h, and \do@totalbpts@h.
  % We insert \value{@iterator} ampersands:
  \ifnum \value{@iterator} > 0\relax
    \hidden@ampersand
    \addtocounter{@iterator}{-1}%
    \let\nextdo@emptycols@h=\do@emptycols@h
  \else
    \let\nextdo@emptycols@h=\relax
  \fi
  \nextdo@emptycols@h
}% do@emptycols@h

\def\do@sloop@h{%
  % Called by both \do@lines@h and \do@comblines@h.
  % We assume that cols@done has been set to zero.
  % We insert num@cols \hbox to \@cellwidth, separated by ampersands.
  \addtocounter{cols@done}{1}%
  \hbox to \@cellwidth{\hfill}%
  \ifnum \value{cols@done} < \value{num@cols}\relax
    \hidden@ampersand
    \let\nextdo@sloop@h=\do@sloop@h
  \else
    \let\nextdo@sloop@h=\relax
  \fi
  \nextdo@sloop@h
}% do@sloop@h


%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Multicolumn tables

%--------------------------------------------------------------------
% Here's an example of a multicolumn grade table indexed by questions.

% Every line of \cline's is followed by a \noalign{\vskip\arrayrulewidth} to cancel the \noalign{\vskip-\arrayrulewidth} that ends the definition of \cline.

% \begin{tabular}{*2{|c|c|c|c}}
%   \cline{1-3} \cline{5-7}
%   \noalign{\vskip\arrayrulewidth}
%   Question%
%   & Points%
%   & Score%
%   & \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
%   & Question%
%   & Points%
%   & Score%
%   \\
%   \cline{1-3} \cline{5-7}
%   \noalign{\vskip\arrayrulewidth}
%   1%
%   & 5%
%   & \hbox to \@cellwidth{\hfill}%
%   & \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
%   & 4%
%   & 20%
%   & \hbox to \@cellwidth{\hfill}%
%   \\
%   \cline{1-3} \cline{5-7}
%   \noalign{\vskip\arrayrulewidth}
%   2%
%   & 10%
%   & \hbox to \@cellwidth{\hfill}%
%   & \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
%   & 5%
%   & 25%
%   & \hbox to \@cellwidth{\hfill}%
%   \\
%   \cline{1-3} \cline{5-7}
%   \noalign{\vskip\arrayrulewidth}
%   3%
%   & 15%
%   & \hbox to \@cellwidth{\hfill}%
%   & \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
%   & Total:%
%   & 75%
%   & \hbox to \@cellwidth{\hfill}%
%   \\
%   \cline{1-3} \cline{5-7}
%   \noalign{\vskip\arrayrulewidth}
% \end{tabular}
%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Check that the number of cols is OK, and compute the number of rows:

\def\check@num@cols@v{%
  % We get here from \tbl@v@or@h.
  % We make sure the number of cols is between 1 and 10 (since we can't handle more than 10 cols in a multicolumn table). If it is, we go on to \@computenumrows@v
  \ifnum \value{num@cols} < 1\relax
    \ClassError{rvexam}{%
      The number of columns in a table must be positive.\MessageBreak
    }{%
      The number of columns must be a positive integer.\MessageBreak
    }%
    \fbox{\textbf{Error:} Multicolumn table with no columns!}%
  \else
    \ifnum \value{num@cols} > 10\relax
      \ClassError{rvexam}{%
        Multicolumn tables can have at most 10 columns.\MessageBreak
      }{%
        Multicolumn tables can have at most 10 columns.\MessageBreak
      }%
      \fbox{\textbf{Error:} Multicolumn table with more than 10 columns!}%
    \else
      \@computenumrows@v
    \fi
  \fi
}% check@num@cols@v

\def\@computenumrows@v{%% Compute the number of rows.
  % We get here from \check@num@cols@v.
  % First: set num@rows to one more than the number of either (questions) or (pages with the appropriate type of points), to have slots for the total along with the questions or page numbers:
  \iftbl@pgs
    \count@pgswpts{num@rows}%
    \addtocounter{num@rows}{1}%
  \else
    \setcounter{num@rows}{\last@pq@index}%
    \addtocounter{num@rows}{-\first@pq@index}%
    \addtocounter{num@rows}{2}%
  \fi
  % Save the number of slots needed, using pq@index@bpts as a scratch counter, to check for truncation on division:
  \setcounter{pq@index@bpts}{\value{num@rows}}%
  % Divide the number of slots needed by num@cols:
  \divide \csname c@num@rows\endcsname by
    \csname c@num@cols\endcsname
  % Division truncates: See if there was truncation.
  % Use the counter @iterator as a scratch counter:
  \setcounter{@iterator}{\value{num@rows}}%
  \multiply \csname c@@iterator\endcsname by
    \csname c@num@cols\endcsname
  \ifnum \value{@iterator} < \value{pq@index@bpts}\relax
    % There was truncation; add one to num@rows:
    \addtocounter{num@rows}{1}%
  \fi
  \@multicolumntable
}% @computenumrows@v

%--------------------------------------------------------------------
% Construct the actual table:

\def\@multicolumntable{%
  % We get here from \@computenumrows@v.
  % Set \cline@stuff@v equal to the line of \cline's:
  \create@cline@stuff@v
  \renewcommand\arraystretch{\@gtblstretch}%
  \set@hlfcntr{tbl@points}{0}%
  \set@hlfcntr{tbl@bonuspoints}{0}%
  \if@combined
    \if@scores
      \begin{tabular}{*{\value{num@cols}}{|c|c|c|c|c}}
      % We need to make sure that the \cline@stuff@v commands come *immediately* following the \\ or \begin{tabular} (with no conditionals evaluated, even if those conditionals expand to the empty string)! 
      % Put in the row of column headings, with \cline@stuff@v above and below:
      \cline@stuff@v  
      \setcounter{@iterator}{0}%
      \docolumn@heads@comb@v
      \\
      \cline@stuff@v
    \else
      % combinedpointtable, possibly partial. 
      \begin{tabular}{*{\value{num@cols}}{|c|c|c|c}}
      \cline@stuff@v  
      \setcounter{@iterator}{0}%
      \docolumn@heads@comb@noscores@v
      \\
      \cline@stuff@v
    \fi
    % pq@index@pts will hold the question number (or page number) in the first column of the row. 
    \setcounter{pq@index@pts}{\first@pq@index}%
    \iftbl@pgs
      % If we're indexed by pages, we need to make sure there are points of the appropriate type on the first page listed:
      \addtocounter{pq@index@pts}{-1}%
      \find@nextpagewithpoints{pq@index@pts}%
    \fi
    \setcounter{current@row}{0}%
    \do@lines@v
  \else
    % It's not combined:
    \if@scores
      \begin{tabular}{*{\value{num@cols}}{|c|c|c|c}}
      \cline@stuff@v  
      \setcounter{@iterator}{0}%
      \docolumn@heads@v
      \\
      \cline@stuff@v
    \else 
      \begin{tabular}{*{\value{num@cols}}{|c|c|c}}
      \cline@stuff@v  
      \setcounter{@iterator}{0}%
      \docolumn@heads@noscores@v
      \\
      \cline@stuff@v
    \fi
    % pq@index@pts will hold the question number (or page number) in the first column of the row. 
    \setcounter{pq@index@pts}{\first@pq@index}%
    \iftbl@pgs
      \addtocounter{pq@index@pts}{-1}%
      \find@nextpagewithpoints{pq@index@pts}%
    \fi
    \setcounter{current@row}{0}%
    \do@lines@v
  \fi
}% @multicolumntable

%--------------------------------------------------------------------
% \create@cline@stuff@v

% The function \create@cline@stuff@v defines \cline@stuff@v to be whatever's appropriate given the values of num@cols, \if@bonus, \if@combined, and \if@scores.

% We wimped out of generating \cline@stuff@v on the fly because we didn't see how to get the correct expansions/nonexpansions without using a primitive of e-TeX.

% \clines@ii@whatever is for tables in which a  logical column consists of two columns; it's used for pointtable and bonuspointtable.

\def\clines@ii@i{\cline{1-2}}
\def\clines@ii@ii{\cline{1-2} \cline{4-5}}
\def\clines@ii@iii{\cline{1-2} \cline{4-5} \cline{7-8}}
\def\clines@ii@iv{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}}
\def\clines@ii@v{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}
  \cline{13-14}}
\def\clines@ii@vi{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}
  \cline{13-14} \cline{16-17}}
\def\clines@ii@vii{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}
  \cline{13-14} \cline{16-17} \cline{19-20}}
\def\clines@ii@viii{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}
  \cline{13-14} \cline{16-17} \cline{19-20} \cline{22-23}}
\def\clines@ii@vix{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}
  \cline{13-14} \cline{16-17} \cline{19-20} \cline{22-23}
  \cline{25-26}}
\def\clines@ii@x{\cline{1-2} \cline{4-5} \cline{7-8} \cline{10-11}
  \cline{13-14} \cline{16-17} \cline{19-20} \cline{22-23}
  \cline{25-26} \cline{28-29}}

% \clines@iii@whatever is for tables in which a  logical column consists of three columns; it's are used for gradetable, bonusgradetable, and combinedpointtable:

\def\clines@iii@i{\cline{1-3}}
\def\clines@iii@ii{\cline{1-3} \cline{5-7}}
\def\clines@iii@iii{\cline{1-3} \cline{5-7} \cline{9-11}}
\def\clines@iii@iv{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}}
\def\clines@iii@v{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}
  \cline{17-19}}
\def\clines@iii@vi{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}
  \cline{17-19} \cline{21-23}}
\def\clines@iii@vii{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}
  \cline{17-19} \cline{21-23} \cline{25-27}}
\def\clines@iii@viii{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}
  \cline{17-19} \cline{21-23} \cline{25-27} \cline{29-31}}
\def\clines@iii@ix{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}
  \cline{17-19} \cline{21-23} \cline{25-27} \cline{29-31}
  \cline{33-35}}
\def\clines@iii@x{\cline{1-3} \cline{5-7} \cline{9-11} \cline{13-15}
  \cline{17-19} \cline{21-23} \cline{25-27} \cline{29-31}
  \cline{33-35} \cline{37-39}}


% \clines@iv@whatever is for tables in which a  logical column consists of four columns; it's used for combinedgradetable.

\def\clines@iv@i{\cline{1-4}}
\def\clines@iv@ii{\cline{1-4} \cline{6-9}}
\def\clines@iv@iii{\cline{1-4} \cline{6-9} \cline{11-14}}
\def\clines@iv@iv{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}}
\def\clines@iv@v{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}
  \cline{21-24}}
\def\clines@iv@vi{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}
  \cline{21-24} \cline{26-29}}
\def\clines@iv@vii{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}
  \cline{21-24} \cline{26-29} \cline{31-34}}
\def\clines@iv@viii{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}
  \cline{21-24} \cline{26-29} \cline{31-34} \cline{36-39}}
\def\clines@iv@ix{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}
  \cline{21-24} \cline{26-29} \cline{31-34} \cline{36-39}
  \cline{41-44}}
\def\clines@iv@x{\cline{1-4} \cline{6-9} \cline{11-14} \cline{16-19}
  \cline{21-24} \cline{26-29} \cline{31-34} \cline{36-39}
  \cline{41-44} \cline{46-49}}

% The definition of \cline ends with \noalign{\vskip-\arrayrulewidth}, and so we want to throw in a \noalign{\vskip\arrayrulewidth} to cancel that.

\def\cline@correction{\noalign{\vskip\arrayrulewidth}}

\def\create@cline@stuff@v{%
  % Called by \@multicolumntable.
  \if@combined
    \if@scores
      \edef\cline@stuff@v{\expandafter\noexpand\csname
        clines@iv@\romannumeral \c@num@cols\endcsname
        \noexpand\cline@correction}%
    \else
      \edef\cline@stuff@v{\expandafter\noexpand\csname
        clines@iii@\romannumeral \c@num@cols\endcsname
        \noexpand\cline@correction}%
    \fi
  \else
    \if@scores
      \edef\cline@stuff@v{\expandafter\noexpand\csname
        clines@iii@\romannumeral \c@num@cols\endcsname
        \noexpand\cline@correction}%
    \else
      \edef\cline@stuff@v{\expandafter\noexpand\csname
        clines@ii@\romannumeral \c@num@cols\endcsname
        \noexpand\cline@correction}%
    \fi
  \fi
}% create@cline@stuff@v

%--------------------------------------------------------------------
% The various \docolumn@heads@something@v

\def\docolumn@heads@v{%
  % Called by \@multicolumntable.
  % multicolumngradetable or multicolumnbonusgradetable, possibly
  % partial.
    \iftbl@pgs
      \if@bonus
        \@bvpgword
      \else
        \@vpgword
      \fi
    \else
      \if@bonus
        \@bvqword
      \else
        \@vqword
      \fi
    \fi
  & \if@bonus
      \@bvpword
    \else
      \@vpword
    \fi
  & \if@bonus
      \@bvsword
    \else
      \@vsword
    \fi
  \addtocounter{@iterator}{1}%
  \ifnum \value{@iterator} < \value{num@cols}\relax
    \hidden@ampersand
    \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
    \hidden@ampersand
    \let\nextdocolumn@heads@v=\docolumn@heads@v
  \else
    \let\nextdocolumn@heads@v=\relax
  \fi
  \nextdocolumn@heads@v
}% docolumn@heads@v

\def\docolumn@heads@noscores@v{%
  % Called by \@multicolumntable.
  % multicolumnpointtable or multicolumnbonuspointtable, possibly partial.
    \iftbl@pgs
      \if@bonus
        \@bvpgword
      \else
        \@vpgword
      \fi
    \else
      \if@bonus
        \@bvqword
      \else
        \@vqword
      \fi
    \fi
    &
    \if@bonus
      \@bvpword
    \else
      \@vpword
    \fi
  \addtocounter{@iterator}{1}%
  \ifnum \value{@iterator} < \value{num@cols}\relax
    \hidden@ampersand
    \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
    \hidden@ampersand
    \let\nextdocolumn@heads@noscores@v=\docolumn@heads@noscores@v
  \else
    \let\nextdocolumn@heads@noscores@v=\relax
  \fi
  \nextdocolumn@heads@noscores@v
}% docolumn@heads@noscores@v

\def\docolumn@heads@comb@v{%
  % Called by \@multicolumntable.
  % multicolumncombinedgradetable, possibly partial.
    \iftbl@pgs
      \@cvpgword
    \else
      \@cvqword
    \fi
  & \@cvpword
  & \@cvbpword
  &  \@cvsword
  \addtocounter{@iterator}{1}%
  \ifnum \value{@iterator} < \value{num@cols}\relax
    \hidden@ampersand
    \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
    \hidden@ampersand
    \let\nextdocolumn@heads@comb@v=\docolumn@heads@comb@v
  \else
    \let\nextdocolumn@heads@comb@v=\relax
  \fi
  \nextdocolumn@heads@comb@v
}% docolumn@heads@comb@v

\def\docolumn@heads@comb@noscores@v{%
  % Called by \@multicolumntable.
  % multicolumncombinedpointtable, possibly partial.
    \iftbl@pgs
      \@cvpgword
    \else
      \@cvqword
    \fi
  & \@vpword
  & \@bvpword
  \addtocounter{@iterator}{1}%
  \ifnum \value{@iterator} < \value{num@cols}\relax
    \hidden@ampersand
    \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
    \hidden@ampersand
    \let\nextdocolumn@heads@comb@noscores@v=\docolumn@heads@comb@noscores@v
  \else
    \let\nextdocolumn@heads@comb@noscores@v=\relax
  \fi
  \nextdocolumn@heads@comb@noscores@v
}% docolumn@heads@comb@noscores@v

%--------------------------------------------------------------------
% \do@lines@v is used by *all* multicolumn tables.
% It calls \do@oneline@v for all non-combined tables and \do@oneline@comb@v for all combined tables.

\def\do@lines@v{%
  % We get here from \@multicolumntable.
  \addtocounter{current@row}{1}%
  \setcounter{pq@index}{\value{pq@index@pts}}%
  \setcounter{cols@done}{0}% Number of columns done
  % We're doing both grade tables and point tables!!
  \if@combined
    \do@oneline@comb@v
  \else
    \do@oneline@v
  \fi
  \increment@index{pq@index@pts}%
  \ifnum \value{current@row} = \value{num@rows}\relax
    \\
    \cline@stuff@v
    \end{tabular}%
    \let\nextdo@lines@v=\relax
  \else
    \\
    \cline@stuff@v
    \let\nextdo@lines@v=\do@lines@v
  \fi
  \nextdo@lines@v
}% do@lines@v

\def\do@oneline@v{%
  % Called by \do@lines@v.
  % Used for all multicolumn non-combined tables. pq@index holds the question or page number we're about to do.
  \ifnum \value{pq@index} > \last@pq@index\relax
    % See if we're in the last column; use pq@index@bpts as a scratch counter: 
    \setcounter{pq@index@bpts}{\value{cols@done}}%
    \addtocounter{pq@index@bpts}{1}%
    \ifnum \value{pq@index@bpts} = \value{num@cols}\relax
      % We're in the last column; are we in the last row?
      \ifnum \value{current@row} = \value{num@rows}\relax
        % We're in the last column, last row!
        % Print the total:
          \if@bonus
            \@bvtword
          \else
            \@vtword
          \fi
          \hidden@ampersand
        \if@scores
            \if@bonus
              \prt@tablebonuspoints
            \else
              \prt@tablepoints
            \fi
          \hidden@ampersand
            \hbox to \@cellwidth{\hfill}%
        \else
            \if@bonus
              \prt@tablebonuspoints
            \else
              \prt@tablepoints
            \fi
        \fi
      \else
        % Not last column last row; insert empty space:
          \hbox to \@cellwidth{\hfill}%
        \if@scores
          \hidden@ampersand
            \hbox to \@cellwidth{\hfill}%
        \fi
        \hidden@ampersand
          \hbox to \@cellwidth{\hfill}%
      \fi
    \else
      % Not last column; insert empty space:
      \hbox to \@cellwidth{\hfill}%
      \if@scores
        \hidden@ampersand
          \hbox to \@cellwidth{\hfill}%
      \fi
      \hidden@ampersand
        \hbox to \@cellwidth{\hfill}%
    \fi
  \else
    % We need to do question (or page) number pq@index:
      \refto@index{pq@index}%
    \hidden@ampersand
      \if@scores
        \if@bonus
          \bonuspointsof@index{pq@index}%
          \addto@hlfcntr{tbl@bonuspoints}{\bonuspointsof@index{pq@index}}%
        \else
          \pointsof@index{pq@index}%
          \addto@hlfcntr{tbl@points}{\pointsof@index{pq@index}}%
        \fi
      \hidden@ampersand
        \hbox to \@cellwidth{\hfill}%
    \else
      \if@bonus
        \bonuspointsof@index{pq@index}%
        \addto@hlfcntr{tbl@bonuspoints}{\bonuspointsof@index{pq@index}}%
      \else
        \pointsof@index{pq@index}%
        \addto@hlfcntr{tbl@points}{\pointsof@index{pq@index}}%
      \fi
    \fi
  \fi
  \addtocounter{cols@done}{1}% Number of columns done
  \ifnum \value{cols@done} < \value{num@cols}\relax
    \hidden@ampersand
      \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
      \nextcolumn@index@v{pq@index}%
    \hidden@ampersand
      \let\nextdo@oneline@v=\do@oneline@v
  \else
    \let\nextdo@oneline@v=\relax
  \fi
  \nextdo@oneline@v
}% do@oneline@v

\def\do@oneline@comb@v{%
  % Called by \do@lines@v.
  % All combined multicolumn tables. pq@index holds the question (or page) we're about to do.
  \ifnum \value{pq@index} > \last@pq@index\relax
    % See if we're in the last column; use pq@index@bpts as a scratch counter: 
    \setcounter{pq@index@bpts}{\value{cols@done}}%
    \addtocounter{pq@index@bpts}{1}%
    \ifnum \value{pq@index@bpts} = \value{num@cols}\relax
      % We're in the last column; are we in the last row?
      \ifnum \value{current@row} = \value{num@rows}\relax
        % We're in the last column, last row!
        % Print the total:
        \@cvtword
        \hidden@ampersand
          \prt@tablepoints
        \hidden@ampersand
        \if@scores
            \prt@tablebonuspoints
          \hidden@ampersand
            \hbox to \@cellwidth{\hfill}%
        \else
          \prt@tablebonuspoints
        \fi
      \else
        % Last column, but not last row; insert empty space:
          \hbox to \@cellwidth{\hfill}%
        \hidden@ampersand
          \hbox to \@cellwidth{\hfill}%
        \if@scores
          \hidden@ampersand
            \hbox to \@cellwidth{\hfill}%
        \fi
        \hidden@ampersand
          \hbox to \@cellwidth{\hfill}%
      \fi
    \else
      % Not last column; insert empty space:
        \hbox to \@cellwidth{\hfill}%
      \hidden@ampersand
        \hbox to \@cellwidth{\hfill}%
      \if@scores
        \hidden@ampersand
          \hbox to \@cellwidth{\hfill}%
      \fi
      \hidden@ampersand
        \hbox to \@cellwidth{\hfill}%
    \fi
  \else
    % We need to do question number pq@index:
      \refto@index{pq@index}%
    \hidden@ampersand
      \pointsof@index{pq@index}%
      \addto@hlfcntr{tbl@points}{\pointsof@index{pq@index}}%
    \hidden@ampersand
    \if@scores
        \bonuspointsof@index{pq@index}%
        \addto@hlfcntr{tbl@bonuspoints}{\bonuspointsof@index{pq@index}}%
      \hidden@ampersand
        \hbox to \@cellwidth{\hfill}%
    \else
      \bonuspointsof@index{pq@index}%
      \addto@hlfcntr{tbl@bonuspoints}{\bonuspointsof@index{pq@index}}%
    \fi
  \fi
  \addtocounter{cols@done}{1}% Number of columns done
  \ifnum \value{cols@done} < \value{num@cols}\relax
    \hidden@ampersand
    \hspace*{-\arrayrulewidth}\hspace*{\doublerulesep}%
    \nextcolumn@index@v{pq@index}%
    \hidden@ampersand
    \let\nextdo@oneline@comb@v=\do@oneline@comb@v
  \else
    \let\nextdo@oneline@comb@v=\relax
  \fi
  \nextdo@oneline@comb@v
}% do@oneline@comb@v

%--------------------------------------------------------------------
% \find@nextpagewithpoints and \find@nextcolumnpage@v:

\def\find@nextpagewithpoints#1{%
  % Called by \dofind@nextcolumnpage@v, \increment@index, and \@multicolumntable.
  % The argument #1 should be the name of a counter with a nonnegative value. We increase #1 by at least 1 to either the number of the next page containing the appropriate kind of points, or to something greater than \tbl@lastp. 
  \addtocounter{#1}{1}%
  \if@combined
    \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\value{#1}}}%
    \addto@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\value{#1}}}%
    % The sum is positive when at least one of them is positive.
  \else
    \if@bonus
      \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\value{#1}}}%
    \else
      \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\value{#1}}}%
    \fi
  \fi
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \let\nextfind@nextpagewithpoints=\relax
  \else
    \ifnum \value{#1} > \tbl@lastp\relax
      \let\nextfind@nextpagewithpoints=\relax
    \else
      \def\nextfind@nextpagewithpoints{\find@nextpagewithpoints{#1}}%
    \fi
  \fi
  \nextfind@nextpagewithpoints
}% find@nextpagewithpoints

\def\find@nextcolumnpage@v#1{%
  % Called by \nextcolumn@index@v.
  % We use \find@nextpagewithpoints to increment #1 to either the (num@rows)'th page number after #1 that contains the appropriate kind of points or to a value greater than \tbl@lastp.
  \setcounter{pq@index@bpts}{0}%
  \dofind@nextcolumnpage@v{#1}%
}% find@nextcolumnpage@v

\def\dofind@nextcolumnpage@v#1{%
  % Called only by \find@nextcolumnpage@v.
  \addtocounter{pq@index@bpts}{1}%
  \find@nextpagewithpoints{#1}%
  \ifnum \value{pq@index@bpts} = \value{num@rows}\relax
    \let\nextdofind@nextcolumnpage@v=\relax
  \else
    % The following test shouldn't be needed, in theory, because the computation of num@cols should prevent trouble, but we're being paranoid.
    \ifnum \value{#1} > \tbl@lastp\relax
      \let\nextdofind@nextcolumnpage@v=\relax
    \else
      % Note: this is a \def, and not a \let, because we need to put in the argument #1:
      \def\nextdofind@nextcolumnpage@v{\dofind@nextcolumnpage@v{#1}}%
    \fi
  \fi
  \nextdofind@nextcolumnpage@v
}% dofind@nextcolumnpage@v

%--------------------------------------------------------------------
% \pointsinrange and \bonuspointsinrange, and then \firstqinrange, \lastqinrange, and \numqinrange.

% We say either \@bonusfalse or \@bonustrue, and then we check it only in \do@countloop:

\def\pointsinrange#1{%
  \@bonusfalse
  \def\tbl@range{#1}%
  \@ifundefined{exam@numpoints}%
    {\mbox{\normalfont\bfseries ??}}%
    {\read@range}%
}% pointsinrange

\def\bonuspointsinrange#1{%
  \@bonustrue
  \def\tbl@range{#1}%
  \@ifundefined{exam@numpoints}%
    {\mbox{\normalfont\bfseries ??}}%
    {\read@range}%
}% bonuspointsinrange

\def\bad@range{%
  % Called by \read@range, \firstqinrange, \lastqinrange, and \numqinrange.
  {\mbox{\normalfont\bfseries ??}}%
  \ClassWarning{rvexam}{%
    Grading range `\tbl@range' not defined.\MessageBreak
    \space\space Run LaTeX again.\MessageBreak
  }%
}% bad@range

\def\read@range{%
  % Called by \pointsinrange and \bonuspointsinrange.
  \@ifundefined{range@\tbl@range @firstq}%
  {%
    \bad@range
  }%
  {%
    \@ifundefined{range@\tbl@range @lastq}%
    {%
      \bad@range
    }%
    {%
      \edef\tbl@firstq{\csname range@\tbl@range @firstq\endcsname}%
      \edef\tbl@lastq{\csname range@\tbl@range @lastq\endcsname}%
      % Check that firstq precedes or equals lastq:
      \ifnum \tbl@firstq > \tbl@lastq\relax
        \fbox{\textbf{Error:} Grading Range `\tbl@range ':
          Last question precedes first question.}%
        \ClassError{rvexam}{%
          In grading range `\tbl@range ',
          the last question\MessageBreak
          \space\space comes before the first question.\MessageBreak
        }{%
          \string\begingradingrange \space must precede
          \string\endgradingrange \space by at
          least one question.\MessageBreak
        }%
      \else
        \count@pointsinrange
      \fi
    }%
  }%
}% read@range

\def\count@pointsinrange{%
  % Used for both \pointsinrange and \bonuspointsinrange:
  \set@hlfcntr{tbl@points}{0}%
  \setcounter{@iterator}{\tbl@firstq}%
  \addtocounter{@iterator}{-1}\do@countloop
  \prt@hlfcntr{tbl@points}%
}% count@pointsinrange

\def\do@countloop{%
  % We check \if@bonus here when needed:
  \addtocounter{@iterator}{1}%
  \if@bonus
    \@ifundefined{bonuspointsofq@\romannumeral \c@@iterator}%
      {}%
      {\addto@hlfcntr{tbl@points}
         {\csname bonuspointsofq@\romannumeral \c@@iterator\endcsname}}%
  \else
    \@ifundefined{pointsofq@\romannumeral \c@@iterator}%
      {}%
      {\addto@hlfcntr{tbl@points}
         {\csname pointsofq@\romannumeral \c@@iterator\endcsname}}%
  \fi
  \ifnum \value{@iterator} < \tbl@lastq\relax
    \let\next@countloop=\do@countloop
  \else
    \let\next@countloop=\relax
  \fi
  \next@countloop
}% do@countloop

%--------------------------------------------------------------------
% \firstqinrange, \lastqinrange, and \numqinrange.

\newcommand{\firstqinrange}[1]{%
  \def\tbl@range{#1}%
  \@ifundefined{range@\tbl@range @firstq}%
  {\bad@range}%
  {\csname range@#1@firstq\endcsname}%
}% firstqinrange

\newcommand{\lastqinrange}[1]{%
  \def\tbl@range{#1}%
  \@ifundefined{range@\tbl@range @lastq}%
  {\bad@range}%
  {\csname range@#1@lastq\endcsname}%
}% lastqinrange

\newcommand{\numqinrange}[1]{%
  \def\tbl@range{#1}%
  \@ifundefined{range@#1@firstq}%
  {%
    \bad@range
  }%
  {%
    \@ifundefined{range@#1@lastq}%
    {%
      \bad@range
    }%
    {%
      \setcounter{@iterator}{\csname range@#1@lastq\endcsname}%
      \addtocounter{@iterator}{-\csname range@#1@firstq\endcsname}%
      \stepcounter{@iterator}%
      \arabic{@iterator}%
    }%
  }%
}% numqinrange

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%                     ***************************
%                     ** SOLUTION ENVIRONMENTS **
%                     ***************************

\def\printanswers{\printanswerstrue}
\def\noprintanswers{\printanswersfalse}

% If the documentclass options include ``cancelspace'', then the command \cancelspacetrue is given at the beginning of the run.

% If the documentclass options include ``nocancelspace'', then the command \cancelspacefalse is given at the beginning of the run.

\def\cancelspace{\cancelspacetrue}
\def\nocancelspace{\cancelspacefalse}

% The command \unstarredvspace alters the solution environment so that, when solutions are not being printed, any optional space will be inserted with a \vspace{} command, instead of a \vspace*{} command.

\newif\if@unstarredvspace
\def\unstarredvspace{\@unstarredvspacetrue}
\def\nounstarredvspace{\@unstarredvspacefalse}
\nounstarredvspace

% \if@insolution will be true while we're inside of any of the solution environments.  This is used to supress \PgInfo@write and \label commands generated if there's a parts (or subparts, or subsubparts) environment inside of a solution.  (It won't suppress the labels for the question objects, since a question object is never a label that's been used before.)

\newif\if@insolution
\@insolutionfalse

\newcommand\SolutionEmphasis[1]{%
  \def\Solution@Emphasis{#1}%
}
\SolutionEmphasis{}

% If printanswers is true, we print the solution using a TheSolution environment.  If printanswers is false and cancelspace is false, we insert blank vertical space equal to the optional argument (the default value of which is 0pt).

\newenvironment{solution}[1][0pt]%
  {%
    \@insolutiontrue % cancelled by the end of the environment
    \@addpointsfalse % cancelled by the end of the environment
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \if@unstarredvspace
          \vspace{#1}%
        \else
          \vspace*{#1}%
        \fi
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%

% If printanswers is true, we print the solution using a TheSolution env.  
% If printanswers is false and cancelspace is false, we insert an empty box of width the current line width and of height equal to the optional argument, which can be a length, or \fill, or \stretch{number}.  If the optional argument is omitted, then the box is entirely omitted when printanswers is false.

\newenvironment{solutionorbox}[1][-1pt]%
  {%
    \@insolutiontrue % cancelled by the end of the environment
    \@addpointsfalse % cancelled by the end of the environment
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        % Note: It's important that the following test be ``\ifdim 0pt > #1'' rather than ``\ifdim #1 < 0pt''; That's because if the user says
        % ``\begin{solutionorbox}{\stretch{1}}''
        % (or \stretch{anythingelse}), then this will expand to ``\ifdim 0pt > \z@ plus 1fill\relax''.
        % The \ifdim will be ``\ifdim 0pt > \z@'', and we'll have ``plus 1fill\relax'' left over.  This is OK because if the \ifdim is false, that leftover stuff will be ignored, and it will only be true if the user omitted the optional argument, in which case there's no \stretch and thus no left over part.
        % If we said ``\ifdim #1 < 0pt'', then we'd get an error when the user used \stretch, since the leftover stuff would appear when TeX was looking for <, =, or >.
        \ifdim 0pt > #1
          % do nothing
        \else
          \makeemptybox{#1}%
        \fi
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%
  
% If printanswers is true, we print the solution using a TheSolution env. If printanswers is false and cancelspace is false, we insert lined vertical space equal to the optional argument (the default value of which is 0pt).

\newenvironment{solutionorlines}[1][0pt]%
  {%
    \@insolutiontrue % cancelled by the end of the environment
    \@addpointsfalse % cancelled by the end of the environment
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \fillwithlines{#1}%
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%
  
% If printanswers is true, we print the solution using a TheSolution env. If printanswers is false and cancelspace is false, we insert dotted lined vertical space equal to the optional argument (the default value of which is 0pt).

\newenvironment{solutionordottedlines}[1][0pt]%
  {%
    \@insolutiontrue % cancelled by the end of the environment
    \@addpointsfalse % cancelled by the end of the environment
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \fillwithdottedlines{#1}%
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%

% If printanswers is true, we print the solution using a TheSolution env. If printanswers is false and cancelspace is false,
% we insert a grid occupying vertically the optional argument (the default value of which is 0pt).

\newenvironment{solutionorgrid}[1][0pt]%
  {%
    \@insolutiontrue % cancelled by the end of the environment
    \@addpointsfalse % cancelled by the end of the environment
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \fillwithgrid{#1}%
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%

% The environment TheSolution is called from the solution, solutionorbox, solutionorlines, solutionordottedlines, and solutionorgrid environments when printanswers is true.  It uses Donald Arseneau's framed.sty macros (included at the end of this file) to allow the solution to be broken across pages and have each piece enclosed in an fbox (or a colorbox, if the user has given the command \shadedsolutions), (or no box at all, if the user has given the command \unframedsolutions).

% Of course, the user can change TheSolution with a \renewenvironment command.

\newcommand{\solutiontitle}{\noindent\textbf{Solution:}\enspace}

\newenvironment{TheSolution}%
  {%
    \vspace{\parskip}%
    % If we don't set \leftskip and \rightskip to 0pt, then if we appear inside of an \uplevel command we'd have indentation inside of the solution box:
    \leftskip=0pt
    \rightskip=0pt
    % If the user said \unframedsolutions, then both \if@framedsolutions and \if@shadedsolutions are false:
    \if@framedsolutions
      % We'll use the default \exam@FrameCommand
    \else
      \if@shadedsolutions
        \def\exam@FrameCommand{\colorbox{SolutionColor}}%
      \else
        % It's \unframedsolutions:
        \def\exam@FrameCommand{}%
      \fi
    \fi
    \exam@MakeFramed{\advance\hsize-\exam@width}%
    \solutiontitle
    \ignorespaces
  }%
  {%
    \unskip
    \endexam@MakeFramed
  }%

\newif\if@framedsolutions
\@framedsolutionstrue

\newif\if@shadedsolutions
\@shadedsolutionsfalse

% If the user said \unframedsolutions, then both \if@framedsolutions and \if@shadedsolutions are false.

\def\framedsolutions{\@framedsolutionstrue\@shadedsolutionsfalse}

\def\shadedsolutions{%
  \@ifundefined{definecolor}
  {%
    \ClassError{rvexam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\shadedsolutions
      \MessageBreak
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{SolutionColor}{gray}{0.8}
    \@shadedsolutionstrue
    \@framedsolutionsfalse
  }%
}

\def\unframedsolutions{\@framedsolutionsfalse\@shadedsolutionsfalse}

%----------------------- solutionbox environment -------------------------------
% The solutionbox environment is different from the other solution environments (solution, solutionorbox, solutionorlines, solutionordottedlines, and solutionorgrid), in that
%   (1) The box is always printed, whether answers are being printed or not.
%   (2) The argument giving the size of the box is a required argument, not an optional argument, and so it should be enclosed in braces, not in brackets.  It can be either a length or \stretch{number}.
%   (3) We make no use of the TheSolution environment; the solutionbox environment is completely freestanding.

% If answers are not being printed then only the box is printed, with nothing in it.  If answers are being printed, then the solution is printed inside of the box.

% Note: It's the user's responsibility to be sure that the box is large enough to hold the solution!  If the solution takes up too much vertical space, then it will spill out of the bottom of the box, overwriting whatever follows the box.

% 2016/02/08: The solutionbox frame can now be printed in color, as long as you load color.sty in the preamble.
%
% \usepackage{color}
%
% in the preamble, and then give the command
%
%   \colorsolutionboxes
%
% to have the frame around a solutionbox in color.  The default color was created by the command
%
%     \definecolor{SolutionBoxColor}{gray}{0.8}
%
% and you can change the color by giving a new \definecolor command (which must be done *after* the \colorsolutionboxes command).
%
% To cancel color solutionbox frames and return to black, give the command
%
%   \nocolorsolutionboxes

\newif\if@colorsolutionboxes
\@colorsolutionboxesfalse

\def\colorsolutionboxes{%
  \@ifundefined{definecolor}
  {%
    \ClassError{rvexam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\colorsolutionboxes
      \MessageBreak
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{SolutionBoxColor}{gray}{0.8}
    \@colorsolutionboxestrue
  }%
}
\def\nocolorsolutionboxes{\@colorsolutionboxesfalse}

\newbox\exam@box

\newenvironment{solutionbox}[1]{%
  \@insolutiontrue % cancelled by the end of the environment
  \@addpointsfalse % cancelled by the end of the environment
  \def\solutionbox@size{#1}% saved for end of environment
% The solutionbox environment will work correctly inside of a tabular environment, we use \hsize instead of \textwidth:  \@tempdima=\textwidth
  \@tempdima=\hsize
  \advance\@tempdima -\@totalleftmargin
  \advance\@tempdima -6\fboxsep
  \advance\@tempdima -2\fboxrule
  % Confine the \Solution@Emphasis, as well as anything the user puts into the solution (e.g., \color{red}, or whatever); don't say \endgroup until after using \box\exam@box:
  \begingroup 
    \Solution@Emphasis
    % We save the solution in a box of the proper width.  We'll either print it (if we're printing solutions) or throw it away by just not using it before the environment ends:
    \setbox\exam@box=\vtop\bgroup
      \hsize=\@tempdima
      \leftskip=0pt
      \rightskip=0pt
      \vskip 2\fboxsep
% Change, 2016/05/09: We change \@totalleftmargin and \linewidth in case there are enumerate, itemize, or description environments inside the solution:
      \@totalleftmargin=0pt
      \linewidth=\hsize
      \solutiontitle
      \ignorespaces
  }%
  {%
    \unskip
    \egroup
    % OK, the solution is now inside \box\exam@box.
    % Set the height and depth to 0pt, so that if we use it we won't be advancing our position on the page:
    \ht\exam@box=0pt
    \dp\exam@box=0pt
    \par
    \vspace{\parskip}
    \ifprintanswers
      % We enclose the \vtop in an \hbox to avoid having the indentation of the enclosing list environment (implemented via \parshape) shift us to the right when we enter H mode.  If we don't use this \hbox, then we'd have to comment out the \hskip \@totalleftmargin:
      % 2016/02/08: Changed \textwidth to \hsize:
      \hbox to \hsize{%
        \noindent
        \hskip\@totalleftmargin
        \hskip3\fboxsep\hskip\fboxrule
        \box\exam@box\hfill
      }%
      \par\nointerlineskip
    \fi
  \endgroup % Finish confining the \Solution@Emphasis
% Starting in version 2.502, 2016/03/23,the decision of whether to color the box is made in the \makeemptybox command:
  \makeemptybox{\solutionbox@size}
  }% End of the second argument of \newenvironment{solutionbox}


%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Added in version 2.502: 2016/03/23, \colorfbox

% The \colorfbox command is used in our modification of framed.sty
% that allows us to print the frame around the solution in color when
% the user has given the command \colorsolutionboxes.  It takes two
% arguments, the first being the color for the frame, and the second
% being the stuff to be framed.

% If we had assumed that xcolor.sty was used (instead of just
% color.sty), then the line that saves the current color in
% saved@color could have been just

%   \colorlet{saved@color}{.}

% but we wanted to make this work even if color.sty is being used.

% When you define a color mycolor using either color.sty or
% xcolor.sty, a macro \csname\string\color@ mycolor\endcsname is
% defined (i.e., the macro name is \\color@mycolor).

\newcommand{\colorfbox}[2]{%
  % Save the current color in saved@color:
  \expandafter\let\csname\string\color@saved@color\endcsname\current@color
  % Create the box in color #1, with the text in saved@color
  % (the braces are to confine the color change commands):
  {\color{#1}\fbox{\color{saved@color}#2}}%
}% colorfbox

%--------------------------------------------------------------------
%--------------------------------------------------------------------

% The following stuff is lifted from:
%
% framed.sty   v 0.8a   21-Jul-2003
% Copyright (C) 1992-2003 by Donald Arseneau
% These macros may be freely transmitted, reproduced, or modified
% provided that this notice is left intact.
%
% The modifications I made are marked with ``psh'' in a comment:
%
% Further modifications, 2017-09-21
% I changed the names of many commands by prepending ``exam@'', so
% that the user can use the framed.sty package with exam.cls and not
% have conflicts.  (I also renamed the framed, shaded, and leftbar
% environments to examframed, examshaded, and examleftbar.)  I didn't
% mark these name changes.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create framed or shaded regions that can break across pages using 
% \begin{examframed} ... \end{examframed}    -- ordinary frame box
% (box at margin)
% \begin{examshaded} ... \end{examshaded}    -- shaded background
% (into margin)
%    ... examleftbar ...                 -- line on left side
% \begin{MakeFramed}{settings} ... \end{MakeFramed}
%                        -- generic frame (for new environments)
%
% The "examframed" environment puts the text into "\fbox" with the
% settings "\fboxrule=\exam@FrameRule" and "\fboxsep=\exam@FrameSep".
% You can change these lengths (using "\setlength") and you
% can even change the definition of "\exam@FrameCommand" to use
% much fancier boxes.
%
% In fact, the "shaded" environment just redefines "\exam@FrameCommand"
% to use "\colorbox{shadecolor}" (and you have to define the
% color "shadecolor": \newcolor{shadecolor}...).
%
% A page break is allowed, and even encouraged, before the framed
% environment.  If you want to attach some text (a box title) to the
% frame, then the text should be inserted by \exam@FrameCommand
%
% The contents of the framed regions are restricted: 
% Floats, footnotes, marginpars and head-line entries will be lost.
% (Some of these may be handled in a later version.)
% This package will not work with the page breaking of multicol.sty,
% or other systems that perform column-balancing.
%
% The MakeFramed environment does the work.  Its "settings" argument
% should contain any adjustments to the text width (applied to \hsize,
% and using the "\exam@width" of the frame itself) as well as a `restore' 
% command -- \@parboxrestore or \exam@FrameRestore or something similar.
% 
% Expert commands:
% \exam@MakeFramed, \endexam@MakeFramed: the "MakeFramed" environment
% \exam@FrameCommand: command to draw the frame around its argument
% \exam@FrameRestore: restore some text settings, but fewer than
% \@parboxrestore 
% \exam@FrameRule: length register; \fboxrule for default "framed".
% \exam@FrameSep: length register; \fboxsep for default "framed".
% \exam@frameHeightAdjust: macro; height of frame above baseline at
% top of page
% 
% This is still a `pre-production' version because I can think of many
% features/improvements that should be made.  Nevertheless, starting 
% with version 0.5 it should be bug-free.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%psh: Commented out \ProvidesPackage:
%\ProvidesPackage{framed}[2003/07/21 v 0.8a: 
%   framed or shaded text with page breaks]

%psh: Created \saved@totalleftmargin and \@sollistdepth:

\newdimen\saved@totalleftmargin
\newcount\@sollistdepth

\newenvironment{examframed}% using default \exam@FrameCommand
  {\exam@MakeFramed {\advance\hsize-\exam@width \exam@FrameRestore}}%
  {\endexam@MakeFramed}

\newenvironment{examshaded}{%
  \def\exam@FrameCommand{\colorbox{shadecolor}}%
  \exam@MakeFramed {\exam@FrameRestore}}%
 {\endexam@MakeFramed}

\newenvironment{examleftbar}{%
  \def\exam@FrameCommand{\vrule width 3pt \hspace{10pt}}%
  \exam@MakeFramed {\advance\hsize-\exam@width \exam@FrameRestore}}%
 {\endexam@MakeFramed}

\chardef\exam@FrameRestore=\catcode`\| % for debug
\catcode`\|=\catcode`\% % (debug: insert space after backslash)

\def\exam@MakeFramed#1{\par
 % measure added width and height; call result \exam@width and \exam@height
 \setbox\z@\vbox{\vskip-1in \hbox{\hskip-1in 
   \exam@FrameCommand{\hbox{\vrule \@height .7in \@depth.3in \@width 1in}}}%
   \vskip\z@skip}%
 \def\exam@width{\wd\z@}\def\exam@height{\ht\z@}%
 \edef\exam@fb@frw{\the\exam@width}\edef\exam@fb@frh{\the\exam@height}%
 % insert pre-penalties and skips
 \begingroup
 \skip@\lastskip
 \if@nobreak\else 
    \penalty9999 % updates \page parameters
    \ifdim\pagefilstretch=\z@ \ifdim\pagefillstretch=\z@
       \edef\@tempa{\the\skip@}%
       \ifx\@tempa\exam@zero@glue \penalty-30
       \else \vskip-\skip@ \penalty-30 \vskip\skip@
    \fi\fi\fi
    \penalty\z@
    % Give a stretchy breakpoint that will always be taken in preference
    % to the \penalty 9999 used to update page parameters.  The cube root
    % of 10000/100 indicates a multiplier of 0.21545, but the maximum 
    % calculated badness is really 8192, not 10000, so the multiplier
    % is 0.2301. 
    \advance\skip@ \z@ plus-.5\baselineskip
    \advance\skip@ \z@ plus-.231\exam@height
    \advance\skip@ \z@ plus-.231\skip@
    \advance\skip@ \z@ plus-.231\topsep
    \vskip-\skip@ \penalty 1800 \vskip\skip@
 \fi
 \addvspace{\topsep}%
 \endgroup
 % clear out pending page break
 \penalty\@M \vskip 2\baselineskip \vskip\exam@height
 \penalty9999 \vskip -2\baselineskip \vskip-\exam@height
 \penalty9999 % updates \pagetotal
|\message{After clearout, \pagetotal=\the\pagetotal, \pagegoal=\the\pagegoal. }%
 \exam@fb@adjheight 
%psh: Added commands:
  \advance\hsize-\@totalleftmargin
  \saved@totalleftmargin=\@totalleftmargin
  \@totalleftmargin=0pt
  \parshape 0
  \let\@listdepth=\@sollistdepth
  \@sollistdepth=0
  \leftmargin=0pt
%psh: end of added commands
 \setbox\@tempboxa\vbox\bgroup
   #1% Modifications to \hsize (can use \exam@width and \exam@height)
   \textwidth\hsize \columnwidth\hsize
%psh: added one line:
   \linewidth=\hsize
}

\def\endexam@MakeFramed{\par
     \kern\z@ \penalty-100 % put depth into height
 \egroup
 \begingroup \exam@put@frame \endgroup
%psh: Added one line:
 \@totalleftmargin=\saved@totalleftmargin
}

% \exam@put@frame takes the contents of \@tempboxa and puts all, or a piece, of it on the page with a frame (\exam@FrameCommand). It recurses until all of \@tempboxa has been used up. (\@tempboxa must have zero depth.)

\def\exam@put@frame{\relax
 \ifdim\pagegoal=\maxdimen \pagegoal\vsize \fi
|   \message{=============== Entering putframe ====================^^J
|     \pagegoal=\the\pagegoal,  \pagetotal=\the\pagetotal. }%
 \ifinner \else
    \dimen@\pagegoal \advance\dimen@-\pagetotal % natural space left on page
  \ifdim\dimen@<2\baselineskip 
|   \message{Page has only \the\dimen@\space room left; eject. }%
    \eject \exam@fb@adjheight \exam@put@frame
  \else % there's appreciable room left on the page
|    \message{\string\pagetotal=\the\pagetotal,
|        \string\pagegoal=\the\pagegoal, 
|        \string\pagestretch=\the\pagestretch,
|        \string\pageshrink=\the\pageshrink,
|        \string\exam@fb@frh=\exam@fb@frh. \space}
|    \message{Box of size \the\ht\@tempboxa\space + \exam@fb@frh}%
     \begingroup % temporarily set \dimen@ to be...
     \advance\dimen@.8\pageshrink  % maximum space available on page
     \advance\dimen@-\exam@fb@frh\relax % space available for frame's contents
     \expandafter\endgroup
     % restore \dimen@ to real room left on page
     \ifdim\dimen@>\ht\@tempboxa % whole box does fit
|       \message{fits in \the\dimen@. }%
     \else % box must be split
|       \message{must be split to fit in \the\dimen@. }%
        \setbox\@tempboxa\vbox{% simulate frame and flexiblity of the page:
           \vskip \exam@fb@frh \@plus\pagestretch \@minus.8\pageshrink
           \kern137sp\kern-137sp\penalty-30
           \unvbox\@tempboxa}%
        \edef\exam@fb@resto@set{\boxmaxdepth\the\boxmaxdepth
          \splittopskip\the\splittopskip}%
        \boxmaxdepth\z@ \splittopskip\z@
        \setbox\tw@\vsplit\@tempboxa to\dimen@
        \setbox\tw@\vbox{\unvbox\tw@}% natural-sized
|       \message{Box of size \the\ht\@tempboxa\space split to \the\dimen@. 
|          Natural height of split box is \the\ht\tw@. }%
        % If the split-to size > (\vsize-\topskip), then set box to full size
        \begingroup
          \advance\dimen@\topskip
          \expandafter\endgroup
        \ifdim\dimen@>\pagegoal
|         \message{Frame is big -- Use up the full column. }%
          \dimen@ii\pagegoal
          \advance\dimen@ii -\topskip
          \advance\dimen@ii \exam@frameHeightAdjust\relax
        \else  % suspect this is wrong:
          % If the split-to size > feasible room_on_page, rebox it smaller.
          \advance\dimen@.8\pageshrink
          \ifdim\ht\tw@>\dimen@
|           \message{Box too tall; rebox it to \the\dimen@. }%
            \dimen@ii\dimen@
          \else % use natural size
            \dimen@ii\ht\tw@
          \fi
        \fi
        % Re-box contents to desired size \dimen@ii
        \advance\dimen@ii -\exam@fb@frh
        \setbox\tw@\vbox to\dimen@ii \bgroup
        % remove simulated frame and page flexibility:
        \vskip -\exam@fb@frh \@plus-\pagestretch \@minus-.8\pageshrink
        \unvbox\tw@ \unpenalty\unpenalty
        \ifdim\lastkern=-137sp % whole box went to next page
|          \message{box split at beginning! }%
           \egroup \exam@fb@resto@set \eject % (\vskip for frame size
                                             % was discarded)  
           \exam@fb@adjheight
        \else %
           \egroup \exam@fb@resto@set
           \ifvoid\@tempboxa % it all fit after all
|             \message{box split at end! }%
              \setbox\@tempboxa\box\tw@
           \else % it really did split
|             \message{box split as expected. Its reboxed height is \the\ht\tw@. }%
              \ifdim\wd\tw@>\z@
%psh: Changed the command that inserts the box:
%     Instead of \centerline, we shift right by \saved@totalleftmargin:
%              \centerline{\exam@FrameCommand{\box\tw@}}%  ??? \centerline bad idea
       \hbox{\hskip \saved@totalleftmargin\exam@FrameCommand{\box\tw@}}%
              \else
|               \message{Zero width means likely blank. Don't frame it (guess)}%
                \box\tw@
              \fi
              \hrule \@height\z@
              \eject
              \exam@fb@adjheight
              \exam@put@frame
  \fi\fi\fi\fi\fi
  \ifvoid\@tempboxa\else
%psh: Changed the command that inserts the box:
%     Instead of \centerline, we shift right by \saved@totalleftmargin:
%    \centerline{\exam@FrameCommand{\box\@tempboxa}}%
    \hbox{\hskip\saved@totalleftmargin\exam@FrameCommand{\box\@tempboxa}}%
    \nointerlineskip \null %{\showoutput \showlists}
    \penalty-30 \vskip\topsep
  \fi}

\def\exam@fb@adjheight{%
  \vbox to\exam@frameHeightAdjust{}% get proper baseline skip from above.
  \penalty\@M \nointerlineskip
  \vskip-\exam@frameHeightAdjust
  \penalty\@M} % useful for tops of pages

\edef\exam@zero@glue{\the\z@skip}

\catcode`\|=\exam@FrameRestore

% Provide configuration commands:
%psh: Version 2.502, 2016/03/23, changed \exam@FrameCommand so that the
%     frame is printed in color if the user has said
%     \colorsolutionboxes:
%\providecommand\exam@FrameCommand{\fboxrule=\exam@FrameRule
%\fboxsep=\exam@FrameSep \fbox}
\def\exam@FrameCommand{\fboxrule=\exam@FrameRule \fboxsep=\exam@FrameSep
  \if@colorsolutionboxes
    \def\box@it{\colorfbox{SolutionBoxColor}}%
  \else
    \def\box@it{\fbox}%
  \fi
  \box@it
}% \exam@FrameCommand

\@ifundefined{FrameRule}{\newdimen\exam@FrameRule \exam@FrameRule=\fboxrule}{}
\@ifundefined{FrameSep} {\newdimen\exam@FrameSep  \exam@FrameSep =3\fboxsep}{}

% Height of frame above first baseline when frame starts a page:
\providecommand\exam@frameHeightAdjust{6pt}

% \exam@FrameRestore has parts of \@parboxrestore.  See how it is used in the 
% "settings" argument of \MakeFrame.  Previous behavior can be restored by 
% using \@parboxrestore there, or redefining:
% \makeatletter \renewcommand\exam@FrameRestore{\@parboxrestore} \makeatother
\def\exam@FrameRestore{%
  \let\if@nobreak\iffalse
  \let\if@noskipsec\iffalse
%  \let\par\@@par  ??
  \let\-\@dischyph
  \let\'\@acci\let\`\@accii\let\=\@acciii
%  \parindent\z@ \parskip\z@skip    Definitely omit!
%  \everypar{}%  ??
  \linewidth\hsize
%  \@totalleftmargin\z@
%  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
%  \parfillskip\@flushglue \lineskip\normallineskip
%  \baselineskip\normalbaselineskip
  \sloppy
%  \let\\\@normalcr
}

%  Compatibility with previous versions (temporary!):
% psh: we'll remove this 2017-09-21
%\let\fram@d=\MakeFramed  \let\endfram@d=\endMakeFramed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This ends the stuff that's lifted from:
% % framed.sty   v 0.8a   21-Jul-2003
% % Copyright (C) 1992-2003 by Donald Arseneau


%--------------------------------------------------------------------
%--------------------------------------------------------------------

\endinput
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
