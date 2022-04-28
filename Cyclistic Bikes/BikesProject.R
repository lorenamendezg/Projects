install.packages("tidyverse")
install.packages("lubridate")

library(tidyverse)
library(lubridate)


##q4
mar_2022 <- read_csv("202203-divvy-tripdata.csv")
feb_2022 <- read_csv("202202-divvy-tripdata.csv")
jan_2022 <- read_csv("202201-divvy-tripdata.csv")
##q3
dec_2021 <- read_csv("202112-divvy-tripdata.csv")
nov_2021 <- read_csv("202111-divvy-tripdata.csv")
oct_2021 <- read_csv("202110-divvy-tripdata.csv")
##q3 y q4 = s2a
q3 <- read_csv("q3.csv")
q4 <- read_csv("q4.csv")
s2a <- read_csv("s2a.csv")


q4 <- bind_rows(mar_2022, feb_2022, jan_2022)
q3 <- bind_rows(dec_2021, nov_2021)
s2a <- bind_rows(oct_2021, s2)

q4 <- q4 %>% 
  select(-c(start_station_name, start_station_id, end_station_name, 
            end_station_id, start_lat, start_lng, end_lat, end_lng))
q3 <- q3 %>% 
  select(-c(start_station_name, start_station_id, end_station_name, 
            end_station_id, start_lat, start_lng, end_lat, end_lng))

oct_2021 <- oct_2021 %>% 
  select(-c(start_station_name, start_station_id, end_station_name, 
            end_station_id, start_lat, start_lng, end_lat, end_lng))

s2 <- s2 %>% 
  select(-c(...1, ...2))

write.csv(q4, "q4.csv")
write.csv(q3, "q3.csv")
write.csv(s2a, "s2a.csv")

##---------- primer semestre

##q1
apr_2022 <- read_csv("202104-divvy-tripdata.csv")
may_2022 <- read_csv("202105-divvy-tripdata.csv")
jun_2022 <- read_csv("202106-divvy-tripdata.csv")

q1 <- bind_rows(apr_2022, may_2022, jun_2022)

q1 <- q1 %>% 
  select(-c(start_station_name, start_station_id, end_station_name, 
            end_station_id, start_lat, start_lng, end_lat, end_lng))

write.csv(q1, "q1.csv")

##q2
jul_2021 <- read_csv("202107-divvy-tripdata.csv")
aug_2021 <- read_csv("202108-divvy-tripdata.csv")
sep_2021 <- read_csv("202109-divvy-tripdata.csv")

q2 <- bind_rows(jul_2021, aug_2021, jul_2021)

q2 <- q2 %>% 
  select(-c(start_station_name, start_station_id, end_station_name, 
            end_station_id, start_lat, start_lng, end_lat, end_lng))

write.csv(q2, "q2.csv")

q1 <- read_csv("q1.csv")
q2 <- read_csv("q2.csv")
s1 <- bind_rows(q1, q2)
s1 <- s1 %>% 
  select(-c(...1))

write.csv(s1, "s1.csv")