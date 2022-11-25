# Assessable Exercise 2
# Student Name: Wangjun shen

# pre: download, install and import packages
# install.packages("dplyr")
# install.packages("tidyverse")

library(dplyr)
library(tidyverse)


# question 1 : import all data into 1 data frame
# method 1
# data_df <- bind_rows(lapply(list.files(pattern = "\\.csv$"), read.csv))

# method 2 : using pipe
data_df <- list.files(pattern = "\\.csv$") %>%  lapply(read.csv) %>% bind_rows


# question 2: calculate demand per capital and normalized
data_df_popu <- data_df %>%
  mutate(Population = case_when(
    REGION == "NSW1" ~ 8176.4,
    REGION == "QLD1" ~ 5206.4,
    REGION == "SA1" ~ 1771.7,
    REGION == "TAS1" ~ 542,
    REGION == "VIC1" ~ 6648.6
  ))
data_df_popu$DemandPerCapita = data_df_popu$TOTALDEMAND / data_df_popu$Population


# question 3: aggregate data to get daily information
data_df_popu$Day = as.Date(data_df_popu$SETTLEMENTDATE, format = "%Y/%m/%d")  # converse date variable
data_df_popu <- data_df_popu[data_df_popu$Day != "2021-01-01",]  # drop a special date with its row

# using group_by function and summarise() function
data_df_daily <- data_df_popu %>%
  group_by(Day, REGION) %>%
  summarise(SUMDEMAND = sum(TOTALDEMAND), MEANPRICE = mean(RRP), SUMDEMANDPERCAP = sum(DemandPerCapita))



# question 4: plot for electricity demand and demand per capita for each day for each region
ggplot(data_df_daily, aes(x = SUMDEMAND)) + 
  geom_histogram() + labs(x = "Daily Demand", title = "The distributions of electricity demand per day for each region") + facet_wrap("REGION")


ggplot(data_df_daily, aes(x = SUMDEMANDPERCAP)) + 
  geom_histogram() + labs(x = "Daily Demand per capita",  title = "The distributions of electricity demand per capita per day for each region") + facet_wrap("REGION")

# part_1 of question 8: show the numerical summary for each region
summary(data_df_daily[data_df_daily$REGION == "NSW1",])
summary(data_df_daily[data_df_daily$REGION == "QLD1",])
summary(data_df_daily[data_df_daily$REGION == "SA1",])
summary(data_df_daily[data_df_daily$REGION == "TAS1",])
summary(data_df_daily[data_df_daily$REGION == "VIC1",])
# the above code can also be used for question 5


# question 5: build historical graph for each five states for demand and then for demand per capita
ggplot(data_df_daily, aes(x = Day, y = SUMDEMAND, group = REGION, colour = REGION)) + 
  geom_line() + labs(x = "Time", y = "Total Demand", title = "Historical Graph for Demand in Five States")

ggplot(data_df_daily, aes(x = Day, y = SUMDEMANDPERCAP, group = REGION, colour = REGION)) + 
  geom_line() + labs(x = "Time", y = "Total Demand Per Capita", title = "Historical Graph for Demand Per Capita in Five States")



# question 6: study a relationship for each of five sates for demand and then for demand per capita
# relationship
price_dpc_cor <- data_df_daily %>%
  group_by(REGION) %>%
  summarise(CORRELATION = cor(MEANPRICE, SUMDEMANDPERCAP))

# print the result
price_dpc_cor

# noticed that the relationship for QLD1 is 0.680
# So, try linear regression and get summary information
linear_regression_QLD <- lm(MEANPRICE ~ SUMDEMANDPERCAP, data = data_df_daily[data_df_daily$REGION == "QLD1",])
summary(linear_regression_QLD)


# question 7: aggregate data by the hour of the day for each of five states
# create the new column for Hour
data_df_popu$Hour <- as.POSIXlt(data_df_popu$SETTLEMENTDATE, format = "%Y/%m/%d %H:%M:%OS")$hour

# using pipe to get summarise data for Hour by group_by for each region
data_df_hour <- data_df_popu %>%
  group_by(Hour, REGION) %>%
  summarise(SUMDEMAND = sum(TOTALDEMAND), MEANPRICE = mean(RRP), SUMDEMANDPERCAP = sum(DemandPerCapita))

ggplot(data_df_hour, aes(x = Hour, y = SUMDEMAND, group = REGION, colour = REGION)) + 
  geom_line() + labs(x = "Hour Time", y = "Total Demand", title = "The graph for demand per hour for each state")

ggplot(data_df_hour, aes(x = Hour, y = SUMDEMANDPERCAP, group = REGION, colour = REGION)) + 
  geom_line() + labs(x = "Hour Time", y = "Total Demand Per Capita", title = "The graph for demand per capita per hour for each state")


# part_2 of question 8
summary(data_df_hour[data_df_hour$REGION == "NSW1",])
summary(data_df_hour[data_df_hour$REGION == "QLD1",])
summary(data_df_hour[data_df_hour$REGION == "SA1",])
summary(data_df_hour[data_df_hour$REGION == "TAS1",])
summary(data_df_hour[data_df_hour$REGION == "VIC1",])
