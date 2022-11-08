
getwd()

movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", 
                      "BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

factor(movies$Year)
movies$Year <- factor(movies$Year)

factor(movies$Genre)
movies$Genre <- factor(movies$Genre)

summary(movies)
str(movies)


#------------ Aesthetics

library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#add geometries
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre)) + 
  geom_point()

#specify size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre,
                        size=BudgetMillions, alpha=0.6)) + 
  geom_point()
#>>> This #1 (we will improve it)


#------------ Plotting with Layers

p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre,
                             size=BudgetMillions, alpha=0.6))

#point
p + geom_point()

#lines
p + geom_line()

#multiple layers
p + geom_point() + geom_line()
p + geom_line() + geom_point()


#------------ Overriding Aesthetics

q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre, size=BudgetMillions))

#add geom layer
q + geom_point()

#overriding aes
#ex1
q + geom_point(aes(size=CriticRating))

#ex2
q + geom_point(aes(size=BudgetMillions))

#q remains the same
q + geom_point()

#ex3
q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions $$$")
#>>> 2nd chart


#ex4
q + geom_line() + geom_point()
#reduce line size
q + geom_line(size=1) + geom_point()


#------------ Mapping vs. Setting

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#Add color
#1. Mapping (what we've done so far)
r + geom_point(aes(color=Genre))
#2. Setting
r + geom_point(color="DarkGreen")
#ERROR
#r + geom_point(aes(color="DarkGreen"))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#2. Setting
r + geom_point(size=10)
#ERROR
#r + geom_point(aes(size=10))


#------------ Histograms and Density Charts

s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth=10)

#add color
s + geom_histogram(binwidth=10, aes(fill=Genre))
#add a border
s + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")
#>>> Chart #3 (will be improved)

#Probability Density Charts - may/may not ever need:
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")


#------------ Starting Layer Tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth=10,
                   fill="White", color="Blue")

# another way to achieve the chart above
t <- ggplot(data=movies)
t + geom_histogram(binwidth=10,
                   aes(x=AudienceRating),
                   fill="White", color="Blue")

#>>> Chart 4

t <- ggplot(data=movies)
t + geom_histogram(binwidth=10,
                   aes(x=CriticRating),
                   fill="White", color="Blue")

#>>> Chart 5
#skeleton plot - used when creating a plot but want
#to use different data sets on that plot
#maybe will use very rarely
t <- ggplot()


#------------ Statistical Transformations

?geom_smooth

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))
u + geom_point() + geom_smooth(fill=NA)

#boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                             color=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
#tip/hack:
u + geom_boxplot(size=1.2) + geom_jitter()
#another way:
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)
#>>> Chart 6


criticbp <- ggplot(data=movies, aes(x=Genre, y=CriticRating,
                                    color=Genre))
criticbp + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)


#------------ Using Facets

v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth=10, aes(fill=Genre),
                   color="Black")

#facets
v + geom_histogram(binwidth=10, aes(fill=Genre),
                   color="Black") +
  facet_grid(Genre~., scales="free")


#scatterplots:
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))

#facets
w + geom_point(size=1) +
  facet_grid(Genre~.)
w + geom_point(size=1) +
  facet_grid(.~Year)

w + geom_point(size=1) +
  facet_grid(Genre~Year)

w + geom_point(size=1) +
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year)
#>>> 1 (but still needs improvement)


#------------ Coordinates

#Topics
#limits
#zoom

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             size=BudgetMillions,
                             color=Genre))
m + geom_point(size=2)

m + geom_point(size=2) +
  xlim(50,100) +
  ylim(50,100)

#this method won't work well always
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth=10, aes(fill=Genre),
                   color="Black")
n + geom_histogram(binwidth=10, aes(fill=Genre),
                   color="Black") +
  ylim(0,50)

#instead - zoom:
n + geom_histogram(binwidth=10, aes(fill=Genre),
                   color="Black") +
  coord_cartesian(ylim=c(0,50))

#Improve Chart #1
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))


#------------ Theme

o <- ggplot(data=movies, aes(x=BudgetMillions))

h <- o + geom_histogram(binwidth=10, aes(fill=Genre), 
                   color="Black")

h

#axes labels
h + xlab("Money Axis") + 
  ylab("Number of Movies")

#label formatting
h + xlab("Money Axis") + 
  ylab("Number of Movies") +
  theme(axis.title.x=element_text(color="DarkGreen", size=10),
axis.title.y=element_text(color="Red", size=10))

#tick mark formatting
h + xlab("Money Axis") + 
  ylab("Number of Movies") +
  theme(axis.title.x=element_text(color="DarkGreen", size=10),
        axis.title.y=element_text(color="Red", size=10),
        axis.text.x = element_text(size=7),
        axis.text.y = element_text(size=7))
?theme

#legend formatting
h + xlab("Money Axis") + 
  ylab("Number of Movies") +
  theme(axis.title.x=element_text(color="DarkGreen", size=10),
        axis.title.y=element_text(color="Red", size=10),
        axis.text.x = element_text(size=7),
        axis.text.y = element_text(size=7),
        
        legend.title = element_text(size=10),
        legend.text = element_text(size=7),
        legend.position = c(1,1),
        legend.justification = c(1,1))

#title 
h + xlab("Money Axis") + 
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x=element_text(color="DarkGreen", size=10),
        axis.title.y=element_text(color="Red", size=10),
        axis.text.x = element_text(size=7),
        axis.text.y = element_text(size=7),
        
        legend.title = element_text(size=10),
        legend.text = element_text(size=7),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="DarkBlue",
                                  size=15,
                                  family="Courier"))
