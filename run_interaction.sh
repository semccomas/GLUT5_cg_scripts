## this is basically a copy of run_RDF.sh`
## HEADGROUPS:
SEL='group 1'
CUTOFF='6'
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

	# gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$REF" -sel 'group 13 and '"$POPC" -o $name.POPC_head.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPS" -sel $SEL -o ../interactions/$name.POPS_head.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPI" -sel $SEL -o ../interactions/$name.POPI_head.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPC" -sel $SEL -o ../interactions/$name.POPC_head.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPE" -sel $SEL -o ../interactions/$name.POPE_head.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$CHOL" -sel $SEL -o ../interactions/$name.CHOL_head.xvg
	 gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$DPCE" -sel $SEL -o ../interactions/$name.DPCE_head.xvg
done


### NO CERAMIDE
for traj in ../trajectories/xtc_files/GLUT5.?.0.?.xtc
do
        name=`basename ${traj//.xtc}`
        top=../trajectories/tpr_files/$name.tpr
        echo $top

        # gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref 'group -sel $SEL 13 and '"$POPC" -o $name.POPC_head.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPS" -sel $SEL -o ../interactions/$name.POPS_head.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPI" -sel $SEL -o ../interactions/$name.POPI_head.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPC" -sel $SEL -o ../interactions/$name.POPC_head.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$POPE" -sel $SEL -o ../interactions/$name.POPE_head.xvg
         gmx pairdist -f $traj -s $top -selgrouping res -refgrouping all -cutoff $CUTOFF -ref "$CHOL" -sel $SEL -o ../interactions/$name.CHOL_head.xvg
done
