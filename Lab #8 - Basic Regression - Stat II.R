# Lab #8 - Basic Regression - Stat II
# Load packages
library(tidyverse)
library(moderndive)
library(skimr)
library(gapminder)
# Create evals_ch5 df by selecting the relevant columns
evals_ch5 <- evals %>%
  select(ID, score, bty_avg, age)
# Glimpse the df
glimpse(evals_ch5)
# Alternative EDA function is the sample_n() function from dplyr
evals_ch5 %>%
  sample_n(size = 5)
# Compute mean and median of score and bty_avg
evals_ch5 %>%
  summarize(mean_bty_avg = mean(bty_avg), mean_score = mean(score),
            median_bty_avg = median(bty_avg), median_score = median(score))
# Use skim() function from skimr to return summary stats more efficiently
evals_ch5 %>% select(score, bty_avg) %>% skim()
# Compute correlation coefficient (syntax: response~explanatory)
evals_ch5 %>% 
  get_correlation(formula = score ~ bty_avg)
# Alternative to compute correlation coefficient
evals_ch5 %>% 
  summarize(correlation = cor(score, bty_avg))
# Create a scatterplot of teaching score and beauty score
ggplot(evals_ch5, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty Score", 
       y = "Teaching Score",
       title = "Scatterplot of relationship of teaching and beauty scores")
# Use geom_jitter() to make the plot more demonstrative of the data
ggplot(evals_ch5, aes(x = bty_avg, y = score)) +
  geom_jitter() +
  labs(x = "Beauty Score", y = "Teaching Score",
       title = "Scatterplot of relationship of teaching and beauty scores")
# Add a line of best fit
ggplot(evals_ch5, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty Score", y = "Teaching Score",
       title = "Relationship between teaching and beauty scores") +  
  geom_smooth(method = "lm", se = FALSE)
# Fit regression model
score_model <- lm(score ~ bty_avg, data = evals_ch5)
# Get regression table
get_regression_table(score_model)
# Get regression points
regression_points <- get_regression_points(score_model)
# Print regression_points
regression_points
# Load gapminder dataset and filter for only obs. from 2007
library(gapminder)
gapminder2007 <- gapminder %>%
  filter(year == 2007) %>%
  select(country, lifeExp, continent, gdpPercap)
# Glimpse the data
glimpse(gapminder2007)
# Get a random sample from gapminder2007
gapminder2007 %>% sample_n(size = 5)
# Compute summary stats on lifeExp and continent
gapminder2007 %>%
  select(lifeExp, continent) %>%
  skim()
# Create a histogram of worldwide life expectancy
ggplot(gapminder2007, aes(x = lifeExp)) +
geom_histogram(binwidth = 5, color = "white") +
  labs(x = "Life expectancy", y = "Number of countries",
       title = "Histogram of distribution of worldwide life expectancies")
# Facet the histogram in order to incorporate continent
ggplot(gapminder2007, aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, color = "white") +
  labs(x = "Life expectancy", 
       y = "Number of countries",
       title = "Histogram of distribution of worldwide life expectancies") +
  facet_wrap(~ continent, nrow = 2)
# Create a boxplot for life expectancy
ggplot(gapminder2007, aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  labs(x = "Continent", y = "Life expectancy",
       title = "Life expectancy by continent")
# Compute summary stats on life expectancy by continent
lifeExp_by_continent <- gapminder2007 %>%
  group_by(continent) %>%
  summarize(median = median(lifeExp), 
            mean = mean(lifeExp))
# Fit linear regression line to the data and get the regression table
lifeExp_model <- lm(lifeExp ~ continent, data = gapminder2007)
get_regression_table(lifeExp_model)
# Get regression points
regression_points_ <- get_regression_points(lifeExp_model, ID = "country")
# Print regression_points
regression_points_
# Compute sum of squared residuals of score model
# Compute sum of squared residuals
regression_points %>%
  mutate(squared_residuals = residual^2) %>%
  summarize(sum_of_squared_residuals = sum(squared_residuals))

