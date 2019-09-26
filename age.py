#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 26 13:33:17 2019

@author: younessubhi
"""

"""
This script calculates two things:
(i) mean age (including standard derivation) for participants
(ii) fatigue level of participants
"""

import numpy as np
import matplotlib.pyplot as plt
from tabulate import tabulate
import pandas as pd
import ptitprince as pt

# age
ageMale = [25, 22, 25, 19, 22, 23, 21, 23, 24, 23]
ageFemale = [24, 24, 21, 20, 24, 21]
ageBoth = ageMale + ageFemale

np_ageBoth = np.array(ageBoth)

mean_ageBoth = np.mean(ageBoth)
std_ageBoth = np.std(ageBoth)

# fatigue
prefatigue = [5, 6, 5, 5, 4, 3, 4, 5, 4, 4, 5, 4, 5, 6, 4, 5]
taskfatigue = [4, 4, 6, 2, 6, 6, 6, 4, 5, 3, 4, 5, 4, 6, 4, 3]
postfatigue = [3, 6, 4, 3, 6, 6, 5, 6, 4, 2, 3, 5, 4, 5, 3, 3]

np_prefatigue = np.array(prefatigue)
np_taskfatigue = np.array(taskfatigue)
np_postfatigue = np.array(postfatigue)

preMale = np_prefatigue[:10]
taskMale = np_taskfatigue[:10]
postMale = np_postfatigue[:10]

preFemale = np_prefatigue[10:16]
taskFemale = np_taskfatigue[10:16]
postFemale = np_postfatigue[10:16]

# fatigue on both
print('FATIGUE FOR BOTH')

meanBothPre = np.mean(np_prefatigue)
stdBothPre = np.std(np_prefatigue)
print('Both Pre_Fatigue')
print(meanBothPre)
print(stdBothPre)

meanBothTask = np.mean(np_taskfatigue)
stdBothTask = np.std(np_taskfatigue)
print('Both Task_Fatigue')
print(meanBothTask)
print(stdBothTask)

meanBothPost = np.mean(np_postfatigue)
stdBothPost = np.std(np_postfatigue)
print('Both Post_Fatigue')
print(meanBothPost)
print(stdBothPost)

# fatigue levels for men

print('FATIGUE FOR MEN')

meanMalePre = np.mean(preMale)
stdMalePre = np.std(preMale)
print('Male Pre_Fatigue')
print(meanMalePre)
print(stdMalePre)

meanMaleTask = np.mean(taskMale)
stdMaleTask = np.std(taskMale)
print('Male Task_Fatigue')
print(meanMaleTask)
print(stdMaleTask)

meanMalePost = np.mean(postMale)
stdMalePost = np.std(postMale)
print('Male Post_Fatigue')
print(meanMalePost)
print(stdMalePost)

# fatigue levels for women

print('FATIGUE FOR WOMEN')

meanFemalePre = np.mean(preFemale)
stdFemalePre = np.std(preFemale)
print('Female Pre_Fatigue')
print(meanFemalePre)
print(stdFemalePre)

meanFemaleTask = np.mean(taskFemale)
stdFemaleTask = np.std(taskFemale)
print('Female Task_Fatigue')
print(meanFemaleTask)
print(stdFemaleTask)

meanFemalePost = np.mean(postFemale)
stdFemalePost = np.std(postFemale)
print('Female Post_Fatigue')
print(meanFemalePost)
print(stdFemalePost)

# table for fatigue data

m = np.array([['Male', meanMalePre, stdMalePre,
               meanMaleTask, stdMaleTask,
               meanMalePost, stdMalePost],
                ['Female', meanFemalePre, stdFemalePre,
                 meanFemaleTask, stdFemaleTask,
                 meanFemalePost, stdFemalePost]])
headers = ['Group', 'Fatigue before tasks (mean)',
           'Fatigue before tasks (std)',
           'Fatigue while performing tasks (mean)',
           'Fatigue while performing tasks (std)',
           'Fatigue after tasks (mean)',
           'Fatigue after tasks (std)']

table = tabulate(m, headers, tablefmt='fancy_grid')

# print(table)

# trying with pandas for better print and exportable version

pd_fatigue = pd.DataFrame({'Group': m[:, 0], 'Fatigue before tasks (mean)':m[:, 1],
           'Fatigue before tasks (std)': m[:, 2],
           'Fatigue while performing tasks (mean)': m[:,3],
           'Fatigue while performing tasks (std)': m[:,4],
           'Fatigue after tasks (mean)': m[:,5],
           'Fatigue after tasks (std)': m[:,6]})
    
print(pd_fatigue)

# raincloud plot

# put into arrays

meansBoth = np.array([meanBothPre, meanBothTask, meanBothPost])
meansMale = np.array([meanMalePre, meanMaleTask, meanMalePost])
meansFemale = np.array([meanFemalePre, meanFemaleTask, meanFemalePost])

stdsBoth = np.array([stdBothPre, stdBothTask, stdBothPost])
stdsMale = np.array([stdMalePre, stdMaleTask, stdMalePost])
stdsFemale = np.array([stdFemalePre, stdFemaleTask, stdFemalePost])

# build plot
preRow = np.array([np_prefatigue, preFemale, preMale])
taskrow = np.array([np_taskfatigue, taskFemale, taskMale])
postRow = np.array([np_postfatigue, postFemale, postMale])

bothCol = (np_prefatigue, np_taskfatigue, np_postfatigue)
maleCol = np.array([preMale, taskMale, postMale])
femaleCol = np.array([preFemale, taskFemale, postFemale])

#df_RC_rows = pd.DataFrame({'Both':[bothCol], 'Female':[femaleCol],
#                           'Male':[maleCol], 'ylabel':[labelCol],
#                           'group':[groupCol]})

bothMatrix = np.asmatrix(bothCol)
femaleMatrix = np.asmatrix(femaleCol)
maleMatrix = np.asmatrix(maleCol)
category = np.array([['Pre'], ['Task'], ['Post']])


## from the beginning

# make pd df that has 'group' and 'fatigue'
tpre = [('male', 'pre', 5),
               ('male', 'pre', 6),
               ('male', 'pre', 5),
               ('male', 'pre', 5),
               ('male', 'pre', 4),
               ('male', 'pre', 3),
               ('male', 'pre', 4),
               ('male', 'pre', 5),
               ('male', 'pre', 4),
               ('male', 'pre', 4),
               ('female', 'pre', 5),
               ('female', 'pre', 4),
               ('female', 'pre', 5),
               ('female', 'pre', 6),
               ('female', 'pre', 4),
               ('female', 'pre', 5),
               ('male', 'task', 4),
               ('male', 'task', 4),
               ('male', 'task', 6),
               ('male', 'task', 2),
               ('male', 'task', 6),
               ('male', 'task', 6),
               ('male', 'task', 6),
               ('male', 'task', 4),
               ('male', 'task', 5),
               ('male', 'task', 3),
               ('female', 'task', 4),
               ('female', 'task', 5),
               ('female', 'task', 4),
               ('female', 'task', 6),
               ('female', 'task', 4),
               ('female', 'task', 3),
               ('male', 'post', 3),
               ('male', 'post', 6),
               ('male', 'post', 4),
               ('male', 'post', 3),
               ('male', 'post', 6),
               ('male', 'post', 6),
               ('male', 'post', 5),
               ('male', 'post', 6),
               ('male', 'post', 4),
               ('male', 'post', 2),
               ('female', 'post', 3),
               ('female', 'post', 5),
               ('female', 'post', 4),
               ('female', 'post', 5),
               ('female', 'post', 3),
               ('female', 'post', 3)]

tpre_male = [('male', 'pre', 5),
               ('male', 'pre', 6),
               ('male', 'pre', 5),
               ('male', 'pre', 5),
               ('male', 'pre', 4),
               ('male', 'pre', 3),
               ('male', 'pre', 4),
               ('male', 'pre', 5),
               ('male', 'pre', 4),
               ('male', 'pre', 4),
               ('male', 'task', 4),
               ('male', 'task', 4),
               ('male', 'task', 6),
               ('male', 'task', 2),
               ('male', 'task', 6),
               ('male', 'task', 6),
               ('male', 'task', 6),
               ('male', 'task', 4),
               ('male', 'task', 5),
               ('male', 'task', 3),
               ('male', 'post', 3),
               ('male', 'post', 6),
               ('male', 'post', 4),
               ('male', 'post', 3),
               ('male', 'post', 6),
               ('male', 'post', 6),
               ('male', 'post', 5),
               ('male', 'post', 6),
               ('male', 'post', 4),
               ('male', 'post', 2)]

tpre_female = [('female', 'pre', 5),
               ('female', 'pre', 4),
               ('female', 'pre', 5),
               ('female', 'pre', 6),
               ('female', 'pre', 4),
               ('female', 'pre', 5),
               ('female', 'task', 4),
               ('female', 'task', 5),
               ('female', 'task', 4),
               ('female', 'task', 6),
               ('female', 'task', 4),
               ('female', 'task', 3),
               ('female', 'post', 3),
               ('female', 'post', 5),
               ('female', 'post', 4),
               ('female', 'post', 5),
               ('female', 'post', 3),
               ('female', 'post', 3)]

participant_ID = [('male1'),
                  ('male2'),
                  ('male3'),
                  ('male4'),
                  ('male5'),
                  ('male6'),
                  ('male7'),
                  ('male8'),
                  ('male9'),
                  ('male10'),
                  ('female1'),
                  ('female2'),
                  ('female3'),
                  ('female4'),
                  ('female5'),
                  ('female6'),
                  ('male1'),
                  ('male2'),
                  ('male3'),
                  ('male4'),
                  ('male5'),
                  ('male6'),
                  ('male7'),
                  ('male8'),
                  ('male9'),
                  ('male10'),
                  ('female1'),
                  ('female2'),
                  ('female3'),
                  ('female4'),
                  ('female5'),
                  ('female6'),
                  ('male1'),
                  ('male2'),
                  ('male3'),
                  ('male4'),
                  ('male5'),
                  ('male6'),
                  ('male7'),
                  ('male8'),
                  ('male9'),
                  ('male10'),
                  ('female1'),
                  ('female2'),
                  ('female3'),
                  ('female4'),
                  ('female5'),
                  ('female6')]

df_tpre = pd.DataFrame(tpre, columns=['sex','group','fatigue'])
df_ID = pd.DataFrame(participant_ID,columns=['ID'])
df_tpre['ID'] = participant_ID

df_tpre_male = pd.DataFrame(tpre_male, columns=['sex1','group1','fatigue1'])
df_tpre_female = pd.DataFrame(tpre_female, columns=['sex2','group2','fatigue2'])


#make it rain
plt.subplot()
ax = pt.RainCloud(x = 'group', y = 'fatigue',
                  data = df_tpre,
                  pointplot = True,
                  width_viol = 2,
                  width_box = .1,
                  orient = 'h',
                  move = .0)
plt.subplot

ax1 = pt.RainCloud(x = 'group1', y = 'fatigue1',
                  data = df_tpre_male,
                  pointplot = True,
                  width_viol = 2,
                  width_box = .1,
                  orient = 'h',
                  move = .0)

ax2 = pt.RainCloud(x = 'group2', y = 'fatigue2',
                  data = df_tpre_female,
                  pointplot = True,
                  
                  width_viol = 2,
                  width_box = .1,
                  orient = 'h',
                  move = .0)
plt.subplot

plt.show()
