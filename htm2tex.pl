#! /bin/perl

$hdr  = qq(\\documentclass[letterpaper]{article}\n);
$hdr .= qq(\\usepackage{multicol}\n);
$hdr .= qq(\\usepackage[left=2cm,top=2cm,bottom=2cm,right=2cm,nohead,nofoot]{geometry}\n);
$hdr .= qq(\\usepackage{enumerate}\n);
$hdr .= qq(\\renewcommand{\\baselinestretch}{4}\n);
$hdr .= qq(\\begin{document}\n);
#$hdr .= qq(\\LARGE\n);

while (<>) { s!\s+$!\n!; $htm .= $_ }
$htm =~ s!<center><h2>Text</h2></center>!$hdr!;

$mid  = qq(\\renewcommand{\\baselinestretch}{1}\n);
$mid .= qq(\\begin{multicols}{2}\n);
$mid .= qq(\\small\n);
$mid .= qq(\\section*{Vocabulary}\n);
$mid .= qq(\\begin{description}\n);

$htm =~ s!<center><h2>Vocabulary</h2></center>!$mid!;

$mid  = qq(\\end{description}\n);
$mid .= qq(\\section*{Grammar}\n);
$mid .= qq(\\begin{description}\n);
$htm =~ s!<center><h2>Grammar</h2></center>!$mid!;
$htm =~ s!<br ?/?>!\n\n!gi;

$htm =~ s!\&([a-z]+)\;! \$\\\1\$ !gs;
$htm =~ s!\\sigmaf!\\sigma!gs;
$htm =~ s!\\omicron! o!gs;
$htm =~ s!\$\s*\$!!gs;
$htm =~ s! \$! \\LARGE \$!gs;
$htm =~ s!\$ !\$ \\normalsize !gs;
$htm =~ s!\\LARGE\s*\$\s*\\normalsize\s*!\\LARGE \$!gs;

#while ($htm =~ m!(\$.*?\$)\s+.normalsize\s+(\d+)!gs) 
#{ $word{$2} = $1 }
#while ($htm =~ m!\d+\s+(\d+)\s+([\-A-Z]+)!gs)
#{ $word{$1} = $2 }



$htm =~ s!<OL TYPE\=\"\d\"!<OL TYPE=\"1\"!gs;
$htm =~ s!<OL TYPE\=\"[a-z]\"!<OL TYPE\=\"a\"!gs;
$htm =~ s!<OL TYPE\=\"(.)\">!\\begin{enumerate}[$1]!gs;
$htm =~ s!<LI>(.*?)!\\item $1!gs;
$htm =~ s!</LI>!!gs;
$htm =~ s!</OL>!\\end{enumerate}!gs;

$htm =~ s!\&!\\\&!gs;

$htm =~ s!([^\w])\\([a-zA-Z]+)\\([^\w])!$1 ``$2'' $3!gs;

$htm =~ s!<p><b>(\d+)\:</b>!\\item[$1]!gs;
$htm =~ s!<p><b>(\d+)\:\s*(\S+)</b>!\\item[$1] \$$2\$!gs;
$htm =~ s!\&\#255;!\ddot{y}!gs;
# why aren't these working?
$htm =~ s!\&\#275;!overline\{e\}!gs;
$htm =~ s!\&\#333;!overline\{o\}!gs;
#$htm =~ s!\\\&\#275;!e!gs;
#$htm =~ s!\\\&\#333;!o!gs;
$htm =~ s!<p><b>(.*?)</b>!\\item[$1]!gs;

$htm .= "\\end{description}\n";
$htm .= "\\end{multicols}\n";
$htm .= "\\end{document}\n";

$htm =~ s!\\begin\{description\}\s*\\end\{description\}!!gs;
$htm =~ s!\\section\*\{Grammar\}\s*\\end\{multicols}!\\end\{multicols\}!gs;

print $htm;
