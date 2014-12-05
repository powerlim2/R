# Data Wrangling R function


# Objective: add additional columns based on the columns in variables
# The rule: if the value is positive, give the time when the value happens, otherwise give 0.
# Information 1: the number of columns varies by data
# Information 2: all data has 'time' column
attach.newVariable <- function(df) {
  library(assertthat)
  assert_that(class(df) == "data.frame" || class(df) == "matrix")
  assert_that("time" %in% colnames(df))
  trans <- function(x) ifelse(x > 0, df[, "time"], 0)
  newcols <- apply(df[, !colnames(df) == "time"], 2, trans)
  colnames(newcols) <- paste("New", colnames(newcols), sep="_")
  df <- cbind(df,newcols)
  return(df)
}


# example data
data <- matrix(rnorm(300, mean = 3, sd = 5), ncol = 6)
data <- cbind(data, 1:nrow(data))
colnames(data) <- c("A", "B", "C", "D", "E", "F", "time")

# head(data)
#              A         B          C           D          E          F time
# [1,]  1.406111  1.739580  0.4428849 12.55738641 -2.8543478 -1.8552772    1
# [2,]  4.540878  8.246296  1.6496516  2.92792573  0.3696874 -3.0688601    2
# [3,]  0.112164 -6.538725  8.1597297 10.16853946  0.8897182  5.4678650    3
# [4,]  9.722519  2.289551  3.5261182 -7.03744086 -5.8551287 -2.6596482    4
# [5,] 11.526151 -7.129635 -4.9247344  3.06442214 15.8849087 -0.8580672    5
# [6,]  1.735807 -7.158896  0.6857458 -0.01928254  2.3828435  7.9390936    6

# try
attach.newVariable(data)
