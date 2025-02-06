f <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/IMDB-movies.csv"
d <- read_csv(f, col_names = TRUE)
head(d)
library(tidyverse)
library(dplyr)
library(stringr)
#add comedy variable based on if genre column has comedy. COlumn says TRUE if one of the

d <- d |>
  mutate(Comedy = if_else(grepl("CoMeDy", genres, ignore.case = TRUE), TRUE, FALSE))
#looking at genres column, need to look at each cell in column and see if comedy appears,
#have new 'Comedy" variable be true or false depending on presence of 'Comedy"
#grepl() has 2 arguments, what its looking for and where to look for it, looks for that value
#anywhere in the field, as long as its these it'll take it, Having ignore.case set to true
#will remove the case sensitivity

d <- d |>
  mutate(Comedy = if_else(str_detect(genres, "Comedy"), TRUE, FALSE))
#str_detect does the same as grepl() but the arguemtns are reversed

#here we summarize (1) the total number of movies using n() which gives the total number of
#rows and (2) the total number of comedy movies with sum() which totals the number of cells
#which = TRUE
s <- d |>
  summarise(count = n(), comedyCount = sum(Comedy))

#part 3 of challenge, add new variable for ranking using case_when()
#this code arranges the ranking of the 
d <- d |>
  mutate(ranking = case_when(
    averageRating > 0 & averageRating < 3.3 ~ "low",
    averageRating >= 3.3 & averageRating < 6.7 ~ "med",
    averageRating >= 6.7 & averageRating < 10 ~ "high"
  ))
r <- d |>
  group_by(genres) |>
  summarise(cound = n(), meanRT = mean(runtimeMinutes, na.rm = TRUE))
