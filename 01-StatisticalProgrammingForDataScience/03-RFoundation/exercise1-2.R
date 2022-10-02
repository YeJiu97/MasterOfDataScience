# Exercise 2 -------------------------------------------------------------------
# Control flow operators, Functions, Packages

# Please try to complete tasks listed below. Type your code in each section.



# clean up global environment
rm(list = ls())



### Task 1 ---------------------------------------------------------------------

# Air temperature above 30 degrees might be considered as "too hot". 
# Temperature below 5 degrees is "too cold". Anything in between is "good".
# Use conditions to take a value of air temperature "Temp" and print
# the corresponding condition: "good" or "too hot" or "too cold".

Temp <- 25    # Try different values to test your code





### Task 2 ---------------------------------------------------------------------

# Use the code from Task 1 and convert it into a custom function that takes 
# as an input air temperature "Temp" and outputs the corresponding condition.
# Then use a loop with a function to get conditions for the following values
# of the air temperature and store them as a vector "conditions"

Temp <- c(0, 15, 35, 20, -10, 44)





### Task 3 ---------------------------------------------------------------------

# Make a code to re-create a sequence of first 30 Fibonacci numbers
# https://en.wikipedia.org/wiki/Fibonacci_number
# Every next Fibonacci number equals to the sum of two previous numbers
# 1, 1, 2, 3, 5, 8, ...






### Task 4 ---------------------------------------------------------------------

# Do a Google search and find ready-made package and function to output
# Fibonacci numbers. Get first 30 numbers and compare them to your own result.






### Task 5 ---------------------------------------------------------------------

# Take a sequence of normally distributed random numbers as below and 
# count how many times the value in sequence is greater than 2 or less than -2.
# Make 4 versions of the code by using: 
# (1) for loop; (2) while loop; (3) repeat loop; (4) no loop

X <- rnorm(1000)

## 1 for loop



## 2 while loop



## 3 repeat loop



## 4 no loop 










