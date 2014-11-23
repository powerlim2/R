# Title  : Run ARIMA models for multi-level data
# Author : Joon Lim
# Date   : 2014.08.13


# --------------------------------------------------------------------------------------------------------
# Background:
#
# We often face panel data. In this case, my coworker was asking if we can systematically perform
# ITS (interrupted time series analysis) to measure maketing campaign effectiveness for each medium.
# We choose R as a main analysis tool and tested computational efficiencies for 3 different approaches.
#
# Option: (1) by, (2) plyr, (3) for loop
#
# Conclusion:
# by() function is slightly more efficient than dlply(). 'For loop' is significantly slower than 'by'.
# The efficiency difference was larger with the actual data.
# --------------------------------------------------------------------------------------------------------

# Read an example Panle Data
library(foreign)  # for read.dta()
library(forecast)  # for auto.arima()
panel <- read.dta("http://dss.princeton.edu/training/Panel101.dta")  # example data
panel <- panel[panel$country %in% c("A", "B", "C"), ]
panel <- within(panel, {
       country <- factor(country, levels = c("A", "B", "C"))
})
# By country, year is univariate for both "A" and "B"
# For simplicity, let me skip AR, MA determination processes through acf() and pacf().
# auto.arima() from forecast pacakge gives a pretty good estimation of AR and MA based on AIC.
print.arma <- function(model) {
  if (class(model) != "Arima") stop("InputValueError")
  cat(paste0("AR          : ", model$arma[1], "\n",
             "MA          : ", model$arma[2], "\n",
             "Differencing: ", model$arma[6], "\n"))
}


# 1. Using by
with(panel, by(panel, country, summary))  # using by to get summary for each country
system.time(model.arima <- with(panel, by(panel, country, 
               function(df) auto.arima(df$y)
               )))

# Time:
#   user  system elapsed 
#   0.174   0.000   0.174 


## get all results
model.arima

## Access to each model - output is list type
summary(model.arima[["C"]]) # or model.arima$A

## extract the estimated AR and MA by auto.arima
print.arma(model.arima$C)





# 2. Using plyr
library(plyr)
system.time(model.arima2 <- dlply(panel, .(country), 
      function(df) auto.arima(df$y)))

# Time: (a bit slower than "by()")
#    user  system elapsed 
#   0.178   0.000   0.179


# Are we getting the same result?
model.arima$A$aic == model.arima2$A$aic

# Print AR,MA
print.arma(model.arima2$C)






# 3. buidling custom function using For Loop
arima_by_factor <- function(data, by, target) {
  if (class(data) != "data.frame") stop("InputValueError")
  if (class(data[[by]]) != "factor") stop("InputValueError")
  factors <- unique(data[[by]])
  model.arima3 <- list()
  for (i in factors) {
    subset_of_data <- data[data[[by]] == i, ]
    model <- auto.arima(subset_of_data[[target]])
    model.arima3[[i]] <- model
  }
  return(model.arima3)
}

system.time(model.arima3 <- arima_by_factor(panel, "country", "y"))

# time (slower than both by and dlply)
# user  system elapsed 
# 0.189   0.003   0.203 


# Are we getting the same result?
model.arima2$A$aic == model.arima3$A$aic

# Print AR,MA
print.arma(model.arima3$C)




