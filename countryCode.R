getwd()

library(tidyverse)
f <- file.choose()
df <- read_csv(f, col_names = TRUE)
head(df)
glimpse(df)
names(df)

df$country
median(df$area, na.rm = TRUE) #gives median area, need to specify the na.rm as true
#because there are NA values
median(df$population, na.rm = TRUE)
df$popDensity <- df$population / df$area #by having the df$ before the name of the variable
#it adds it into the data frame
#ranking in order of density
sort()

