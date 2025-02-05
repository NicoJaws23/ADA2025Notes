f <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/IMDB-movies.csv"
d <- read_csv(f, col_names = TRUE)
head(d)
library(tidyverse)
library(dplyr)
#add comedy variable based on if genre column has comedy. COlumn says TRUE if one of the
d %>% 
  mutate(Comedy = if_else(genres = Comedy, TRUE, FALSE))
