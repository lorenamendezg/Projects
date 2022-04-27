install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")
library(tidyverse)
library(lubridate)
library(ggplot2)

##s1
s1 <- read_csv("s1.csv")
s1 <- s1 %>% 
  select(-c(...1))

##s2
s2 <- read_csv("s2.csv")
s2 <- s2 %>% 
  select(-c(...1))

annual <- bind_rows(s1,s2)

colnames(annual)


str(annual)


##-----------------------------------------------------

nrow(anual)
dim(anual)
head(annual)
str(annual)
summary(annual)

annual$date <- as.Date(annual$started_at)
annual$month <- format(as.Date(annual$started_at), "%m")
annual$day <- format(as.Date(annual$started_at), "%d")
annual$year <- format(as.Date(annual$started_at), "%Y")
annual$day_of_week <- format(as.Date(annual$started_at), "%A")


annual$ride_length <- difftime(annual$ended_at,annual$started_at)

is.factor(annual$ride_length)
annual$ride_length <- as.numeric(as.character(annual$ride_length))
is.numeric(annual$ride_length)

annualv2 <- annual[!(annual$ride_length<0),]

#Descriptive Analysis

mean(annualv2$ride_length)
median(annualv2$ride_length)
max(annualv2$ride_length)
min(annualv2$ride_length)

summary(annualv2$ride_length)

# Compare members and casual users --- generate new tables with data
aggregate(annualv2$ride_length ~ annualv2$member_casual, FUN = mean)

aggregate(annualv2$ride_length ~ annualv2$member_casual, FUN = median)
aggregate(annualv2$ride_length ~ annualv2$member_casual, FUN = max)
aggregate(annualv2$ride_length ~ annualv2$member_casual, FUN = min)

#now compare include day o week sin ordenar
aggregate(annualv2$ride_length ~ annualv2$member_casual + annualv2$day_of_week, FUN = mean)

#order day of week
annualv2$day_of_week <- ordered(annualv2$day_of_week,
                                levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))


