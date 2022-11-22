# load packages
library(dplyr)
library(tidyverse)
library(psych)
library(stats)

# load data
rental_df <- readRDS("examdata.RDS")

# Q1
# gain the descriptive statistics information for distribution of the price
describe(rental_df["price"])

# visualization of the distribution of the overall price
ggplot(rental_df, aes(x = price)) + geom_histogram() + labs(x = "Price", title = "The distribution of prices")
ggplot(rental_df, aes(x = price)) + geom_histogram() + labs(x = "Price", title = "The distribution of prices") + facet_wrap("type")


# relationship between type , number of bedroom and price
boxplot(price~type,data=rental_df, main = "Boxplot of price and type")

anova_regression_property <- aov(price ~ type, data = rental_df)
summary(anova_regression_property)
HSD_property <- TukeyHSD(anova_regression_property)
HSD_property  # p-adj value, significant
plot(HSD_property)

plot(rental_df$bedroom, rental_df$price, xlabel = "bedroom", ylabel = "price")  # scatter plot
cor(rental_df$price, rental_df$bedroom)  # correlation ship
linear_regression_bedroom <- lm(price ~ bedroom, data = rental_df)  # linear regression
summary(linear_regression_bedroom)


# Q2
# gain the descriptive statistics information for distribution of the number of the car space
describe(rental_df["car_space"])

# visualization of the distribution of the overall number of the car space
ggplot(rental_df, aes(x = car_space)) + geom_histogram() + labs(x = "Car Space", title = "The distribution of Car Space")
ggplot(rental_df, aes(x = car_space)) + geom_histogram() + labs(x = "Car Space", title = "The distribution of car Space") + facet_wrap("type")

boxplot(car_space~type,data=rental_df, main = "Boxplot of car space and type")

# linear regression between price and type of property and number of bedrooms
anova_regression_property_car_space <- aov(car_space ~ type, data = rental_df)
summary(anova_regression_property_car_space)
HSD_property_car_space <- TukeyHSD(anova_regression_property_car_space)
HSD_property_car_space  # p-adj value
plot(HSD_property_car_space)

plot(rental_df$bedroom, rental_df$car_space)
cor(rental_df$car_space, rental_df$bedroom)
linear_regression_bedroom_car_space <- lm(car_space ~ bedroom, data = rental_df)
summary(linear_regression_bedroom_car_space)


# Q3
# got data with sub is Adelaide
rental_adelaide_df <- rental_df[rental_df$sub == " Adelaide SA 5000", ]
rental_non_adelaide_df <- rental_df[rental_df$sub != " Adelaide SA 5000", ]
sort(table(rental_adelaide_df$street))
sort(table(rental_non_adelaide_df$sub))

# popu for Adelaide
rental_popu_df <- rental_df[rental_df$street == "Wright Street " | rental_df$street == "Waymouth Street " | rental_df$street == "- Waymouth Street" |
                          rental_df$street == "Hutt Street " | rental_df$street == "Hindley Street " | rental_df$street == "Gray Street ", ]
summary(rental_popu_df)
barplot(table(rental_popu_df$type))
barplot(table(rental_popu_df$car_space))
hist(rental_popu_df$price)
barplot(table(rental_popu_df$bedroom))
barplot(table(rental_popu_df$bathroom))

# popu for sub 
rental_popu_sub_df <- rental_df[rental_df$sub == " North Adelaide SA 5006", ]
summary(rental_popu_sub_df)
barplot(table(rental_popu_sub_df$type))
barplot(table(rental_popu_sub_df$car_space))
barplot(table(rental_popu_sub_df$bedroom))
barplot(table(rental_popu_sub_df$bathroom))
hist(rental_popu_sub_df$price)
