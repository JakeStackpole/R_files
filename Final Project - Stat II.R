# Final Project 1st Draft
library(tidyverse)
library(readxl)
library(skimr)
library(moderndive)
# Read in Excel files
nhl_stats <- read_excel("player_stats_2018_19.xlsx")
# Print NHL_stats
nhl_stats
# Create offensive efficiency variable
nhl_stats_ <- nhl_stats %>%
  mutate(off_eff = PTS/S)
# Print mutated nhl_stats_
nhl_stats_
# Wrangle down nhl_stats_ to include only useful columns
nhl_s <- nhl_stats_ %>%
  select(-c(Rk,Age,GP,PIM,PS,EV...13,PP...14,SH...15,GW,EV...17,PP...18,SH...19,TOI,ATOI,BLK,HIT,FOW,FOL,'FO%','+/-','S%'))
# Drop observations with below 50 shots on net
nhl_s <- subset(nhl_s, S >= 50)
# Remove one observation known as a winger ("W")
nhl_s <- subset.data.frame(nhl_s,Pos!="W")
# Arrange offensive efficiency in descending order
nhl_s %>%
  arrange(desc(off_eff))
# Create histogram of offensive efficiency
ggplot(data = nhl_s, mapping = aes(x = off_eff)) +
  geom_histogram(color = "blue", fill = "red2",bins = 18) +
  labs(x = "Offensive Efficiency", y = "Number of Players", title = "Offensive Efficiency across the League")
# Create a boxplot of offensive efficiency by position
ggplot(nhl_s, aes(x = off_eff, y = Pos)) +
  geom_boxplot(fill = "salmon",color="blue") +
  labs(x = "Offensive Efficiency", y = "Position",
       title = "Offensive Efficiency by Position")
# Get summary stats on nhl_s
nhl_s %>% select(off_eff,G,A,PTS,S,Tm,Pos) %>% skim()
# Create a  scatterplot of offensive efficiency and goals
ggplot(nhl_s, aes(x = off_eff, y = G)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Goals",
       title = "Scatterplot of relationship of Goals and Offensive Efficiency Rating")
# Add a line of best fit
ggplot(nhl_s, aes(x = off_eff, y = G)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Goals",
       title = "Scatterplot of relationship of Goals and Offensive Efficiency Rating") + 
  geom_smooth(method = "lm", se = FALSE)
# Fit regression model
score_model <- lm(G ~ off_eff, data = nhl_s)
# Get regression table
get_regression_table(score_model)
# Get regression points
regression_points <- get_regression_points(score_model)
# Print regression_points
regression_points
# Compute correlation coefficient
nhl_s %>%
summarize(N = n(), r = cor(off_eff,G, use = "pairwise.complete.obs"))
# y^= -0.515 + 58.6 * offensive efficiency
# r^2 = 0.25
# Create a  scatterplot of offensive efficiency and assists
ggplot(nhl_s, aes(x = off_eff, y = A)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Assists",
       title = "Scatterplot of relationship of Assists and Offensive Efficiency Rating")
# Add a line of best fit
ggplot(nhl_s, aes(x = off_eff, y = A)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Assists",
       title = "Scatterplot of relationship of Assists and Offensive Efficiency Rating") + 
  geom_smooth(method = "lm", se = FALSE)
# Fit regression model
score_model2 <- lm(A ~ off_eff, data = nhl_s)
# Get regression table
get_regression_table(score_model2)
# Get regression points
regression_points2 <- get_regression_points(score_model2)
# Print regression_points
regression_points2
# Compute correlation coefficient
nhl_s %>%
  summarize(N = n(), r = cor(off_eff,A, use = "pairwise.complete.obs"))
# y^ = -9.62 + 125 * offensive efficiency
# r^2 = 0.52
# Create a  scatterplot of offensive efficiency and points
ggplot(nhl_s, aes(x = off_eff, y = PTS)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Points",
       title = "Scatterplot of relationship of Points and Offensive Efficiency Rating")
# Add a line of best fit
ggplot(nhl_s, aes(x = off_eff, y = PTS)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Points",
       title = "Scatterplot of relationship of Points and Offensive Efficiency Rating") + 
  geom_smooth(method = "lm", se = FALSE)
# Fit regression model
score_model3 <- lm(PTS ~ off_eff, data = nhl_s)
# Get regression table
get_regression_table(score_model3)
# Get regression points
regression_points3 <- get_regression_points(score_model3)
# Print regression_points
regression_points3
# Compute correlation coefficient
nhl_s %>%
  summarize(N = n(), r = cor(off_eff,PTS, use = "pairwise.complete.obs"))
# y^ = -10.1 + 184 * offensive efficiency
# r^2 = 0.49
# Create a  scatterplot of offensive efficiency and shots
ggplot(nhl_s, aes(x = off_eff, y = S)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Shots",
       title = "Scatterplot of relationship of Shots and Offensive Efficiency Rating")
# Add a line of best fit
ggplot(nhl_s, aes(x = off_eff, y = S)) +
  geom_point(aes(color= Pos)) +
  labs(x = "Offensive Efficiency Rating", 
       y = "Shots",
       title = "Scatterplot of relationship of Shots and Offensive Efficiency Rating") + 
  geom_smooth(method = "lm", se = FALSE)
# Fit regression model
score_model4 <- lm(S ~ off_eff, data = nhl_s)
# Get regression table
get_regression_table(score_model4)
# Get regression points
regression_points4 <- get_regression_points(score_model4)
# Print regression_points
regression_points4
# Compute correlation coefficient
nhl_s %>%
  summarize(N = n(), r = cor(off_eff,S, use = "pairwise.complete.obs"))
# y^ = 102 + 152 * offensive efficiency
# r^2 = .048



