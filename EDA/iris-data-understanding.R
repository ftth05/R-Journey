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

#############################
# Quick data visualization
# R base plot()
#############################

# Panel plots
plot(dt)
plot(dt, col= "red")

# Scatter plot

plot(dt$Sepal.Width, dt$Sepal.Length)
plot(dt$Sepal.Width, dt$Sepal.Length, col= "red")
plot(dt$Sepal.Width, dt$Sepal.Length, col = "red", 
     xlab = "Sepal Width", ylab = "Sepal Length")

# Histogram 
hist(dt$Sepal.Width, col = "red", main = "Sepal Width Density",
     xlab = "Sepal Width in cm", freq = T)

# Return Value of hist()
# https://www.datamentor.io/r-programming/histogram/
h<- hist(dt$Sepal.Width, main = "Sepal Width main", xlab = " xlab Sepal Width" )
text(h$mids,h$counts,labels = h$counts, adj = c(0.5, -0.5))


hist(dt$Sepal.Width, breaks= 4, col = "darkmagenta", main = "Sepal Width with breaks = 4",
     xlab = "Sepal Width in cm", freq = T)

hist(dt$Sepal.Width, breaks= 20, col = "darkmagenta", main = "Sepal Width with breaks = 20",
     xlab = "Sepal Width in cm", freq = T)


# Feature plots
# https://www.machinelearningplus.com/machine-learning/caret-package/

library(caret)
featurePlot(x = iris[,1:4], 
            y = iris$Species, 
            plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")))



library(ggplot2)
library(cowplot)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + 
  theme_cowplot(12)+
  background_grid()+
  labs(x= "Sepal Length", y = "Sepal Width",title = "Sepal Width as a Function of Sepal Length",
       subtitle = "Data from R. A. Fischer's iris dataset, 1936",
       caption = "Made in R with ggplot2") +
  theme(text = element_text(size = 12),
        axis.text = element_text(size = 10),
        legend.position = "top")+
  #geom_smooth()+ 
  geom_point() 
#geom_line()


# minimal horizontal grid theme
ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha = 0.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_hgrid(12)




