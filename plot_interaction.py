#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 15:56:04 2020

@author: sarahmccomas
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

num_residues = 473
filename = 'GLUT5.I.0'
final_df = pd.DataFrame(index = np.arange(num_residues))
if '30' in filename:
    lipid_names = ['POPC', 'POPE', 'POPS', 'POPI', 'CHOL', 'DPCE']
    #lipid_names = ['POPI']
else:
    lipid_names = ['POPC', 'POPE', 'POPS', 'POPI', 'CHOL']
reps = 3
resid_dict = {}
mean_dict = {}
I0 = pd.read_pickle('../interactions2/%s.interaction_counts.pkl' %filename)

### need to combine the replicas, just read them out to an array, flatten array, and put it back into a DF
## i just keep this DF for record keeping, otherwise we are using the DF of the means for the  plot
new = pd.DataFrame(index = np.arange(num_residues))
mean_df = pd.DataFrame(index = np.arange(num_residues))
for lipid in lipid_names:
    for res in np.arange(0, num_residues):
        combine = I0.loc[res, ['%s.1' %lipid, '%s.2' %lipid, '%s.3' %lipid]]
        combine = np.concatenate(combine)
        resid_dict[res] = combine
        mean_dict[res] = np.mean(combine)
        new[lipid] = pd.Series(resid_dict)
        mean_df[lipid] = pd.Series(mean_dict)

mean_df=mean_df.fillna(0) #need to remove NaN's for plotting, just make them zeros
 ## since the original trajectory is every 10ns, one binding event of 150 for example is 1500ns
 ## I want to represent this in us, therefore *10 and /1000 (== /100) to make 1.5us
mean_df = mean_df/100
#### plotting

#plotting per residue
start_graph = 230
ind1 = np.arange(0,start_graph)       
ind2 = np.arange(start_graph,473)       
width = 1
bot1 = 0
bot2 = 0

fig = plt.figure(figsize=(10,5))
ax1, ax2 = fig.subplots(2,1)

colors = ['#FF6B35', '#33658A', '#86BBD8', '#7BAA34', '#F6AE2D', '000000']
for n, lipid in enumerate(lipid_names):
    ax1.bar(ind1, mean_df.loc[ind1, lipid], width, bottom = bot1, color = colors[n], label = lipid) 
    ax2.bar(ind2, mean_df.loc[ind2, lipid], width, bottom = bot2, color = colors[n], label = lipid)
    ### this plots along the residue range, calling the mean of that range, and taking the bottom value from before
    bot1 = bot1 + mean_df.loc[ind1, lipid]  #increase the bottom every time, so that you stack the lipid types
    bot2 = bot2 + mean_df.loc[ind2, lipid]  #increase the bottom every time, so that you stack the lipid types

ax1.set_xlim(0,start_graph)
ax2.set_xlim(start_graph, 473)
ax1.set_ylim(0, 6)
ax2.set_ylim(0, 6)

#ax2.set_xlabel('Residue index')
#ax2.yaxis.set_label_coords(-0.03,1.5)
#ax2.set_ylabel('Average residence time (us)')
#plt.text(-0.03, 1.2, 'Normalized RDF', rotation =90)

plt.legend(bbox_to_anchor=(1.2,1.5))
#plt.tight_layout()
plt.savefig('per_resid_interaction.%s.png' %filename, dpi = 800, bbox_inches='tight')



#plot per lipid
#plt.bar(np.arange(len(lipid_names)), mean_df.mean(axis=0).tolist(), label = lipid_names, color = colors)
#plt.legend()

