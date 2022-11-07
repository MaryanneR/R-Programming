
#----------------------------- Importing Data into R

?read.csv()

#Select File
stats <- read.csv("P2-Demographic-Data.csv")


#-------------------------Exploring Data

stats

nrow(stats)
ncol(stats)
head(stats)
tail(stats)
str(stats)
summary(stats)


#----------------------------- Using the $ Sign

stats
head(stats)
stats[3,3]
stats[3, "Birth.rate"]
stats$Internet.users
stats$Internet.users[2]
stats[,"Internet.users"]
levels(stats$Income.Group)


#----------------------------- Basic Operations with a Data Frame

stats[1:10,] # subsetting
stats[3:9,]
stats[c(4,100),]
#Remember how [] work:
is.data.frame(stats[1,])  # no need for drop=F
is.data.frame(stats[,1,drop=F])
stats[,1,drop=F]
# multiply columns
head(stats)
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users
# add column
head(stats)
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
#test of knowledge
stats$xyz <- 1:5
head(stats, n=10) #vector xyz is recycled because stats is a multiple of xyz
# remove a column
head(stats)
stats$xyz <- NULL
stats$MyCalc <- NULL


#----------------------------- Filtering Data Frames

head(stats)
filter <- stats$Internet.users < 2
stats[filter,]

stats[stats$Birth.rate > 40,]
stats[stats$Birth.rate >40 & stats$Internet.users < 2,]
stats[stats$Income.Group == "High income",]
stats[stats$Country.Name == "Malta",]


#install.packages("ggplot2")
library(ggplot2)
?qplot()

qplot(data=stats, x=Internet.users)
qplot(data=stats, x=Income.Group, y=Birth.rate)
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3))
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3), 
      color=I("blue"))
qplot(data=stats, x=Income.Group, y=Birth.rate, geom="boxplot")
qplot(data=stats, x=Internet.users, y=Birth.rate)


#------------------------- Visualizing what we need

qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4), color=I("red"))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4), color=Income.Group)


#------------------------- Creating Data Frames

mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, 
                   Regions_2012_Dataset)
head(mydf)
#colnames(mydf) <- c("Country", "Code", "Region")
rm(mydf)

mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset, 
                   Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)


#------------------------- Merging Data Frames

head(mydf)
head(stats)

merged <- merge(stats, mydf, by.x="Country.Code", by.y="Code")
head(merged)

merged$Country <- NULL
str(merged)
tail(merged)


#-------------------------  Visualizing With New Split

qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region)

#1. Shapes
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, shape=I(23))

#2. Transparency
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, shape=I(19), alpha=I(0.6))

#3. Title
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, shape=I(19), alpha=I(0.6),
      main="Birth Rate vs. Internet Users")
