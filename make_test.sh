gmx pairdist -f ../trajectories/xtc_files/GLUT5.I.30.1.xtc -s ../trajectories/tpr_files/GLUT5.I.30.1.tpr -selgrouping res -refgrouping res -cutoff 4 -o GLUT5.I.30.1.POPI.4cutoff.xvg -xvg none -ref 'resname POPI and name C1 C2 C3 PO4 GL1 GL2' -sel 'group 1'

## first make the first line something else so you don't replace it later or get confused
sed -i '' 's/^.........../TIME/g' GLUT5.I.30.1.POPI.4cutoff.xvg

#replace cutoff
sed -i '' 's/4.000/0/g' GLUT5.I.30.1.POPI.4cutoff.xvg

#change everything else
sed -i '' 's/[0-9].[0-9][0-9][0-9]*/1/g' GLUT5.I.30.1.POPI.4cutoff.xvg

#now change the time again, just to zero, then it won't be counted. Makes loading the array much faster
sed -i '' 's/TIME//g' GLUT5.I.30.1.POPI.4cutoff.xvg


gmx pairdist -f ../trajectories/xtc_files/GLUT5.I.30.1.xtc -s ../trajectories/tpr_files/GLUT5.I.30.1.tpr -selgrouping res -refgrouping res -cutoff 6 -o GLUT5.I.30.1.POPI.6cutoff.xvg -xvg none -ref 'resname POPI and name C1 C2 C3 PO4 GL1 GL2' -sel 'group 1'

## first make the first line something else so you don't replace it later or get confused
sed -i '' 's/^.........../TIME/g' GLUT5.I.30.1.POPI.6cutoff.xvg

#replace cutoff
sed -i '' 's/6.000/0/g' GLUT5.I.30.1.POPI.6cutoff.xvg

#change everything else
sed -i '' 's/[0-9].[0-9][0-9][0-9]*/1/g' GLUT5.I.30.1.POPI.6cutoff.xvg

#now change the time again, just to zero, then it won't be counted. Makes loading the array much faster
sed -i '' 's/TIME//g' GLUT5.I.30.1.POPI.6cutoff.xvg
