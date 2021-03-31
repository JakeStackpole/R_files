# Lab 6 - Data Wrangling 2 - Stat II
# Load packages
library(dplyr)
library(ggplot2)
library(nycflights13)
# Convert temp variable into Celsius
weather <- weather %>% 
  mutate(temp_in_C = (temp - 32) / 1.8)
# Compute monthly average temps in Celsius and Fahrenheit
summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean_temp_in_F = mean(temp, na.rm = TRUE), 
            mean_temp_in_C = mean(temp_in_C, na.rm = TRUE))
# Print summary_monthly_temp
summary_monthly_temp
# Create gain variable
flights <- flights %>% 
  mutate(gain = dep_delay - arr_delay)
# Get summary statistics on gain
gain_summary <- flights %>% 
  summarize(
    min = min(gain, na.rm = TRUE),
    q1 = quantile(gain, 0.25, na.rm = TRUE),
    median = quantile(gain, 0.5, na.rm = TRUE),
    q3 = quantile(gain, 0.75, na.rm = TRUE),
    max = max(gain, na.rm = TRUE),
    mean = mean(gain, na.rm = TRUE),
    sd = sd(gain, na.rm = TRUE),
    missing = sum(is.na(gain))
  )
# Print gain_summary
gain_summary
# Create a histogram of gain
ggplot(data = flights, mapping = aes(x = gain)) +
  geom_histogram(color = "white", bins = 20)
# Create gain_per_hour using variables that were just created
flights <- flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
  )
# Create freq_dest variable to illustrate the most popular domestic destination in
# flights
freq_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n())
# Print freq_dest
freq_dest
# Sort output using arrange() (sorts in ascending order)
freq_dest %>% 
  arrange(num_flights)
# Sort output from most to least flights by appending desc() to the arrange() funct.
freq_dest %>% 
  arrange(desc(num_flights))
# Join the flights and airlines dataframes
flights_joined <- flights %>% 
  inner_join(airlines, by = "carrier")
# Join the flights and airports dataframes by airport code
flights_with_airport_names <- flights %>% 
  inner_join(airports, by = c("dest" = "faa"))
# Compute # of flights from NYC to each destination w info on each destination
named_dests <- flights %>%
  group_by(dest) %>%
  summarize(num_flights = n()) %>%
  arrange(desc(num_flights)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  rename(airport_name = name)
# Print named_dests
named_dests
# Join weather and flights dataframes using multiple key variables
flights_weather_joined <- flights %>%
  inner_join(weather, by = c("year", "month", "day", "hour", "origin"))
# Join flights and airlines dataframes by carrier
joined_flights <- flights %>% 
  inner_join(airlines, by = "carrier")
# Use select() function to select just carrier and flight out of flights df
flights %>% 
  select(carrier, flight)
# Deselect the year variable
flights_no_year <- flights %>% select(-year)
# Another way of selecting variables is to specify a range
flight_arr_times <- flights %>% select(month:day, arr_time:sched_arr_time)
# Print flight_arr_times
flight_arr_times
# Reorder flights so that time and date variables are adjacent while keeping every-
# thing else
flights_reorder <- flights %>% 
  select(year, month, day, hour, minute, time_hour, everything())
# Examples of helper functions that allow for more nuanced selections
flights %>% select(starts_with("a"))
flights %>% select(ends_with("delay"))
flights %>% select(contains("time"))
# Rename arr_time and dep_time in the flights_time_new df
flights_time_new <- flights %>% 
  select(dep_time, arr_time) %>% 
  rename(departure_time = dep_time, arrival_time = arr_time)
# Create named_dests to find the top 10 destinations
named_dests %>% top_n(n = 10, wt = num_flights)
# Arrange the output in descending order
named_dests  %>% 
  top_n(n = 10, wt = num_flights) %>% 
  arrange(desc(num_flights))
# LC3.19
top_five <- flights %>% 
  group_by(dest) %>% 
  summarize(avg_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(desc(avg_delay)) %>% 
  top_n(n = 5)
# Print top_five
top_five
