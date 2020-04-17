## first make the first line something else so you don't replace it later or get confused
sed -i '' 's/^.........../TIME/g' GLUT5.I.30.1.POPI.4cutoff.xvg

#replace cutoff
sed -i '' 's/6.000/0/g' GLUT5.I.30.1.POPI.4cutoff.xvg

#change everything else
sed -i '' 's/[0-9].[0-9][0-9][0-9]*/1/g' GLUT5.I.30.1.POPI.4cutoff.xvg

#now change the time again, just to zero, then it won't be counted. Makes loading the array much faster
sed -i '' 's/TIME//g' GLUT5.I.30.1.POPI.4cutoff.xvg
