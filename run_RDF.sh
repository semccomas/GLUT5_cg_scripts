### change directory name for output

## doing for headgroups and for certain residues that are close to lipid bilayer
## HEADGROUPS:
POPS='resname POPS and name CNO PO4 GL1 GL2'
POPI='resname POPI and name C1 C2 C3 PO4 GL1 GL2'
POPC='resname POPC and name NC3 PO4 GL1 GL2'
POPE='resname POPE and name NH3 PO4 GL1 GL2'
CHOL='resname CHOL'  #do the whole thing, no headgroup here and is always a kind of odd position, might need its own RDF
DPCE='resname DPCE and name AM1 AM2 T1A'


#CERAMIDE simulations first, so that you dont get error
for traj in ../trajectories/xtc_files/GLUT5.?.30.?.xtc
do
	name=`basename ${traj//.xtc}`
	top=../trajectories/tpr_files/$name.tpr
	echo $top
	
	#gmx rdf -f $traj -s $top -ref 1 -sel 'group 13 and '"$POPC" -o $name.POPC_head.xvg
	gmx rdf -f $traj -s $top -ref 1 -sel "$POPS" -o ../RDF/$name.POPS_head.xvg
	gmx rdf -f $traj -s $top -ref 1 -sel "$POPI" -o ../RDF/$name.POPI_head.xvg
	gmx rdf -f $traj -s $top -ref 1 -sel "$POPC" -o ../RDF/$name.POPC_head.xvg
	gmx rdf -f $traj -s $top -ref 1 -sel "$POPE" -o ../RDF/$name.POPE_head.xvg
	gmx rdf -f $traj -s $top -ref 1 -sel "$CHOL" -o ../RDF/$name.CHOL_head.xvg
	gmx rdf -f $traj -s $top -ref 1 -sel "$DPCE" -o ../RDF/$name.DPCE_head.xvg
done


### NO CERAMIDE
for traj in ../trajectories/xtc_files/GLUT5.?.0.?.xtc
do
        name=`basename ${traj//.xtc}`
        top=../trajectories/tpr_files/$name.tpr
        echo $top

        #gmx rdf -f $traj -s $top -ref 1 -sel 'group 13 and '"$POPC" -o $name.POPC_head.xvg
        gmx rdf -f $traj -s $top -ref 1 -sel "$POPS" -o ../RDF/$name.POPS_head.xvg
        gmx rdf -f $traj -s $top -ref 1 -sel "$POPI" -o ../RDF/$name.POPI_head.xvg
        gmx rdf -f $traj -s $top -ref 1 -sel "$POPC" -o ../RDF/$name.POPC_head.xvg
        gmx rdf -f $traj -s $top -ref 1 -sel "$POPE" -o ../RDF/$name.POPE_head.xvg
        gmx rdf -f $traj -s $top -ref 1 -sel "$CHOL" -o ../RDF/$name.CHOL_head.xvg
done



