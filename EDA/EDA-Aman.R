
library(lubridate)
a= read.csv("7EmotionsBench.csv")


sink("Deneme.txt")
summary(a)
sink()

plot(a$F_Neutral, type = "l")
