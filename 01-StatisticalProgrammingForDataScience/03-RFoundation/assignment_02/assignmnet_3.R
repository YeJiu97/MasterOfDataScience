library(dplyr)
library(psych)
library(tidyverse)


# load data from data set into data frame
review_data <- read.csv("yelp_reviews.csv")

# question 2 : statistical summary

# 注意：打印出来
# summary(review_data)  # get general statistical summary: min max mean median

describe.by(review_data[,c("stars", "review_length", "pos_words", "neg_words", "net_sentiment")])  # get: standard deviation, range, standard error


# question 3

review_pos <- as.data.frame(table(review_data$pos_words)) 
review_pos

review_neg <- as.data.frame(table(review_data$neg_words)) 
review_neg

review_pos


# first 20 variables
# 注意：添加title，修改一下坐标的名字
review_pos_20 <- review_pos[c(1:20),]
review_pos_20$Var1 <- as.integer(review_pos_20$Var1 )
plot(review_pos_20, type = 'b', xlab = "Positive Words Counts", ylab = "Positive Words Frequency", main = "Frequency of First 20 Posotive Words Counts")

# 将negative添加进来
review_neg_20 <- review_neg[c(1:20),]
review_neg_20$Var1 <- as.integer(review_neg_20$Var1 )
plot(review_neg_20, type = 'b', xlab = "Negative Words Counts", ylab = "Negative Words Frequency", main = "Frequency of First 20 Negative Words Counts")



# question 4

review_net_sentiment <- as.data.frame(table(review_data$net_sentiment)) 
review_net_sentiment

plot(review_net_sentiment, type = "b", xlab = "Net Sentiment Counts", ylab = "Net Sentiment Frequency", main = "Frequency of All Net Sentiment")

# 可以发现，大部分的人的net在-5~11之间，这部分人的分布总体上偏向于pos，认为特别糟糕或者特别好的都是少数的。



# question 5
review_length_average <- review_data %>%
  group_by(stars) %>%
  summarise(avg_length = median(review_length))

# 从skew来看，2.3 > 2 ，所以我们不选择mean而是选择median

barplot(height = review_length_average$avg_length, names = review_length_average$stars, 
        xlab = "Stars of Reviews", ylab = "Average of the length of Reviews",
        main = "Average of The Length of Reviews for Each Star")  # 加上标题等因素
# 再描述一下直方图的分布情况



# question 6

plot(x = review_data$stars, y = review_data$votes_useful)
plot(x = review_data$review_length, y = review_data$votes_useful)

review_vote_useful_stars <- cor(review_data$votes_useful, review_data$stars)
review_vote_useful_stars  # 发现没有什么关系

review_vote_useful_length <- cor(review_data$votes_useful, review_data$review_length)
review_vote_useful_length  # 发现存在着正相关

review_vote_useful_length_lm <- lm(votes_useful ~ review_length, data = review_data)
review_vote_useful_length_lm

summary(review_vote_useful_length_lm)
# R^2 从结果来看，只能够解释10.62%的variance of useful，adj r^2 

review_vote_useful_length_stars_lm <- lm(votes_useful ~ stars + review_length, data = review_data)
summary(review_vote_useful_length_stars_lm)


# question 7

review_data$Day = as.Date(review_data$date, format = "%Y-%m-%d")  # converse date variable

review_data_daily <- review_data %>%
  group_by(Day) %>%
  summarise(number = n())

review_data_daily


ggplot(review_data_daily, aes(x = Day, y = number)) + 
  geom_line() + labs(x = "Day Time", y = "Total Review Number", title = "The graph for review number for each day")


# question 8
review_data$user_id = as.factor(review_data$user_id)
review_data$business_id <- as.factor((review_data$business_id))

review_data$user_id

review_data_user <- review_data %>%
  group_by(user_id) %>%
  summarise(number = n(), avg_vote_useful = mean(votes_useful))  %>%
  ungroup() %>%
  group_by(number) %>%
  arrange(avg_vote_useful, .by_group = TRUE) 


tail(review_data_user, 10)


review_data_business <- review_data %>%
  group_by(business_id) %>%
  summarise(number = n(), avg_stars = mean(stars))  %>%
  ungroup() %>%
  group_by(number) %>%
  arrange(avg_stars, .by_group = TRUE) 

tail(review_data_business, 10)

