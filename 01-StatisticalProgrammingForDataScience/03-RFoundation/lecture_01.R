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

