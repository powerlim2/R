# sample size calculation: pooled sample
# Author: Joon Lim
# Date: 2015.02.13


samplesize <- function(p1, p2, nratio, alpha, power) {
  # returns the sample size for two groups
  
  # ---- input features ----
  # p1: Baseline prop
  # p2: alternative Prop
  # nratio: lager sample / smaller sample
  # alpha: type I error
  # power: 1 - type II error (beta)
  for (value in c("p1", "p2", "alpha", "power")) {
    if (get(value) > 1 | get(value) < 0) stop(paste("ValueError: 0 <=", value, "<= 1"))
  }
  if (nratio < 1) stop("ValueError: larger Sample / smaller Sample >= 1")
  
  n = (1 + nratio) / nratio * (p1 * (1 - p1) * (qnorm(power) + qnorm(1 - alpha/2))^2) / (p1 - p2)^2
  return(c(round(nratio * n), round(n)))
}


# test
sizes <- samplesize(0.5, 0.6, 1.3, 0.05, 0.8)
cat(paste("sample size for group 1:", sizes[1], "\nsample size for group 2:", sizes[2]))

# sample size for group 1: 451 
# sample size for group 2: 347
