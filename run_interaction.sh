## this is basically a copy of run_RDF.sh`
## HEADGROUPS:
SEL='group 1'
###CUTOFF='6'
POPS='resname POPS and name CNO PO4 GL1 GL2'
POPI='resname POPI and name C1 C2 C3 PO4 GL1 GL2'
POPC='resname POPC and name NC3 PO4 GL1 GL2'
POPE='resname POPE and name NH3 PO4 GL1 GL2'
CHOL='resname CHOL'  #do the whole thing, no headgroup here and is always a kind of odd position, might need its own RDF
DPCE='resname DPCE and name AM1 AM2 T1A'
##because of the ordering, I want the protein to be the selection (see gmx pairdist, i want to loop through residue by residue, this makes it easier)

#CERAMIDE simulations first, so that you dont get error
for traj in ../trajectories/xtc_files/GLUT5.?.30.?.xtc
do
	name=`basename ${traj//.xtc}`
	top=../trajectories/tpr_files/$name.tpr
	echo $top

	# gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$REF" -sel 'group 13 and '"$POPC" -o $name.POPC.cutoff6.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions/$name.POPS.6cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions/$name.POPI.6cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions/$name.POPC.6cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions/$name.POPE.6cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions/$name.CHOL.6cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$DPCE" -sel "$SEL" -xvg none -o ../interactions/$name.DPCE.6cutoff.xvg

	### NEW CUTOFF
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions/$name.POPS.4cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions/$name.POPI.4cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions/$name.POPC.4cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions/$name.POPE.4cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions/$name.CHOL.4cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$DPCE" -sel "$SEL" -xvg none -o ../interactions/$name.DPCE.4cutoff.xvg
done


### NO CERAMIDE
for traj in ../trajectories/xtc_files/GLUT5.?.0.?.xtc
do
        name=`basename ${traj//.xtc}`
        top=../trajectories/tpr_files/$name.tpr
        echo $top

        # gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref 'group -sel "$SEL" -xvg none 13 and '"$POPC" -o $name.POPC.6cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions/$name.POPS.6cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions/$name.POPI.6cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions/$name.POPC.6cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions/$name.POPE.6cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 6 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions/$name.CHOL.6cutoff.xvg

	## NEW CUTOFF
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions/$name.POPS.4cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions/$name.POPI.4cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions/$name.POPC.4cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions/$name.POPE.4cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 4 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions/$name.CHOL.4cutoff.xvg

done
