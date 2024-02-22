Cyclistic Bikes: User Performance
================

## Why converting casual members into annual members is possible??….

We used available data to find some connections or patterns in how our
members using Cyclistic Bikes differently.

## Prepare and Clean Data

Explore our date is the most and important step in our analysis.

``` r
a <- read.csv("202201-divvy-tripdata.csv")

colnames(a)
```

    ##  [1] "ride_id"            "rideable_type"      "started_at"        
    ##  [4] "ended_at"           "start_station_name" "start_station_id"  
    ##  [7] "end_station_name"   "end_station_id"     "start_lat"         
    ## [10] "start_lng"          "end_lat"            "end_lng"           
    ## [13] "member_casual"

``` r
str(a)
```

    ## 'data.frame':    103770 obs. of  13 variables:
    ##  $ ride_id           : chr  "C2F7DD78E82EC875" "A6CF8980A652D272" "BD0F91DFF741C66D" "CBB80ED419105406" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : chr  "2022-01-13 11:59:47" "2022-01-10 08:41:56" "2022-01-25 04:53:40" "2022-01-04 00:18:04" ...
    ##  $ ended_at          : chr  "2022-01-13 12:02:44" "2022-01-10 08:46:17" "2022-01-25 04:58:01" "2022-01-04 00:33:00" ...
    ##  $ start_station_name: chr  "Glenwood Ave & Touhy Ave" "Glenwood Ave & Touhy Ave" "Sheffield Ave & Fullerton Ave" "Clark St & Bryn Mawr Ave" ...
    ##  $ start_station_id  : chr  "525" "525" "TA1306000016" "KA1504000151" ...
    ##  $ end_station_name  : chr  "Clark St & Touhy Ave" "Clark St & Touhy Ave" "Greenview Ave & Fullerton Ave" "Paulina St & Montrose Ave" ...
    ##  $ end_station_id    : chr  "RP-007" "RP-007" "TA1307000001" "TA1309000021" ...
    ##  $ start_lat         : num  42 42 41.9 42 41.9 ...
    ##  $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ end_lat           : num  42 42 41.9 42 41.9 ...
    ##  $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ member_casual     : chr  "casual" "casual" "member" "casual" ...

We worked with data from April 2021, to March 2022. Those all data was
in `.csv` files and we combine the information into a single file. For
example:

``` yaml
##Quarters

mar_2022 <- read_csv("202203-divvy-tripdata.csv")
feb_2022 <- read_csv("202202-divvy-tripdata.csv")
jan_2022 <- read_csv("202201-divvy-tripdata.csv")

q1 <- bind_rows(jan_2022, feb_2022, mar_2022)
```

This exercise we did with the remaining 9 months.

## Clean Up and Add Data

After review our columns for our analysis just using the columns related
our problem, for that reason we eliminate some information:

    q1 <- q1 %>% 
      select(-c(start_station_name, start_station_id, end_station_name, 
                end_station_id, start_lat, start_lng, end_lat, end_lng))

After all this process we get just one file clean and ready to use
called: `annualv2`

``` r
annualv2 <- read.csv("annualv2.csv")
```

### 1. Add columns that list the date, month, day, and year of each ride.

    annual$date <- as.Date(annual$started_at)
    annual$month <- format(as.Date(annual$started_at), "%m")
    annual$day <- format(as.Date(annual$started_at), "%d")
    annual$year <- format(as.Date(annual$started_at), "%Y")
    annual$day_of_week <- format(as.Date(annual$started_at), "%A")

### 2. Add a “ride_length” calculation (in seconds)

    annual$ride_length <- difftime(annual$ended_at,annual$started_at)

``` r
colnames(annualv2)
```

    ##  [1] "X"             "ride_id"       "rideable_type" "started_at"   
    ##  [5] "ended_at"      "member_casual" "date"          "month"        
    ##  [9] "day"           "year"          "day_of_week"   "ride_length"

### 3. Remove bad data (negative results)

    is.factor(annual$ride_length)
    annual$ride_length <- as.numeric(as.character(annual$ride_length))
    is.numeric(annual$ride_length)

    annualv2 <- annual[!(annual$ride_length<0),]

After all this process we get just one file clean and ready to use
called: `annualv2`

``` r
head(annualv2)
```

    ##   X          ride_id rideable_type          started_at            ended_at
    ## 1 1 6C992BD37A98A63F  classic_bike 2021-04-12 18:25:36 2021-04-12 18:56:55
    ## 2 2 1E0145613A209000   docked_bike 2021-04-27 17:27:11 2021-04-27 18:31:29
    ## 3 3 E498E15508A80BAD   docked_bike 2021-04-03 12:42:45 2021-04-07 11:40:24
    ## 4 4 1887262AD101C604  classic_bike 2021-04-17 09:17:42 2021-04-17 09:42:48
    ## 5 5 C123548CAB2A32A5   docked_bike 2021-04-03 12:42:25 2021-04-03 14:13:42
    ## 6 6 097E76F3651B1AC1  classic_bike 2021-04-25 18:43:18 2021-04-25 18:43:59
    ##   member_casual       date month day year day_of_week ride_length
    ## 1        member 2021-04-12     4  12 2021          NA        1879
    ## 2        casual 2021-04-27     4  27 2021          NA        3858
    ## 3        casual 2021-04-03     4   3 2021          NA      341859
    ## 4        member 2021-04-17     4  17 2021          NA        1506
    ## 5        casual 2021-04-03     4   3 2021          NA        5477
    ## 6        casual 2021-04-25     4  25 2021          NA          41

## Descriptive Analysis

### 1. Descriptive analysis on ride_lenght

``` r
mean(annualv2$ride_length)
```

    ## [1] 1323.422

``` r
median(annualv2$ride_length)
```

    ## [1] 713

``` r
max(annualv2$ride_length)
```

    ## [1] 3356649

``` r
min(annualv2$ride_length)
```

    ## [1] 0

In summary,

``` r
summary(annualv2$ride_length)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##       0     400     713    1323    1298 3356649

### 2. Ride_lenght by type of user

For our client is important to know which is the average by type of
user, this information is consolidate in seconds (sec).

``` r
an2 <- aggregate(annualv2$ride_length ~ annualv2$member_casual, FUN = mean)
head(an2)
```

    ##   annualv2$member_casual annualv2$ride_length
    ## 1                 casual             1947.690
    ## 2                 member              805.738

## Stay Tuned

Please visit my [**website**](https://lorenamendezg.github.io/) to know about me, contact me or hire me!


