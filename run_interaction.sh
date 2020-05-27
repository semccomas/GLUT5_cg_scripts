## this is basically a copy of run_RDF.sh`
## HEADGROUPS:
SEL='group 1'
###CUTOFF='1.3'
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

	# gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$REF" -sel 'group 13 and '"$POPC" -o $name.POPC.cutoff13.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions2/$name.POPS.13cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions2/$name.POPI.13cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions2/$name.POPC.13cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions2/$name.POPE.13cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions2/$name.CHOL.13cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$DPCE" -sel "$SEL" -xvg none -o ../interactions2/$name.DPCE.13cutoff.xvg

	### NEW CUTOFF
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions2/$name.POPS.7cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions2/$name.POPI.7cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions2/$name.POPC.7cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions2/$name.POPE.7cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions2/$name.CHOL.7cutoff.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$DPCE" -sel "$SEL" -xvg none -o ../interactions2/$name.DPCE.7cutoff.xvg
done


### NO CERAMIDE
for traj in ../trajectories/xtc_files/GLUT5.?.0.?.xtc
do
        name=`basename ${traj//.xtc}`
        top=../trajectories/tpr_files/$name.tpr
        echo $top

        # gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref 'group -sel "$SEL" -xvg none 13 and '"$POPC" -o $name.POPC.13cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions2/$name.POPS.13cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions2/$name.POPI.13cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions2/$name.POPC.13cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions2/$name.POPE.13cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 1.3 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions2/$name.CHOL.13cutoff.xvg

	## NEW CUTOFF
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPS" -sel "$SEL" -xvg none -o ../interactions2/$name.POPS.7cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPI" -sel "$SEL" -xvg none -o ../interactions2/$name.POPI.7cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPC" -sel "$SEL" -xvg none -o ../interactions2/$name.POPC.7cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$POPE" -sel "$SEL" -xvg none -o ../interactions2/$name.POPE.7cutoff.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping res -cutoff 0.7 -ref "$CHOL" -sel "$SEL" -xvg none -o ../interactions2/$name.CHOL.7cutoff.xvg

done
