### This file is the end-to-end instructions for conducting the analysis in R without deploying to Shiny
### The code will pull both "Internal" only emails from the CSV and the broader dataset "Total"
### App uses "Internal" as the data has higher integrity. I
### If using "Total" you'll need to configure the hier levels to reflect NAs for emails from outside the firm

### Packages
install.packages("shiny")
install.packages(data.table)
install.packages(stringr::)
install.packages("sqldf")
install.packages("ggplot2")
install.packages("plyr")
install.packages("shinyapps")
install.packages("qdap")

##### Shiny
install.packages('devtools')
devtools::install_github('rstudio/shinyapps')

shinyapps::setAccountInfo(name='your_username',
                          token='your_token',
                          secret='your_secretkey')


shinyapps::deployApp('path_to_your_folder')



####### PULLING + CLEANING
### Load File
enronpool <- read.csv("your_path_to_/EnronBagofWordsInternal.csv",check.names=FALSE)
enronpool2 <- read.csv("your_path_to_/EnronBagofWords_Total.csv",check.names=FALSE)


## Change Text Column Name
setnames(enronpool,"concat(subject,\" \",body)","text")

## Declare Character Format
enronpool$text <- as.character(enronpool$text)

## Ordering the hierarchy factor classification for facet wrapping
enronpool$hier <- factor(enronpool$hier, levels = c("CEO", "President", "Vice President", "In-House Lawyer", "Managing Director", "Director", "Manager", "Trader", "Employee", "N/A"))

## Ordering the direction factor classification for facet wrapping
enronpool$direct <- factor(enronpool$direct, levels = c("Above","Peer","Below"))


####### VALUES
## Declare Search Term + Find Relative Frequency
enronpool$trend <- (str_count(enronpool$text, "the")*2)/str_count(enronpool$text,"\\S+")
### uncertainty 
enronpool$trend <- (str_count(enronpool$text, 'could | \\? | would | should | think | believe | maybe | later | uncertain | uncertainty | not sure | maybe | may'))/str_count(enronpool$text,"\\S+")

enronpool$trend <- (str_count(enronpool$text, 'stuff | things')))/str_count(enronpool$text,"\\S+")


## Find Polarity/Sentiment
enronpool$trend <- polarity(enronpool$text)


####### VISUALIZATION
## Graph, first one is pretty good
enrongraph <- ggplot(enronpool, aes(newdate,trend))+facet_grid(direct~hier, scales="fixed")+geom_smooth(aes(group=hier, color=hier),breaks=FALSE)+theme(legend.position="none")+labs(x='Mid 1998 - Late 2002',y="Uncertainty in Tone")+geom_rect(aes(xmin='2001-08-22', xmax='2001-09-02', ymin=0,ymax=+Inf), alpha=0.2, fill="grey")+ylim(-.01,.05)
## Other option
enrongraph <- ggplot(enronpool, aes(newdate,trend))+facet_grid(direct~hier, scales="free")+geom_smooth(aes(group=hier, color=hier),breaks=FALSE)+theme(legend.position="none")+labs(x='Mid 1998 - Late 2002',y="Keyword Frequency")+geom_rect(aes(xmin='2001-08-22', xmax='2001-08-30', ymin=0,ymax=Inf), alpha=0.2, fill="grey")+ylim(-0.01,0.05)
## Other Option
enrongraphtotal <- ggplot(enronpool, aes(newdate,trend, group = 1))+geom_smooth()+theme(legend.position="none")+labs(x='Mid 1998 - Late 2002',y="Keyword Frequency")+geom_rect(aes(xmin='2001-08-22', xmax='2001-08-30', ymin=0,ymax=.05), alpha=0.2, fill="grey")+ylim(0,.05)
## Other Option
enrongraphbar <- ggplot(enronpool, aes(newdate,trend, fill=hier))+facet_grid(direct~hier, scales="free")+geom_bar(stat="identity")
#### ** outliers are keeping the y axis very high
#### 
