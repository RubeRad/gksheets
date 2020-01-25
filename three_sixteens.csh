worksheet.pl 3:16 3:17 MT.BP5  > matt.3.16.html
worksheet.pl 3:16 3:17 MR.BP5  > mark.3.16.html
worksheet.pl 3:16 3:17 LU.BP5  > luke.3.16.html
worksheet.pl 3:16 3:17 JOH.BP5 > john.3.16.html
worksheet.pl 3:16 3:17 AC.BP5  > acts.3.16.html
worksheet.pl 3:16 3:17 RO.BP5  > rom.3.16.html
worksheet.pl 3:16 3:17 1CO.BP5 > 1cor.3.16.html
worksheet.pl 3:16 3:17 2CO.BP5 > 2cor.3.16.html
worksheet.pl 3:16 3:17 GA.BP5  > gal.3.16.html
worksheet.pl 3:16 3:17 EPH.BP5 > eph.3.16.html
worksheet.pl 3:16 3:17 PHP.BP5 > phil.3.16.html
worksheet.pl 3:16 3:17 COL.BP5 > col.3.16.html
worksheet.pl 4:3  4:4  1TH.BP5 > 1th.4.3.html
worksheet.pl 3:16 3:17 2TH.BP5 > 2th.3.16.html
worksheet.pl 3:16 4:1  1TI.BP5 > 1tim.3.16.html
worksheet.pl 3:16 3:17 2TI.BP5 > 2tim.3.16.html
worksheet.pl 3:16 3:17 HEB.BP5 > heb.3.16.html
worksheet.pl 3:16 3:17 JAS.BP5 > jam.3.16.html
worksheet.pl 3:16 3:17 1PE.BP5 > 1pet.3.16.html
worksheet.pl 3:16 3:17 2PE.BP5 > 2pet.3.16.html
worksheet.pl 3:16 3:17 1JO.BP5 > 1jo.3.16.html
worksheet.pl 3:16 3:17 RE.BP5  > rev.3.16.html

multi -r htm2tex.pl html tex *.*.*.html

multi -1 pdflatex tex *.tex
