# Lab 5 - Data Wrangling
# Load packages
library(dplyr)
library(ggplot2)
library(nycflights13)
# Create alaska_flights df
alaska_flights <- flights %>% 
  filter(carrier == "AS")
# Create portland_flights df and verify that only flights from NYC to PDX are
# included
portland_flights <- flights %>% 
  filter(dest == "PDX")
View(portland_flights)
# Create btv_sea_flights_fall df by subsetting flights df by observations with
# origin of JFK, headed to Burlington, VT or Seattle, WA, and left in Oct, Nov, or Dec
btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK", (dest == "BTV" | dest == "SEA"), month >= 10)
View(btv_sea_flights_fall)
# Create df of all flights not headed to Burlington, VT or Seattle, WA
not_BTV_SEA <- flights %>% 
  filter(!(dest == "BTV" | dest == "SEA"))
View(not_BTV_SEA)
# Create new df subsetting by observations headed to additional airports
many_airports <- flights %>% 
  filter(dest %in% c("SEA", "SFO", "PDX", "BTV", "BDL"))
View(many_airports)
# Create summary_temp df to store summary stats on weather df
summary_temp <- weather %>% 
  summarize(mean = mean(temp, na.rm = TRUE), 
            std_dev = sd(temp, na.rm = TRUE))
# Print summary_temp
summary_temp
# Modify summarize call to count the data as well
weather %>% 
  summarize(count = n())
# Group mean and standard dev. summary stats by month
summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean = mean(temp, na.rm = TRUE), 
            std_dev = sd(temp, na.rm = TRUE))
# Print summary_monthly_temp
summary_monthly_temp
# Run diamonds to visualize diamonds df
diamonds
# Pipe diamonds df to group by cut
diamonds %>% 
  group_by(cut)
# Create new df to calculate average price
diamonds %>% 
  group_by(cut) %>% 
  summarize(avg_price = mean(price))
# We can also remove this condition using the ungroup() function
diamonds %>% 
  group_by(cut) %>% 
  ungroup()
# Create by_origin df to count how many flights left each of the three NYC airports
by_origin <- flights %>% 
  group_by(origin) %>% 
  summarize(count = n())
# Print by_origin
by_origin
# Group by_origin by month and store it in by_origin_monthly
by_origin_monthly <- flights %>% 
  group_by(origin, month) %>% 
  summarize(count = n())
# Print by_origin_monthly
by_origin_monthly
# Group weather data by day
summary_temp_by_day <- weather %>% 
  group_by(year, month, day) %>% 
  summarize(
    mean = mean(temp, na.rm = TRUE),
    std_dev = sd(temp, na.rm = TRUE)
  )
# Print summary_temp_by_day
summary_temp_by_day
# Modify by_monthly_origin to be grouped by month first, and then origin
by_monthly_origin <- flights %>% 
  group_by(month, origin) %>% 
  summarize(count = n())
# Print by_monthly_origin
by_monthly_origin
# Identify how many flights left each airport by carrier
count_flights_by_airport <- flights %>% 
  group_by(origin, carrier) %>% 
  summarize(count=n())
# Print count_flights_by_airport
count_flights_by_airport
