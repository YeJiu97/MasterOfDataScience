from pyspark import SparkContext
from pyspark.sql import SparkSession

if __name__ == '__main__':

	# Definition of common variables
	filename = "file:///home/prac/test3/input/DataCoSupplyChainDataset.csv"
	file = open("/home/prac/test3/output/result.txt",'w')

	# Define SparkContext and SparkSession
	sc = SparkContext(appName = "Test3")
	spark = SparkSession(sc)


	###Q1 - Load data, convert to dataframe, apply appropriate column names and variable types

	# Your solution goes here


	###Q2 - Determine the proportion of each customer segment

	# Your solution goes here
	
	# Printing the solution to the results.txt file
	file.write("Consumer = " +  + "%, Corporate = " +  + "%, Home Office = " +  + "%\n\n")


	###Q3 - Which three products had the least sales in revenue

	# Your solution goes here
	
	# Printing the solution to the results.txt file
	file.write( + " = $" +  + ", " +  + " = $" +  + ", " +  + " = $" +  + "\n\n")


	###Q4 - For each transaction type, determine the average item cost before discount

	# Your solution goes here
	
	# Printing the solution to the results.txt file
	file.write("Average item cost: Transfer = $" +  + ", Debit = $" +  + ", Payment=$" +  + ", Cash=$" +  + "\n\n")


	###Q5 - What is the most regular customer first name in EE. UU.

	# Your solution goes here
	
	# Printing the solution to the results.txt file
	file.write("Most regular customer name in EE. UU. is " + + ", who comes back " + + " times.")


	file.close()
