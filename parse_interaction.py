import numpy as np
import pandas as pd
from cutoff_function import dual_cutoff  #dual cutoff script is elsewhere, see below for use

## example file we are using
##gmx pairdist -f ../trajectories/xtc_files/GLUT5.I.30.1.xtc -s ../trajectories/tpr_files/GLUT5.I.30.1.tpr -selgrouping res -refgrouping res -cutoff 6 -o GLUT5.I.30.1.POPI.fortesting.xvg -xvg none 
## output data from this is 5766 characters long- first 15 CHARACTERS are time, I have counted. 
## run make_boolean.sh and then you can run this
## we want the ref to be the lipids, and sel to be the protein, so that we can loop through residue by residue
## since it's r1s1, r2s1, r3s1... r1s2, r2s2, r3s2...

num_residues = 473
test_df = pd.DataFrame(index = np.arange(num_residues))
lipid_names = ['POPI', 'POPS', 'CHOL']
for lipid in lipid_names:
    longs_total = np.loadtxt('../interactions/GLUT5.I.30.1.%s.6cutoff.xvg' %lipid, dtype = bool)
    short_total = np.loadtxt('../interactions/GLUT5.I.30.1.%s.4cutoff.xvg' %lipid, dtype = bool)
    
    num_lipids = int(np.shape(longs_total)[1]/num_residues)
    
    
    residue_start_index = 0
    residue_end_index = num_lipids
    resid_dict = {}  #use this to add to pandas dictionary. Seems easier to add whole dict at end rather than appending to df row by row
    for resid in range(num_residues): #loop through each residue
        resid_short = short_total[:,residue_start_index:residue_end_index]
        resid_long = longs_total[:,residue_start_index:residue_end_index]
        
        lipid_total_counts = []  ## putting entire array together into a list of counts, so no longer by lipid resid type but just lipid type overall
        
        ## loop through each lipid per residue
        for short, longs in zip(resid_short.T, resid_long.T):  #need to transpose because you want to read lipid by lipid, now the x axis is time
            start_read = 0
            counts = []
            #dual_cutoff script can be found in other file. I remove it here for simplicity
            ## all you need is where to start, and it needs the input of two 1D numpy array or LIST, equal length
            ### they should be in the dimension of time. (so per function, one lipid binding to one residue or COM
            ## of protein or whatever). This array should also be boolean
            ## ex an array looking like this: short = [False, False, True, True, False, True], and long = [True, True, True, True, True, True]
            ### will give the output of 4!!! (start at first true in short, and then read long counts)  
            while start_read < len(longs):
                res_time, trigger_start = dual_cutoff(short,longs,start_read)
                start_read = res_time + trigger_start  #continue from residence time + wherever you started from again
                if start_read <= len(longs):
                    counts.append(res_time)
            lipid_total_counts.append(counts) # i like to do it this way so I can double check in the original array that things are correct
        
        ### prepare for DF entry
        lipid_total_counts = np.hstack(lipid_total_counts) #make everything into one array, no longer arranged by lipid type
        resid_dict[resid] = lipid_total_counts
        
        # move onto next set of lipids
        residue_start_index = residue_start_index + num_lipids
        residue_end_index = residue_end_index + num_lipids
        
    ## add to pandas DF!! 
    test_df[lipid] = pd.Series(resid_dict)
    
    