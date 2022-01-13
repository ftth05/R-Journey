##################
# Sources:
  # https://www.youtube.com/watch?v=JW5Ug6NQexg&ab_channel=DataProfessor
  # 
##################

dir = dirname(rstudioapi::getSourceEditorContext()$path)
setwd(dir)
getwd()


#Load Iris data set

# Method1
library(datasets)
data(iris)
iris<- datasets::iris
# Method 2
library(RCurl)
dt<- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/iris.csv"))

#View data
View(dt)

# Display Summary Statistic
head(dt,4)
tail(dt,4)

#summary()
summary(dt)
# only Sepal Length Summary
summary(dt$Sepal.Length)
summary(dt[1])

# Check to see if there are missing data

sum(is.na(dt))

# skimr() - expands on summary() by providing larger set of statistics
#  install.packages("skimr")
# https://github.com/ropensci/skimr

library(skimr)

skim(dt)
skim(iris)

# group data by Species then perform skim

dt %>%
  dplyr::group_by(Species) %>%
  skim()







