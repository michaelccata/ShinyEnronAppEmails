enronpool <- read.csv("/Users/michaelcata/Documents/Enron/##filename##.csv",check.names=FALSE)
install.packages("sqldf")
library(ggplot2)
library(reshape2)
library(sqldf)
library(plyr)
library(shiny)
library(data.table)
library(stringr)
library(shinyapps)

install.packages("shiny")
install.packages("data.table")
install.packages("stringr")
install.packages("sqldf")
install.packages("ggplot2")
install.packages("plyr")
install.packages("shinyapps")

install.packages("shiny")
library(shiny)
library(data.table)
install.packages(data.table)
library(stringr)
install.packages(stringr::)
### shiny stuff
install.packages('devtools')
devtools::install_github('rstudio/shinyapps')
shinyapps::setAccountInfo(name='michaelc',
                          token='289F5936FE40A233780217BD9A48EB36',
                          secret='1xNNfbKsq8sCcUHhb03VcIbJAQeblQa4MosLYaq/')

library(shinyapps)
shinyapps::deployApp('path/to/your/app')


## changing column names
setnames(enronpool,"concat(subject,\" \",body)","text")

#### Trend analysis
## Relative Count
enronpool$trend <- (str_count(enronpool$text, "the")*2)/str_count(enronpool$text,"\\S+")
                                              ^^ can I turn this into a flexible variable?
## Total Volume
enronpool$trend <- nchar(enronpool$text,"chars")

## Word Count
enronpool$trend <- str_count(enronpool$text, "the")/str_count(enronpool$text,"\\S+")
enronpool$trend <- str_count(enronpool$text,"[?]")/str_count(enronpool$text,"\\S+")
enronpool$trend <- str_count(enronpool$text,"[?]")/str_count(enronpool$text,"\\S+")


### THE GRAPH (no plotting, free scales, + direction)
enrongraph <- ggplot(enronpool, aes(newdate,trend, color=hier))+
  facet_wrap(hier~direct, scales="free", ncol=10)+
  geom_smooth(aes(group=hier))

#### Graph - plots and linear
enrongraph <- ggplot(enronpool, aes(newdate,trend, color=hier))+
  geom_point()+facet_wrap(~hier, scales="free", ncol=3)+
  geom_smooth(method="lm",aes(group=hier))

#### Graph - no plots and loess
enrongraph2 <- ggplot(enronpool, aes(newdate,trend, color=hier))+
  facet_wrap(~hier, scales="fixed", ncol=3)+
  geom_smooth(aes(group=hier))

### Graph with ? marks (and "think)
enrongraph <- ggplot(enronpool, aes(newdate,trend, color=hier))+
  facet_wrap(~hier, scales="free", ncol=3)+
  geom_smooth(aes(group=hier))


### Ordering the factor classification for facet wrapping
enronpool$hier <- factor(enronpool$hier, levels = c("CEO", "President", "Vice President", "In-House Lawyer", "Managing Director", "Director", "Manager", "Trader", "Employee", "N/A"))

## checking the recipient null volume
count(enronpool, recip_mag =="NULL")

### specifying data class on column basis
enronpool$sender_mag <- as.numeric(enronpool$sender_mag)
enronpool$recip_mag <- as.numeric(enronpool$recip_mag)
enronpool$mid <- as.factor(enronpool$mid)
enronpool$sender <- as.factor(enronpool$sender)
enronpool$newdate <- as.factor(enronpool$newdate)
enronpool$hier <- as.factor(enronpool$hier)
enronpool$classification <- as.factor(enronpool$classification)
enronpool$text <- as.character(enronpool$text)


########################################################################### OLD NEWS #############################################
### specifying data class on entry
colClasses = c("factor","factor","date","character","character","factor","factor","numeric","numeric") 


## sqldf stuff
analysis <- sqldf("CREATE TABLE analysis 
                  SELECT mid, sender, date, subject, body, status 
                  FROM message left join employeelist 
                  ON sender = Email_ID or sender = Email2 or sender = Email3 or sender = Email4")

### add column for vector
enronpool <- transform(enronpool, vector = sender_mag - recip_mag)


### ads;lkfjas
enronpool$type = ifelse(enronpool$vector > 0, 'Below', ifelse(enronpool$vector < 0, 'Above', 'Peer'))

### analysis <- sqldf("SELECT newdate, hier, type, count(classification), subject, body FROM enronpool GROUP BY hier, newdate, type")


Employeelist - "CEO, President, Vice President, In-House Lawyer, Managing Director, Director, Manager, Trader, Employee, N/A"

