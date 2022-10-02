'''
File: PythonForDataAnalysis_part2.py
Author: Tim Bogomolov
Email: timofei.bogomolov@unisa.edu.au
Description: Python for Data Analysis
'''

###########################################################
# Numpy
# http://docs.scipy.org/doc/numpy/reference/index.html

'''
 Fast vectorised array operations for data munging and cleaning, subsetting 
 and filtering, transformation, and any other kinds of computations 
 
 Efficient descriptive statistics and aggregating/summarising data
 
 Data alignment and relational data manipulations for merging and 
 joining together heterogeneous data sets 
 
 Expressing conditional logic as array expressions instead of loops 
 with if-elif-else branches 
 
 Groupwise data manipulations (aggregation, transformation, 
 function application) – useful for pandas!
'''

import numpy as np

data = np.array([[5,-10,2], [4, 3, 9]])
type(data)
data

data * 10

data * data

dir(data)

data.size
data.ndim
data.shape
data.dtype

# create numpy array

np.zeros(10)

np.zeros((3,5,3))
np.ones((3,6))

np.empty((2,3))

np.arange(15)

a = np.zeros((3,6))
np.ones_like(a)

np.ones(a.shape)

np.eye(4)



# numpy data types and conversions

a = np.array([1.1,2.2,3.3,4,5])
a.dtype

b = a.astype(np.int64)
b.dtype

c = np.array(["aaaaa",2,3,4,4], dtype=np.string_)
c.dtype

c.astype(float)


int_array = np.arange(10)
float_array = np.array([.2, .27, .357])
int_array.astype(float_array.dtype)


###########################################################
# Slicing and Indexing

# Numpy slicing in 1D

arr = np.arange(10)
print(arr)

arr[5]

arr[5:8] = 99
print(arr)

# Array slice is a view of the origianl array
arr = np.arange(10)
arr
brr = arr[5:8]
brr

arr[5:8] = 99
arr
brr

# Indexing and Slicing in 2D

arr2d = np.array([[1, 2, 3], [4, 5, 6],[7, 8, 9]])
arr2d.shape
arr2d
arr2d[1][0]        # the same as below
arr2d[1,0]

arr2d[0]           # you can skip later indecis (columns)
arr2d[:1]

arr2d[:, 1]        # for column, you have to mention first index
arr2d[1]

arr2d[:2, 1:]
arr2d[2, 1]

arr2d[1, :2]
arr2d[1:3, :2]

arr2d[1, :2].ndim
arr2d[1:3, :2].ndim

arr2d[1, :2].shape

a = arr2d[1, :2]
a.shape

arr2d[1:2, :2].shape


# Indexing and Slicing in nD, n > 2

arr1d = np.arange(12)
arr3d = arr1d.reshape(2,3,2)

arr3d[0]
arr3d[0,0]
arr3d[0,0] = 99

arr3d[:,1]


# Boolean indexing

names = np.array(['Belinda', 'Malgorzata', 'John', 'Belinda', 'John', 'Jasper', 'Jasper'])
colours = np.array(['green','red','blue','yellow','brown','green','purple'])

names == 'Belinda'
colours[names == 'Belinda']

colours2 = np.array([['green','red','blue','yellow','brown','green','purple'],
                     ['black','pink','pink','brown','white','red','orange']])

colours2[0, names == 'Belinda']
colours2[1, names == 'Belinda']
colours2[:, names != 'Belinda']
colours2[:, ~(names == 'Belinda')]


# We can combine using & and |

mask = (names == 'Belinda') | (names == 'Jasper')
colours2[:, mask]


data = np.array([-2,3,1,-4,-12,-3,19])
data

data[data < 0] = 0
data



# Fancy Indexing - using integer array as index
# Fancy indexing copies the data into a new array

x = range(8)
x = list(x)
x = x * 4

arr = np.array(x).reshape(4,8).T
arr[[4, 3, 0, 6]]
arr[[-3, -5, -7]]


arr = np.arange(32).reshape((8, 4))
arr

arr[[1, 5, 7, 2], [0, 3, 1, 2]]         # we got only for numbers 

