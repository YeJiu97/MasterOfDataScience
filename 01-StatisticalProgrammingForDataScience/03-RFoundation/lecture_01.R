x <- vector() # an empty logical vector (default one)
x
length(x)

y <- vector("character", length = 5)
y

numeric(5)

logical(5)
character(5)
integer(5)

x <- c(1, 2, 3, 4, "a")
x

x <- c(1L,2L,3L,4L,5L)
x

x <- c(1, 2, 3, 4, "5")
x

y <- as.numeric(x)
y

x <- c(1, 2, 3, 4, "abc")
y <- as.numeric(x)
y


x <- c(2, 2)
x

y <- c(x, x, x)
y

z <- c(x, 12)
z

x <- c(1:10)
x

x <- 1:10
x

x <- seq(10)
x


x <- seq(from = 0, to = 20, by = 2)
x

x <- c(1, 2, 3, NA, 5)
x
class(x)

x <- c("a", "b", "c", NA, "e")
class(x)

1 / 0
0 / 0
log(-1)

x <- c("a" = 1, "b" = 2, "c" = 3)
x

attributes(x)


m <- matrix(nrow = 2, ncol = 3)
m
class(m)


m <- matrix(c(1:6), 2, 3)
m

m <- matrix(letters, ncol = 2, byrow = TRUE)

x <- 1:12
dim(x) <- c(2, 3, 2)  # 一个三维的array
x

class(x)
typeof(x)

x[2, 3, 2]


df <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
df

names(df)
dim(df)

df["y"]

df$id


mtcars

head(mtcars)
tail(mtcars)

ncol(mtcars)
nrow(mtcars)

dim(mtcars)


colour <- c("red", "blue", "red", "red")
colour

colour_f <- factor(colour)
colour_f


x <- 1 : 10
x
x * 2

y <- 11 : 20
x + y


res <- numeric(length = 10)
for (i in seq(1, length = 10)){
  res[i] <- x[i] + y[i]
}
res

x <- 1:10
res <- c()
for (i in x){
  res <- c(res, i * 2)
}
res


x <- 0
while(x < 5){
  print(x)
  x <- x + 1
}


x <- 0
repeat{
  print(x)
  x <- x + 1
  if (x > 5){
    break
  }
}


miles.to.kilometers <- function(miles){
  kilometers <- miles * 1.60934
  return(kilometers)
}

miles.to.kilometers(250)


x <- 10
if (x < 20){
  print(x)
}

x <- 20
if (x < 10){
  print("x < 10")
} else{
  print("x > 10")
}


x <- 50
if (x < 50){
  print("x < 50")
} else if (x == 50){
  print("x = 50")
} else{
  print("x > 50")
}
