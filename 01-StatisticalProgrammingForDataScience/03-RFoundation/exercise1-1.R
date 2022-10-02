# Exercise 1 -------------------------------------------------------------------
# Data types and data structures, indexing


# Please try to complete tasks listed below. Type your code in each section.


# clean up global environment
rm(list = ls())



### Task 1 ---------------------------------------------------------------------

# Create a character vector. 
# Use three different methods to get the character vector of length 4.






### Task 2 ---------------------------------------------------------------------

# Create a sequence of 8 numbers, then apply a mathematical
# operation that should result in the following output:
# [1]    8   16   32   64  128  256  512 1024







### Task 3 ---------------------------------------------------------------------

# Create a data frame as below 
#   x y z
# 1 a 1 5
# 2 b 2 6
# 3 c 3 7




# Use different methods of indexing to extract values "a" and "c" together.
# You should get at least 4 different options.





### Task 4 ---------------------------------------------------------------------


# Run the code below to load data set about passengers of Titanic.

data(Titanic)
Titanic

# Check the help file with data description

help(Titanic)

# Use indexing to extract the number of crew member of both genders 
# survived and died - to get the total count of crew members on Titanic








### Task 5 ---------------------------------------------------------------------



# Run the code below to load data set about car performance.

data(mtcars)
mtcars

# Check the help file with data description

help(mtcars)

# Variable "vs" do not look as truly numerical, it has a meaning
# (V-shape or Straight) but not a numerical value. Hence, it should be 
# converted to factor. Create a new variable in the data set "vs.f" 
# with corresponding factor values - V-shape or Straight.

# Hint: check examples for function "factor()"
help(factor)




x <- 1:12
dim(x) <- c(2, 3, 2) # make a 3-dimensional array
x



