# gksheets: Greek translation worksheets

Create translation worksheets of new testament passages for greek newbies. Run like this:

  worksheets.pl 1:1 1:2 JOH.BP5 > jn11.htm
  htm2tex.pl jn11.htm > jn11.tex
  pdflatex jn11.tex

Where the second argument of worksheets.pl (in this case 1:2) is the verse
_after_ the last verse of the passage.

The resulting translation worksheet (the original html, or the conversion to pdf
using LaTeX) has Strong's numbers after each greek word, and will include a
mini-lexicon of just those Strong's numbers.

Strong's lexicon entries will be cached in subdirectory strongs/, so subsequent
worksheets can be created faster.

three_sixteens.csh generates all the 16th verses after 3:1 in the New Testament,
for use in teaching through Donald Knuth's book 3:16. (It uses my script multi,
which can be found in my other repo
[RubeRadPerl](https://github.com/RubeRad/RubeRadPerl).
