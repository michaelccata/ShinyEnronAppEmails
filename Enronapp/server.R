library(shiny)
library(ggplot2)
library(stringr)


enronpool <- read.csv("EnronBagofWordsInternal.csv",check.names=FALSE)
enronpool$text <- as.character(enronpool$texte)
enronpool$hier <- factor(enronpool$hier, levels = c("CEO", "President", "Vice President", "In-House Lawyer", "Managing Director", "Director", "Manager", "Trader", "Employee", "N/A"))
enronpool$direct <- factor(enronpool$direct, levels = c("Above","Peer","Below"))

shinyServer(function(input, output) {
  
  
  output$enrongraph <- renderPlot({
    
    string <- paste(input$key1, input$key2, input$key3, input$key4, input$key5, input$key6, input$key7,input$key8,input$key9,input$key10, sep = "|")
    
    enronpool$trend <- (str_count(enronpool$texte, string))/(str_count(enronpool$text,"\\S+"))  
    
    ggplot(enronpool, aes(newdate,trend))+facet_grid(direct~hier, scales="fixed")+geom_smooth(aes(group=hier, color=hier),breaks=FALSE)+theme(legend.position="none")+labs(x='Mid 1998 - Late 2002',y="Frequency of Keywords")+geom_rect(aes(xmin='2001-08-22', xmax='2001-09-02', ymin=0,ymax=+Inf), alpha=0.2, fill="grey")+ylim(-.01,.035)})
  
  })


