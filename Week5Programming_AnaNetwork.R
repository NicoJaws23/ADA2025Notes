#Data wrangling challenge
library(tidyverse)

fBehave <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/sample_behavioral_data.csv"
fGPS <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/sample_gps_data.csv"

gps <- read_csv(fGPS, col_names = TRUE)
beh <- read_csv(fBehave, col_names = TRUE)

#Split Date.Time into Date and Time Column
beh <- beh |>
  separate_wider_delim(cols = Date.Time, 
                       delim = " ", 
                       names = c("Date", "Time"), 
                       too_few = "align_start", too_many = "drop",
                       cols_remove = FALSE)

#Split Date into Year, Month, Day
beh <- beh |>
  separate_wider_delim(cols = Date,
                       delim = "-",
                       names = c("Year", "Month", "Day"),
                       too_few = "align_start", too_many = "drop",
                       cols_remove = FALSE)
#use filter function to filter for years 2012-2014
my_filter <- function(x, condition, variable){
  library(tidyverse)
  x <- x |> filter(!!sym(variable) %in% condition)
  return(x)
}  

beh <- my_filter(beh, condition = c(2012, 2013, 2014), variable = "Year")

#join by Date.time and observer
behGps <- left_join(beh, gps, by = c("Observer" = "Observer", "Date.Time" = "Date.Time"))

library(oce)
behGps <- behGps |>
  rowwise() |>
  mutate(
    easting = lonlat2utm(`Mean.Longitude`, `Mean.Latitude`)$easting,
    northing = lonlat2utm(`Mean.Longitude`, `Mean.Latitude`)$northing + 10000000
  )
#Filtering for Vita
behGps <- my_filter(behGps, condition = c("Ana"), variable = "Focal.Animal") |>
  filter(!is.na(easting))

plot(behGps$easting, behGps$northing)
