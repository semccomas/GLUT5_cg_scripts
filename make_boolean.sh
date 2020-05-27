for f in ../interactions2/*7cutoff*.xvg
do
## first make the first line something else so you don't replace it later or get confused
sed -i 's/^.........../TIME/g' $f

#replace cutoff
sed -i 's/0.700/0/g' $f

#change everything else
sed -i 's/[0-9].[0-9][0-9][0-9]*/1/g' $f

#now change the time again, just to zero, then it won't be counted. Makes loading the array much faster
sed -i 's/TIME//g' $f

done


for f in ../interactions2/*13cutoff*.xvg
do
## first make the first line something else so you don't replace it later or get confused
sed -i 's/^.........../TIME/g' $f

#replace cutoff
sed -i 's/1.300/0/g' $f

#change everything else
sed -i 's/[0-9].[0-9][0-9][0-9]*/1/g' $f

#now change the time again, just to zero, then it won't be counted. Makes loading the array much faster
sed -i 's/TIME//g' $f

done
