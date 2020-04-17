#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Apr 17 15:32:00 2020

@author: sarahmccomas
"""

import numpy as np

## LOOK, all you really need to know is that you read from where short begins its first true, and then
## you are ONLY looking at longs, as the dual cutoff should. This start_read thing is just so that
## you can continue where you left off
def dual_cutoff(short,longs,start_read):
    
    ###where to start read###
    if np.any(np.where(short)[0] > start_read):  ## if you haven't reached the end of the array, keep reading
        event_trigger = np.where(np.where(short)[0] > start_read)[0][0]    #find starting location of read. If == 10, all values to 10 will be False, so you can start where you left off
        start_where_long = np.where(short)[0][event_trigger]  #THIS IS the actual starting point, after your start_read, where is the next True?? 
        events_indices = np.where(longs[start_where_long:])[0]
        events_indices = np.append(events_indices,0) #array, starting at index start_where_long. If longs looks like [True, True, True, False, True], then
                    ### events_indices will look like [0, 1, 2, 4], meaning lipid left after 3 frames, and residence time should stop at n = 3. We add a zero to the last frame
                    ### so that if we are at the end of traj and longs looks like [True, True, True], then we will count all those 3 residence times at the end.
    
    ###actual counting ###
        for frame_num, event_index in enumerate(events_indices):
            if event_index + 1 != events_indices[frame_num+1]: #we add + 1 here because frame_num starts at 0, and we want to count that as a res time
                print(frame_num + 1, '= length of binding')
                break       #stop as soon as you don't have a match in the following frame. Frame_num was our counter, so we just return this value as the residence time for this event
        return frame_num + 1, start_where_long #we want to know residence time, and where to continue from
   
    ##if you finish the run###
    else:
        print('no more binding events found')
        return len(longs)+1, 0   #this will then be longer than longs, breaking the while loop below. It's important that it doesn't == longs because sometimes we end
                                             ### at the length of longs, and these should be accounted for (ie, things that stay bound)