arr[[1, 5, 7, 2]][:, [0, 3]]      # for 4 by 4 array

# ix_() as an alternative
arr[np.ix_([1, 5, 7, 2], [0, 3])]


# Some numpy methods

arr = np.arange(15).reshape((3, 5))
arr

# Transpose
arr.T

# Random numbers
arr = np.random.randn(6, 3)
arr

# Dot product
np.dot(arr.T, arr)


# high dimentional array
arr = np.arange(16).reshape((2, 2, 4))
arr

# transpose
arr.transpose((1, 0, 2))

# swapaxes 
arr.swapaxes(1, 0)



###########################################################
# Universal functions (ufuncs) - element-wise transformation
# http://docs.scipy.org/doc/numpy/reference/ufuncs.html

# unary ufuncs
arr = np.arange(1,6)

np.square(arr)
np.sqrt(arr)
np.log(arr)


# binary ufunc
x = y = np.random.randn(8)
np.add(x, y)                  
np.multiply(x, y)
np.divide(x, y)


# return of multiple arrays
arr = np.random.randn(7) * 10

np.modf(arr)


###########################################################
# Vectorisation

points = np.arange(-5, 5, 0.01) # 1000 equally spaced points
xs, ys = np.meshgrid(points, points)
ys

z = np.sqrt(xs ** 2 + ys ** 2)
z


import matplotlib.pyplot as plt
plt.imshow(z)
plt.colorbar()
plt.title("Image plot of $\sqrt{x^2 + y^2}$")



###########################################################
# Conditional logic

xarr = np.array([1.1, 1.2, 1.3, 1.4, 1.5])
yarr = np.array([2.1, 2.2, 2.3, 2.4, 2.5])
cond = np.array([True, False, True, True, False])

result = [(x if c else y) for x, y, c in zip(xarr, yarr, cond)]
result

result = np.where(cond, xarr, yarr)
result


arr = np.random.randn(4,4)
arr

np.where(arr > 0, 2, -2)

np.sign(arr) * 2

# Another example

cond1 = np.array([True, True, False, False])
cond2 = np.array([True, False, True, False])
n = len(cond1)
result = []
for i in range(n):
    if cond1[i] and cond2[i]:
        result.append(0)
    elif cond1[i]: 
        result.append(1)
    elif cond2[i]: 
        result.append(2)
    else:
        result.append(3)
result


np.where(cond1 & cond2, 0, np.where(cond1, 1, np.where(cond2, 2, 3)))



###########################################################
# Array aggregations

arr = np.random.randn(5, 4) 
arr

arr.mean(axis=0)                  # Column means
arr.std(axis=0)                   # Column standard deviation
arr.median(axis=0)                # Column medians

np.mean(arr, axis=0)              # Column means
np.std(arr, axis=0)               # Column standard deviation
np.median(arr, axis=0)            # Column medians


arr = np.random.randn(100)
(arr > 0).sum()                   # Number of positive values
(arr > 0).mean() == 0.48


###########################################################
# Boolean arrays

bools = np.array([False, False, True, False])
bools.any() 
bools.all()



###########################################################
# Binary File Input and Output

arr = np.arange(10)
np.save('some_array.npy', arr)             # uncompressed binary

np.load('some_array.npy')


np.savez('array_archive.npz', a=arr, b=arr*2)

arch = np.load('array_archive.npz')        # zip archive
arch['b']
arch['a']


###########################################################
# Text File Input and Output

# more on reading files in pandas

arr = np.arange(12).reshape(4,3)
np.savetxt('array_ex.txt', arr, delimiter='==')

del arr
arr = np.loadtxt('array_ex.txt', delimiter='==')

arr = np.genfromtxt('array_ex.txt', delimiter='==')



###########################################################
# Random Number Generation

arr = np.random.normal(size=100000)

dir(np.random)


# Simple random walk

import random
steps = 1000
position = 0
walk = [position]
for i in range(steps):
    step = 1 if random.randint(0, 1) else -1
    position += step
    walk.append(position)

