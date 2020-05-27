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
filename = 'GLUT5.O.0'
final_df = pd.DataFrame(index = np.arange(num_residues))
if '30' in filename:
    lipid_names = ['POPC', 'POPE', 'POPS', 'CHOL', 'POPI', 'DPCE']
    #lipid_names = ['POPI']
else:
    lipid_names = ['POPC', 'POPE', 'POPS', 'CHOL', 'POPI']
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

#### plotting

#plotting per residue
ind1 = np.arange(0,230)       
ind2 = np.arange(230,473)       
width = 1
bot1 = 0
bot2 = 0

fig, (ax1, ax2) = plt.subplots(2,1)

colors = ['red', 'green', 'orange', 'blue', 'purple', 'black']
for n, lipid in enumerate(lipid_names):
    ax1.bar(ind1, mean_df.loc[ind1, lipid], width, bottom = bot1, color = colors[n], label = lipid) 
    ax2.bar(ind2, mean_df.loc[ind2, lipid], width, bottom = bot2, color = colors[n], label = lipid)
    ### this plots along the residue range, calling the mean of that range, and taking the bottom value from before
    bot1 = bot1 + mean_df.loc[ind1, lipid]  #increase the bottom every time, so that you stack the lipid types
    bot2 = bot2 + mean_df.loc[ind2, lipid]  #increase the bottom every time, so that you stack the lipid types

'''
#plotting per residue
ind = np.arange(473)       
width = 1
bot = 0

mean_df=mean_df.fillna(0)
colors = ['red', 'green', 'orange', 'blue', 'purple', 'black']
for n, lipid in enumerate(lipid_names):
    plt.bar(ind, mean_df.loc[ind, lipid], width, bottom = bot, color = colors[n], label = lipid) 
    ### this plots along the residue range, calling the mean of that range, and taking the bottom value from before
    bot = bot + mean_df.loc[ind, lipid]  #increase the bottom every time, so that you stack the lipid types
    print(bot)

'''

plt.legend()
plt.tight_layout()
plt.savefig('per_resid_interaction.%s.png' %filename, dpi = 800)



#plot per lipid
#plt.bar(np.arange(len(lipid_names)), mean_df.mean(axis=0).tolist(), label = lipid_names, color = colors)
#plt.legend()

