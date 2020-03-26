# Lab #4 - Data Visualization 2 - Stat II
library(nycflights13)
library(ggplot2)
library(dplyr)
# Chapter 2.6 - Facets
# Faceting is used when we want to split a particular visualization by the values of
# another variable. It creates multiple copies of the same type of graph (same x & y
# axes but the content differs:
#   > Add a layer to our ggplot - facet_wrap(~some_variable)
#   > Tilde is required
#   > Can specify the number of rows and columns - facet_wrap(~some_variable,nrow=4)
# Copy the code to create a facet plot of the temperature data by month and run it
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month)
# Change nrow = 4 which instructs R to abandon the default rows that it used and
# create a faceted histograms of 4 rows
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 5, color = "white") +
  facet_wrap(~ month, nrow = 4)
# Complete LC2.18-2.21 in word doc.Include graph and reference it
# Chapter 2.7 - Boxplots
# Boxplots are constructed from the information provided in the 5 number summary
# of a numerical variable (Q-data)
# The 5-number summary consists of five summary stats: the minimum, the 1st quartile,
# the 2nd quartile median, the 3rd quartile, and the maximum
# The quantities are calculated as 
#   > first quartile (Q1): the median of the first half of the sorted data
#   > third quartile (Q3): the median of the second half of the sorted data
# The interquartile range (IQR) is defined as Q3-Q1 and is a measure of how spread
# out the middle 50% of values are. The IQR corresponds to the length of the box in
# a boxplot
# The median and the IQR are not influenced by the prescence of outliers in the ways
# that the mean and standard deviation are. They are, thus, recommended for skewed
# datasets. We say in this case that the median and IQR are more robust to outliers
# Notice the whiskers stick out of a boxplot from either end of the box to the
# values of 1.5*IQR. Any obs. units outside this range are identified as "outliers"
# Boxplots require a categorical variable to be mapped to the x-position aesthetic
# factor() is used to convert a numerical variable (such as month) into a factor
# categorical variable
# Copy code to create a faceted boxplot graph by month
ggplot(data = weather, mapping = aes(x = factor(month), y = temp)) +
  geom_boxplot()
# Complete LC2.22-LC2.25
# Chapter 2.8 - Barplots
# Both histograms and boxplots are tools to visualize quantitative data (Q-data)
# Barplots allow us to visualize counts of different categories of categorical data
# When data is "read in from an external file", the data may not be summarized in
# counts for you
# Copy code and pass in the column representation of the fruits data frame i.e when
# the counts are not pre-counted use geom_bar()
ggplot(data = fruits, mapping = aes(x = fruit)) +
  geom_bar()
# Copy code and pass in the fruits_counted data frame but use geom_col() layer when
# you have pre-counted data
ggplot(data = fruits_counted, mapping = aes(x = fruit, y = number)) +
  geom_col()
# Visualize using barplots the carrier variable in the flights df. Note the data is
# not pre-counted so we will use the geom_bar() function and there is just one
# variable in aesthetic mapping
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()
# Inspect the outcome of the ggplot
# Complete LC2.26-LC2.29
# Chapter 2.8.2 - Avoid Pie Charts
#   > In general, statisticians tend to avoid the overused pie charts
#   > Hard to use the pie chart for comparisons
# Complete LC2.30-LC2.31
# Chapter 2.8.3 - Two Categorical Variables
#   > Visualizing the joint distribution of two categorical variables at the same
#     time through stacked barplots
# Copy code adding another aesthetic mapping to the call to ggplot()
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar()
#    > fill aesthetic corresponds to the color used to fill the bars while the color
#    aesthetic corresponds to the color of the outline of the bars. Fill is another
#    aesthetic mapping much like x-position, thus it appears inside of the aes()
# An alternative to stacked barplots are side-by-side barplots or dodged barplots.
# To generate the side-by-side barplots we need to override the default variable in
# the geom_bar() to geom_bar(position = "dodge"). A change to the position argument
# will make sure the bars are the same size in terms of width
# geom_bar(position = position_dodge(preserve = "single"))
# Copy code to get an example of a side-by-side barplot
ggplot(data = flights, mapping = aes(x = carrier, fill = origin)) +
  geom_bar(position = position_dodge(preserve = "single"))
# Another type of barplot is a faceted barplot, where instead of mapping a variable
# to fill we include it as the variable to create small multiples of the plot across
# different levels. For example, facet_wrap(~ origin) will create faceted barplots
# Copy code to get an example of a faceted barplot
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar() +
  facet_wrap(~ origin, ncol = 1)
# Complete LC2.32-2.37
# Chapter 2.9 - Conclusion
# Table 2.4 is a nice summary of the Five Named Graphs
# Segment 1:
ggplot(data = flights, mapping = aes(x = carrier)) +
  geom_bar()

# Segment 2:
ggplot(flights, aes(x = carrier)) +
  geom_bar()
# "data =" and "mapping =" are arguments to ggplot that are defaulted and understood
# that the first argument is the df and the second is the aes() mapping. Therefore,
# it is common to omit these argument specifications in code