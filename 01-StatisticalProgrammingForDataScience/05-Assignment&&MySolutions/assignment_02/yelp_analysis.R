# Assignment 2
# Student Name : Wangjun SHEN

# import packages
library(dplyr)
library(psych)
library(tidyverse)


# load data from the data set into data frame
review_data <- read.csv("yelp_reviews.csv")  # may take long time due to the large data set


# Q2 : statistical summary
describeBy(review_data[,c("stars", "review_length", "pos_words", "neg_words", "net_sentiment")]) 


# Q3 : Count positive words and the counts of negative words, then plot
# make tables for negative words and positive words
review_pos_table <- table(review_data$pos_words)
review_pos_table

review_neg_table <- table(review_data$neg_words)
review_neg_table

# transfer to data frame and then plot the first 20
review_pos_df <- as.data.frame(table(review_data$pos_words)) 
review_pos_df

review_neg_df <- as.data.frame(table(review_data$neg_words)) 
review_neg_df

review_pos_20 <- review_pos_df[c(1:20),]
review_pos_20$Var1 <- as.integer(review_pos_20$Var1)
plot(review_pos_20, type = 'b', xlab = "Positive Words Counts", ylab = "Positive Words Frequency", 
     main = "Frequency of First 20 Posotive Words Counts")

review_neg_20 <- review_neg_df[c(1:20),]
review_neg_20$Var1 <- as.integer(review_neg_20$Var1)
plot(review_neg_20, type = 'b', xlab = "Negative Words Counts", ylab = "Negative Words Frequency", 
     main = "Frequency of First 20 Negative Words Counts")


# Q4 : Repeat Q3 for net_sentiment
review_net_sentiment <- as.data.frame(table(review_data$net_sentiment)) 
review_net_sentiment

# The abscissa will change due to the size of the plots window
plot(review_net_sentiment, type = "b", xlab = "Net Sentiment Counts", ylab = "Net Sentiment Frequency", 
     main = "Frequency of All Net Sentiment")


# Q5 : Discuss the average review length per star category
# Using median as the average value for reviews length
review_length_average <- review_data %>%
  group_by(stars) %>%
  summarise(avg_length = median(review_length))

# Present the result
barplot(height = review_length_average$avg_length, names = review_length_average$stars, 
        xlab = "Stars of Reviews", ylab = "Average of the length of Reviews",
        main = "Average of The Length of Reviews for Each Star")


# Q6 : Analyse reviews voted as useful
# Plot the figure for the simple analysis
plot(x = review_data$stars, y = review_data$votes_useful)
plot(x = review_data$review_length, y = review_data$votes_useful)

# relation between the useful of reviews and stars
review_vote_useful_stars <- cor(review_data$votes_useful, review_data$stars)
review_vote_useful_stars

# relation between the useful of the useful of reviews and reviews length
review_vote_useful_length <- cor(review_data$votes_useful, review_data$review_length)
review_vote_useful_length  # weak and positive relationship

# Fit regression model for the length of review
review_vote_useful_length_lm <- lm(votes_useful ~ review_length, data = review_data)
review_vote_useful_length_lm

summary(review_vote_useful_length_lm)  # summary the result

# try both 2 variables for fitting regression model 
review_vote_useful_length_stars_lm <- lm(votes_useful ~ stars + review_length, data = review_data)
summary(review_vote_useful_length_stars_lm)  # summary the result


# Q7 : Study the number of reviews per day
review_data$Day = as.Date(review_data$date, format = "%Y-%m-%d")  # converse date variable

review_data_daily <- review_data %>%
  group_by(Day) %>%
  summarise(number = n())

ggplot(review_data_daily, aes(x = Day, y = number)) + 
  geom_line() + labs(x = "Day Time", y = "Total Review Number", title = "The graph for review number for each day")



# Q8 : Best Business and User
# transfer in order to improve the processing speed for R programming
review_data$user_id = as.factor(review_data$user_id)
review_data$business_id <- as.factor((review_data$business_id))

review_data$user_id

# calculate the frequency for same users
review_data_user <- review_data %>%
  group_by(user_id) %>%
  summarise(number = n(), avg_vote_useful = mean(votes_useful))  %>%
  ungroup() %>%
  group_by(number) %>%
  arrange(avg_vote_useful, .by_group = TRUE) 

# top 10 and then find the user with highest average useful reviews
tail(review_data_user, 10)


# do the same thing for business but stars
review_data_business <- review_data %>%
  group_by(business_id) %>%
  summarise(number = n(), avg_stars = mean(stars))  %>%
  ungroup() %>%
  group_by(number) %>%
  arrange(avg_stars, .by_group = TRUE) 

tail(review_data_business, 10)
