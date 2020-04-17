#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Mar  5 16:23:15 2020

@author: semccomas
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

simulation_names = ['I.0', 'O.0', 'I.30', 'O.30']
lipid_names_start = ['POPC', 'POPE', 'POPS', 'POPI', 'CHOL', 'DPCE'] 
# I have checked and 25 is always the start at 0.000 0.000!! 
#Also checked spacing should be consistent. Engine thing was some error from python


def combine_replicas(simulation, lipid):
    rep1 = pd.read_csv('../RDF/GLUT5.%s.1.%s_head.xvg' %(simulation, lipid), skiprows = 25, delim_whitespace = True,  names =['key','rep1']) 
    rep2 = pd.read_csv('../RDF/GLUT5.%s.2.%s_head.xvg' %(simulation, lipid), skiprows = 25, delim_whitespace = True,  names =['key','rep2']) 
    rep3 = pd.read_csv('../RDF/GLUT5.%s.3.%s_head.xvg' %(simulation, lipid), skiprows = 25, delim_whitespace = True,  names =['key','rep3']) 

    #set index, for some reason this was giving big trouble when making index in read csv so just do it this way
    rep1 = rep1.set_index('key')
    rep2 = rep2.set_index('key')
    rep3 = rep3.set_index('key')
    combine = rep1.join([rep2, rep3], how = 'inner') #join all 3 columns together, remove nan's (=> take smallest value, not all RDFs go to same box length)
    combine = combine.mean(axis=1).rename(simulation + '-' + lipid, axis = 'columns')  #take the mean of the replicas
    return combine


############################################################    
############################################################    
############################################################    
### COMBINE replicas, make into neat dataframes to process later. Final out from this section is the list below, means_by_simulation
means_by_simulation = []  # a list, one element per simulation type (=> 4x), each with their respective dataframes inside
for simulation in simulation_names:
    if '30' not in simulation:
        lipid_names = lipid_names_start[:-1]    # if no DPCE in simulations, skip it!!! 
    else:
        lipid_names = lipid_names_start
        
    for n,lipid in enumerate(lipid_names):    
        if n == 0:    # need to start the pandas series somehow
            mean = combine_replicas(simulation, lipid)
        else:
            mean = pd.concat((mean, combine_replicas(simulation, lipid)), axis = 1)   #and then just keep appending to it each time once you've started
    means_by_simulation.append(mean)
    
############################################################    
############################################################    
############################################################    

    
###### PLOT 1 - 4 boxes, one box per condition, with all lipid types inside, colored by lipid
fig, axs = plt.subplots(2,2, sharex=True, sharey=True)
location_list = [(0,0), (0,1), (1,0), (1,1)]
color_l = ['#FF6B35', '#33658A', '#86BBD8', '#7BAA34', '#F6AE2D', '000000']

for n,df in enumerate(means_by_simulation): 
    ax = df.plot(color = color_l, ax=axs[location_list[n]], legend=False)
    y_upper = 11
    ax.set_xlim(0,6)
    ax.set_ylim(0,y_upper)
    ax.set_yticks(np.arange(0,y_upper,2))
    ax.set_xlabel('   ')  #can't make this disappear in pandas without just putting in a filler, added text above it later in script
    ax.set_title(simulation_names[n])
#for ax in fig.get_axes():
#    ax.label_outer()

plt.tight_layout(rect=[0,0,1.4,1.4]) # Ok I really dont know why but don't change these values to be lower than 1.4, everything gets weird...
plt.legend(bbox_to_anchor=(1.7,1.6))
plt.text(-1.8,-4, 'Distance from protein')
plt.text(-7.6, 14, 'Normalized RDF', rotation =90)  #where these numbers come from I have no clue but they work.. 
plt.savefig('test', bbox_inches='tight', dpi = 900)






###### PLOT 2 - one box per lipid, colored by simulation. 