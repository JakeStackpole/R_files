# Lab #4 - Data Visualization 2 - Stat II
library(nycflights13)
library(ggplot2)
library(dplyr)
# create a faceted plot of the temperature data by month and run it
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month)
# Change nrow = 4 which instructs R to abandon the default rows that it used and
# create a faceted histograms of 4 rows
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month, nrow = 4)
# create a faceted boxplot graph by month
ggplot(data = weather, mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()
# pass in the column representation of the fruits data frame i.e when
# the counts are not pre-counted use geom_bar()
ggplot(data = fruits, mapping = aes(x = fruit)) +
  geom_bar()
# pass in the fruits_counted data frame but use geom_col() layer when
# you have pre-counted data
ggplot(data = fruits_counted, mapping = aes(x = fruit, y = number)) +
  geom_col()
# Visualize carrier variable in the flights df using barplots
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()
# Add another aesthetic mapping call to ggplot()
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar()
# Create a side-by-side barplot
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar(position = position_dodge(preserve = "single"))
# Create a faceted barplot
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar() +
  facet_wrap(~ origin, ncol = 1)
# Create a barplot of the carrier variable in the flights df using more concise code
ggplot(flights, aes(x = carrier)) +
  geom_bar()
