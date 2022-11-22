# load packages
library(rvest)
library(stringr)


# webpage scrap  function
scrap_rental <- function(url){
  rental_p1 <- read_html(url)
  rental_information <- rental_p1 %>% html_nodes("div.overview") %>% html_text (trim=TRUE)
  split_information <- strsplit(rental_information, split = "\n+")
  return (split_information)
}


# all webpages' URL addresses
url_lists <- c("https://www.rent.com.au/properties/adelaide-sa-5000/p1",
              "https://www.rent.com.au/properties/adelaide-sa-5000/p2",
              "https://www.rent.com.au/properties/adelaide-sa-5000/p3",
              "https://www.rent.com.au/properties/adelaide-sa-5000/p4",
              "https://www.rent.com.au/properties/adelaide-sa-5000/p5",
              "https://www.rent.com.au/properties/adelaide-sa-5000/p6",
              "https://www.rent.com.au/properties/adelaide-sa-5000/p7")


# an empty list use to storage scrape results
rental_information_totally <- list()


# storage scrape results by using webpage scrap  function
for (url_list in url_lists){
  rental_information_totally <- append(rental_information_totally, scrap_rental(url_list))
}


# create data frame with 0 rows and 5 columns
df <- data.frame(matrix(ncol = 9, nrow = 0))


# provide column names
colnames(df) <- c('price', 'type', 'address', "street", 'sub', 'bedroom', "bathroom", "car_space", "original_information")


# using for loop to build the data frame
for (rental_information_list in rental_information_totally){
  
  # not enough information provided
  if (length(rental_information_list) < 6){
    next
  }
  
  # below code will transfer data to data frame for each variables
  price_temp <- strsplit(gsub(",", "", rental_information_list[1]), "[^[:digit:]]+")[[1]]
  price <- price_temp[2] %>% as.numeric()
  
  type <- rental_information_list[2]
  address <- rental_information_list[3]
  
  if (!grepl(",", address)){
    next
  }
  
  temp <- strsplit(address, ",")[[1]][1]
  street_previous <- rev(strsplit(temp," ")[[1]])
  street <- ""
  for (element in street_previous){
    if (grepl("[[:digit:]]", element)){
      break
    } else {
      street <- paste(element, street)
    }
  }

  sub <- strsplit(rental_information_list[3], ",")[[1]][2]
  bedroom <- strsplit(rental_information_list[4], " ")[[1]][1] %>% as.numeric()
  bathroom <- strsplit(rental_information_list[5], " ")[[1]][1] %>% as.numeric()
  car_space <- strsplit(rental_information_list[6], " ")[[1]][1] %>% as.numeric()
  
  # data frame
  df[nrow(df) + 1,] = c(price,type, address, street, sub, bedroom, bathroom, car_space, paste(rental_information_list, collapse=" "))
}

# drop rows with NA value
df <- na.omit(df)

# transfer some variables from char into numeric
df$price <- as.numeric(df$price)
df$bedroom <- as.numeric(df$bedroom)
df$bathroom <- as.numeric(df$bathroom)
df$car_space <- as.numeric(df$car_space)

# save data frame as RDS file
saveRDS(df, "examdata.RDS")