import matplotlib.pyplot as plt
# %matplotlib inline

plt.plot(walk)
plt.title("Simple random walk with +1/-1 steps")
# plt.show()


steps = 1000
draws = np.random.choice([-1,1], size=steps)
walk = draws.cumsum()

import matplotlib.pyplot as plt
# %matplotlib inline

plt.plot(walk)
plt.title("Simple random walk with +1/-1 steps")


# Simulating many random walks

nwalks = 5000
nsteps = 1000
draws = np.random.choice([-1,1], size=(nwalks, nsteps))
walks = draws.cumsum(1)

walks.max()
walks.min()

hits30 = (np.abs(walks) >= 30).any(1)
hits30.sum()

crossing_times = (np.abs(walks[hits30]) >= 30).argmax(1)
crossing_times.mean()

import matplotlib.pyplot as plt
# %matplotlib inline

plt.plot(walks.T)
plt.title(str(nwalks) + " simple random walks with +1/-1 steps")

plt.hist(walks[:,999], bins=53)  # 
plt.title("Distribution for the very last step")



###########################################################

###########################################################
# pandas - PANel DAta Structures
# http://pandas.pydata.org/pandas-docs/stable/index.html

'''
A clean axis indexing design to support fast data alignment, lookups, 
hierarchical indexing, and more high-performance data structures. 

SQL-like functionality: GroupBy, joining/merging, etc. Missing data 
handling. 
'''

import pandas as pd

###########################################################
# Data structures: series, dataframe, panel

# Series

obj = pd.Series([4, 7, -5, 3])
obj
obj.values
obj.index

# You can specify the desired indices
obj2 = pd.Series([4, 7, -5, 3],index=['d', 'b', 'a', 'c'])
obj2

# Selecting values

obj2['a']
obj2[2]
obj2[['a', 'b', 'c']]
obj2[obj2 > 0]

obj2['d'] = 99

obj2 * 2

'b' in obj2    # series works like fixed-length ordered dictionary

sdict = {'Ohio': 35000, 'Texas': 71000, 'Oregon': 16000, 'Utah': 5000}
obj3 = pd.Series(sdict)

sdict = {'Oregon': 16000, 'Ohio': 35000, 'Texas': 71000, 'California': 'NaN'}
obj4 = pd.Series(sdict)

obj3 + obj4


# DataFrame

data = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada'], 
         'year': [2000, 2001, 2002, 2001, 2002],
          'pop': [1.5, 1.7, 3.6, 2.4, 2.9]}
frame = pd.DataFrame(data)                            # from dictionary

frame = pd.DataFrame(list(range(10)), columns=['a'])  # from list

frame = pd.DataFrame(obj3)                            # from series

frame = pd.DataFrame(np.random.randn(5,3))            # from np.array


frame2 = pd.DataFrame(data, columns=['year','state','pop','debt'],
                      index=['one', 'two', 'three', 'four', 'five'])

frame2.columns
frame2.index

data = {'Nevada': {2001: 2.4, 2002: 2.9},             # from nested dictionary
        'Ohio': {2000: 1.5, 2001: 1.7, 2002: 3.6}}
frame = pd.DataFrame(data)

frame.index.name = 'year'
frame.columns.name = 'state'
frame.values


# Data retrival

# by columns
frame2['state']
frame2.year

# by rows
frame2.ix['three']
frame2.ix[2]

frame2.loc['three']
frame2.iloc[2]

frame2.iloc[:, 1]

# Reassigning values
frame2['debt'] = np.arange(5.)

val = pd.Series([-1.2, -1.5, -1.7], index=['two', 'four', 'five'])
frame2['debt'] = val

frame2['eastern'] = frame2.state == 'Ohio'

del frame2['eastern']
frame2.columns


# Dropping entries

obj = pd.Series(np.arange(5.), index=['a', 'b', 'c', 'd', 'e'])
new_obj = obj.drop('c')

frame2

frame3 = frame2.drop('three', axis = 0)
frame3 = frame2.drop('year', axis = 1)

