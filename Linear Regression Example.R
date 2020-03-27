# Load packages into new script file
library(moderndive)
library(ggplot2)
library(dplyr)
# Read the LungCapDataR.csv file and store the results in a data frame called LungCapDF
LungCapDF <- read.csv("LungCapDataR.csv",header = TRUE,stringsAsFactors = TRUE)
# Utilize the glimpse() function to verify the LungCapDF was read in correctly
glimpse(LungCapDF)
# Utilize the summarize() function from moderndive to get summary statistics on LungCap
LungCapDF %>%
  summarize(meanLC = mean(LungCap), medianLC = median(LungCap), sd_LC = sd(LungCap))
# Create a histogram of the LungCap using a binwidth = 1. Label axes and fill with color.
ggplot(LungCapDF, aes(x = LungCap)) + geom_histogram(binwidth = 1, color = "blue", fill = "lightblue") + labs( x = "Lung Capacity", y = "Count", title = "Lung Capacity")
# Create a scatterplot of the Lung Capacity and Age utilizing ggplot() function.
ggplot(LungCapDF, aes(x = Age, y = LungCap)) + geom_point(color = "darkgreen") + labs(x = "Age", y = "Lung Capacity", title = "Lung Capacity over Age")
# Add "best-fitting" line by adding geom_smooth layer to the ggplot() function
ggplot(LungCapDF, aes(x = Age, y = LungCap)) + geom_point(color = "darkgreen") + labs(x = "Age", y = "Lung Capacity", title = "Lung Capacity over Age") + geom_smooth(method = "lm", se = FALSE)
# Fit linear regression model between LungCap and Age using the lm() function and save this to Model_LungCap
Model_LungCap <- lm(LungCap ~ Age, data = LungCapDF)
# Use the get_regression_table() function from the moderndive package to format the output from the lm function. Report regression line
get_regression_table(Model_LungCap)
# Intercept = 1.15 , Age = 0.545
# y^ = 1.15 + 0.545 * Age (or x)
# Use the regression line to predict the Lung Capacity for an 11 year old
# 7.4
# Apply get_regression_points() function from the moderndive package to automate making predictions and computing residuals
get_regression_points(Model_LungCap)
# Compute the correlation coefficient for all non-missing pairs
LungCapDF %>%
  summarize(N = n(), r = cor(Age,LungCap, use = "pairwise.complete.obs"))