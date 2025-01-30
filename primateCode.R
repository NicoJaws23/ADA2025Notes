library(tidyverse)
f <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/KamilarAndCooperData.csv"
d <- read_csv(f, col_names = TRUE) #Reads file in as a tibble
#Useful functions, all used to learn different attributed about the data
head(d)
tail(d)
str(d)
glimpse(d)
dim(d)
names(d)
colnames(d)
rownames(d)

attach(d) #means I dont have to use d$xyz
mean(Brain_Size_Species_Mean, na.rm = TRUE)

detach(d)
#Go back to 2025-01-30 notes
summarize(d)