frame3 = frame2.drop(frame2.index[2], axis=0)
frame3 = frame2.drop(frame2.columns[2], axis=1)



###########################################################
# Merging data (join)

left_frame = pd.DataFrame({'key': range(5), 
                           'left_value': ['a', 'b', 'c', 'd', 'e']})
right_frame = pd.DataFrame({'key': range(2, 7), 
                            'right_value': ['f', 'g', 'h', 'i', 'j']})
left_frame
right_frame

# inner join
pd.merge(left_frame, right_frame, on='key', how='inner')

# left outer join
pd.merge(left_frame, right_frame, on='key', how='left')

# right outer join
pd.merge(left_frame, right_frame, on='key', how='right')

# full outer join
pd.merge(left_frame, right_frame, on='key', how='outer')


# Combining data - adding rows
pd.concat([left_frame, right_frame])

# Combining data - adding columns
pd.concat([left_frame, right_frame], axis=1)


left_frame = left_frame.drop(1)
pd.concat([left_frame, right_frame], axis=1)


###########################################################
# Groupping data (groupby)


import pandas as pd
import numpy as np

###########################################################
# Check (and set) working directory to read data file


# Read in the data and check it out
mtcars = pd.read_csv("mtcars.csv")
mtcars.head()
mtcars.shape

# Compute basic descriptive stats over data
mtcars.describe()
mtcars.mean() # also compute median, std, var, min, max, quantile
mtcars.median()
mtcars.mean(axis=1) # compute row means (ie across columns)

# How many automatic transmission cars are there?
mtcars[mtcars["am"]==0].shape
mtcars[mtcars["am"]==0]

# Plot a histogram
mtcars["mpg"].hist()

# Group by number of cylinders and describe
grouped_by_cyl = mtcars.groupby("cyl")
grouped_by_cyl.mean()

# can group by more than one category
grouped_by_cyl_am = mtcars.groupby(["cyl","am"])

# compute statistics aggregated over groupings
grouped_by_cyl_am.agg([np.mean, np.std])

# count the number of cars in each combination of cyl and am
counts = grouped_by_cyl_am['cyl'].count()

# plot the counts

df = counts.unstack()
ax = df.plot(kind='bar', stacked=True, figsize=(10, 5), colormap="BuGn")
ax.set_ylabel("Count")
patches, labels = ax.get_legend_handles_labels()
ax.legend(patches, labels, loc='best')




###########################################################
# Arithmetic between DataFrames and Series

arr = np.arange(12.).reshape((4, 3))
arr - arr[0]


# broadcasting down the rows
frame = pd.DataFrame(np.arange(12.).reshape((4, 3)), 
                     columns=list('bde'), 
                     index=['Utah', 'Ohio', 'Texas', 'Oregon'])
series = frame.ix[0]
frame - series

frame.columns = ['e', 'd', 'b']
frame - series

# broadcasting down the columns
frame = pd.DataFrame(np.arange(12.).reshape((4, 3)), 
                     columns=list('bde'), 
                     index=['Utah', 'Ohio', 'Texas', 'Oregon'])
                     
series = frame['d']
frame.sub(series, axis=0)                  

series = frame.d[['Texas', 'Ohio', 'Oregon', 'Utah']]
frame.sub(series, axis=0) 



###########################################################
# Reindexing

obj = pd.Series(range(3), index=['a', 'b', 'c'])
obj.index

obj.index[1] = 'd'              # immutable
obj.index = ['a', 'd', 'c']

#import warnings
#warnings.simplefilter(action = "ignore", category = RuntimeWarning)

obj2 = obj.reindex(['a', 'b', 'c', 'd', 'e'])

obj = pd.Series([4.5, 7.2, -5.3, 3.6], index=['d', 'b', 'a', 'c'])
obj

# reindexing with new values

obj.reindex(['a', 'b', 'c', 'd', 'e'], fill_value=0)

obj = pd.Series(['blue', 'purple', 'yellow'], index=[0, 2, 4])
obj

obj.reindex(range(6), method='ffill')
obj.reindex(range(6), method='bfill')

# More on reindexing

