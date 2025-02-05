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

library(ggplot2) #grammar of graphics package
ggplot(data = d, aes(x = log(Body_mass_female_mean), y = log(Brain_Size_Female_Mean))) +
  geom_point() #create the geometry for how the data will be visualized

#adding regression line
ggplot(data = d, aes(x = log(Body_mass_female_mean), y = log(Brain_Size_Female_Mean))) +
  geom_point(na.rm= TRUE) + #create the geometry for how the data will be visualized
  geom_smooth(method= "lm", na.rm = TRUE)

ggplot(data = d, aes(x = log(Body_mass_female_mean), y = log(Brain_Size_Female_Mean))) +
  geom_point(na.rm= TRUE) + #create the geometry for how the data will be visualized
  geom_smooth(method= "lm", na.rm = TRUE) +
  geom_point(data = d, aes( x = log(Body_mass_female_mean), y = log(Body_mass_male_mean))) +
  geom_vline(xintercept = 7) + #adds verticle line at x = 7
  geom_hline(yintercept = 3) #add horizontal line at y = 3


#DATA WRANGLING TIME RAHHHHH

#Using {base} R
s <- d[d$Family == "Hominidae" & d$Mass_Dimorphism > 2,] #this is a filter function in {base} r
s <- d[, c("Family", "Genus", "Body_mass_male_mean")] #this is a select function
s <- d[order(d$Family, d$Genus, -d$Body_mass_male_mean),]#this sorts these three variables in
#order of descending body size
s <- aggregate(d$Body_mass_female_mean ~ d$Family, FUN = "mean", na.rm = TRUE)
#using dplyr
library(dplyr)
s2 <- filter(d, Family == "Hominidae" & Mass_Dimorphism > 2) #This is the filter function using filter() in {dplyr}
s2 <- select(d, Family, Genus, Body_mass_male_mean) #This is the select() function
s2 <- arrange(d, Family, Genus, desc(Body_mass_male_mean)) #this uses arrange() to sort these 3 variable
#by descening body mass
s2 <- summarise(group_by(d, Family), avgF = mean(Body_mass_female_mean, na.rm = TRUE)) #summarises
#average female body mass by family

#Flow Control and Looping




