install.packages("tidyverse")
install.packages("lubridate")

library(tydiverse)
library(lubridate)

a <- read.csv("202201-divvy-tripdata.csv")

colnames(a)
head(a)
str(a)
summary(a)