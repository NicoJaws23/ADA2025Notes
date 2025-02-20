#Module 13 Notes
library(tidyverse)
library(mosaic)
library(cowplot)
library(manipulate) #lets us create interactive plot to change something about a
#value being plotted

outcomes <- c(1, 2, 3, 4, 5, 6)
manipulate(histogram(sample(x = outcomes, size = n, replace = TRUE), breaks = c(0.5,
    1.5, 2.5, 3.5, 4.5, 5.5, 6.5), type = "density", main = paste("Histogram of Outcomes of ",
    n, " Die Rolls", sep = ""), xlab = "Roll", ylab = "Probability"), n = slider(0,
   10000, initial = 100, step = 100))

roll <-function(nrolls = 1){
  sample(1:6, nrolls, replace = TRUE)
}
nrolls <- 1000
two_dice <- roll(nrolls) + roll(nrolls)
histogram(two_dice, breaks = c(1.5:12.5), type = "density", main = "Rolling Two Dice", xlab = "Sum of Rolls", ylab = "Proability")

#probability for a coind flip to be heads to tails
#Probability Mass Functions, associated with discrete random variables
outcomes <- c("heads", "tails")
prob <- c(1/2, 1/2)
barplot(prob, ylim = c(0, 0.6), names.arg = outcomes, space = 0.1, xlab = "outcome", ylab = "Pr(x = outcome)", main = "Probability Mass Function")

#Beta distribution functions
pbeta(0.75, 2, 1) #gives cumulative probability directly
dbeta(0.75, 2, 1) #give the point estimate of the beta density function at the value of the argument
qbeta(0.5625, 2, 1) #convers of pbeta(), gives quantile of cumulative dist function

set.seed(1)
x <- rnorm(1e+06, 25, 5)
histogram(x, type = "density")
mu <- mean(x)
signma <- sqrt(sum((x - mean(x))^2/length(x)))

#CI function
CI <- function(x, level = 0.95) {
  alpha <- 1 - level
  ci <- mean(x) + c(-1, 1) * qnorm(1 - (alpha/2)) * sqrt(var(x)/length(x))
  return(ci)
}
v <- rnorm(10000, 25, 10)
s <- sample(v, size = 40, replace = FALSE)
CI(s)
