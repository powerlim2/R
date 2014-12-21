# Convert BQ/HIVE/SQL's GROUP_CONCAT() output to arules' transactions class.
# Author : Joon Lim

library(arules)

# <<Background>>
# "transactions" object is required for running apriori algorithm using R's famous "arules" package.
# In general, we have a couple way to make a transaction table from R:
#   1. matrix -> transaction (straightforward approach with as() command)
#   2. list -> transaction
# 
# Here I am going to introduce the second approach. 
# Oftentimes, we are building an input feature set using BigQuery, Hive or SQL.
# In SQL, "group_concat()" command is a magic that takes long format and make it wide without worrying about sparsity.
# The output of "group_concat()" gives us a K by 2 matrix with columns, which consists of 
# (basket_id, "item 1, item 2, item 3, ..., item N")
# Then we drop basket_id column and use item column only.
#
# We can read the input csv file exported from BQ/HIVE/SQL using data <- as.list(readLines("input.csv"))
#
#----------------------------------------
# expected data: what we want
data.opt <- list(
  c("1", "2", "3", "4", "5"),  # basket 1
  c("1", "2", "3"),  # bakset 2
  c("2", "4", "5"),  # bakset 3
  c("1", "5")  # basket 4
)
# ---------------------------------------

# the magic function!
rm.quotation <- function(input.list) {
  lapply(input.list, function(r) {
    row <- unlist(strsplit(r, ","))  # split
    row <- gsub("^\\s+|\\s+$", "", row)  # strip
    }
  )
}

# list comparison
same.list <- function(list1, list2) {
  rows <- c()
  for (i in 1:length(data)) {
    rows <- append(rows, all(list1[[i]] == list2[[i]]))
  }
  all(rows)
}

# -----------------------------------------


# example data: what we have
data <- list(
  c("1, 2, 3, 4, 5"),  # basket 1
  c("1, 2, 3"),  # bakset 2
  c("2, 4, 5"),  # bakset 3
  c("1, 5")  # basket 4
)

# apply the function and reshape the data
data <- rm.quotation(data)

# validation
print(same.list(data, data.opt))

# convert list to transations
data <- as(data, "transactions")
inspect(data)  # check the result

