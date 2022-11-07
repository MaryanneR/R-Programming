
getwd()

original <- read.csv(file.choose())
str(original)
summary(original)
head(original)
tail(original)

data1960 <- original[original$Year == 1960,]
data2013 <- original[original$Year == 2013,]

nrow(data1960)
nrow(data2013)

add1960 <- data.frame(Country_Code, Life_Expectancy_At_Birth_1960)
add2013 <- data.frame(Country_Code, Life_Expectancy_At_Birth_2013)

nrow(add1960)
nrow(add2013)
summary(add1960)
summary(add2013)

merged1960 <- merge(data1960, add1960, by.x="Country.Code", by.y="Country_Code")
merged2013 <- merge(data2013, add2013, by.x="Country.Code", by.y="Country_Code")

str(merged1960)
summary(merged1960)
str(merged2013)
summary(merged2013)

merged1960$Year <- NULL
merged2013$Year <- NULL

library(ggplot2)

qplot(data=merged1960, x=Fertility.Rate, y=Life_Expectancy_At_Birth_1960,
      color=Region, alpha=0.6, main="Life Expectancy vs. Fertility (1960)")

qplot(data=merged2013, x=Fertility.Rate, y=Life_Expectancy_At_Birth_2013,
      color=Region, alpha=0.6, main="Life Expectancy vs. Fertility (2013)")
