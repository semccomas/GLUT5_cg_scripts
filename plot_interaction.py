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
    lipid_names = ['POPC', 'POPE', 'POPS', 'CHOL', 'POPI', 'DPCE']
    #lipid_names = ['POPI']
else:
    lipid_names = ['POPC', 'POPE', 'POPS', 'CHOL', 'POPI']
reps = 3
resid_dict = {}
mean_dict = {}
I0 = pd.read_pickle('../interactions/%s.interaction_counts.pkl' %filename)

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
'''
ind = np.arange(473)       
width = 1
bot = 0
colors = ['red', 'green', 'orange', 'blue', 'purple', 'black']
for n, lipid in enumerate(lipid_names):
    plt.bar(ind, mean_df.loc[ind, lipid], width, bottom = bot, color = colors[n], label = lipid)
    bot = bot + mean_df.loc[ind, lipid]

plt.legend()
plt.tight_layout()
plt.clf()

'''

plt.bar(np.arange(len(lipid_names)), mean_df.mean(axis=0).tolist())