frame = pd.DataFrame(np.arange(9).reshape((3, 3)), 
                     index=['a', 'c', 'd'],
                     columns=['Ohio', 'Texas', 'California'])
# reindex rows
frame.reindex(['a', 'b', 'c', 'd'])

# reindex columns
states = ['Texas', 'Utah', 'California']
frame.reindex(columns=states)

# reindex rows and columns
frame.reindex(index=['a', 'b', 'c', 'd'], columns=states)

# alternative way to reindex
frame.ix[['a', 'b', 'c', 'd'], states]


###########################################################
# Extra notes on indexing and slicing

obj = pd.Series(np.arange(4.),index=['a', 'b', 'c', 'd'])

obj[1]          # works like in numpy
obj['b']  

obj[1:2]        # works like in Python
obj['b':'c']    # takes end-point like in R


data = pd.DataFrame(np.arange(16).reshape((4, 4)),
                    index=['Ohio', 'Colorado', 'Utah', 'New York'],
                    columns=['one', 'two', 'three', 'four'])

data[[1]]
data['two']
data[['two','four']]

data[:2]        
data[data['three'] > 5]

data[data < 5] = 0

data = pd.DataFrame(np.arange(16).reshape((4, 4)),
                    index=['Ohio', 'Colorado', 'Utah', 'New York'],
                    columns=['one', 'two', 'three', 'four'])
                    
data.ix['Colorado', ['two', 'three']]
data.ix[['Colorado','Utah'],['two', 'three']]
data.ix[2]
data.ix[:'Utah', 'two']
data.ix[data.three > 5,:3]                    


###########################################################
# Hierarchical Indexing
'''
Enables multiple (two or more) index levels on an axis. 
Provides a way to work with higher dimensional data at lower 
dimensions.  
'''

# Series

data = pd.Series(np.random.randn(10), 
                 index=[['a', 'a', 'a', 'b', 'b', 'b', 'c', 'c', 'd', 'd'],
                        [ 1,   2,   3,   1,   2,   3,   1,   2,   2,   3]])

data['b']

data['b':'c']
data.ix[['b', 'c']]

data[:,2]

data.unstack()
data.unstack().stack()


# DataFrames

frame = pd.DataFrame(np.arange(12).reshape((4, 3)),
                     index=[['a','a', 'b', 'b'], [1, 2, 1, 2]],
                     columns=[['Ohio', 'Ohio', 'Colorado'], ['Green', 'Red', 'Green']])

frame.index.names = ['key1', 'key2']
frame.columns.names = ['state', 'colour']

frame['Ohio']    
frame.stack()
frame.stack(level=0)
frame.stack().stack()

frame.unstack().unstack()
frame.unstack(level=[0,1])


###########################################################

###########################################################
# Function mapping 

# apply - vectorisation

frame = pd.DataFrame(np.random.randn(4, 3), 
                     columns=list('bde'),
                     index=['Utah', 'Ohio', 'Texas', 'Oregon'])

f = lambda x: x.max() - x.min()
frame.apply(f)


def f(x): 
    return pd.Series([x.min(), x.max()], index=['min', 'max'])

frame.apply(f)


# applymap - element-wise application

format = lambda x: '%.2f' % x # returns a formatted string
frame.applymap(format)



###########################################################
# Missing data

from numpy import nan as NA
data = pd.Series([1, NA, 3.5, NA, 7])

data.dropna()

data[data.notnull()]


sdata = {'Ohio': 35000, 'Texas': 71000, 'Oregon': 16000, 'Utah': 5000}
states = ['California', 'Ohio', 'Oregon', 'Texas']
obj = pd.Series(sdata, index=states)

pd.isnull(obj)
pd.notnull(obj)

obj.fillna(0)
obj.fillna(0, inplace=True)
obj.fillna(obj.mean())


df = pd.DataFrame(np.random.randn(7, 3))
df.ix[:4, 1] = NA; df.ix[:2, 2] = NA
df

cleaned = df.dropna()
cleaned

cleaned2 = df.dropna(thresh=2)
cleaned2