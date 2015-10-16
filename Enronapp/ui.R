library(shinythemes)

shinyUI(fluidPage(
                
                theme = shinytheme("flatly"),
                
                title="Could we have seen Enron coming?",
                fluidRow( 
                  column(4,
                         p("Search for the relative frequency of keywords over three years of Enron emails. Above, peer, and below refer to the message audience of the sender."),
                         br(),
                         p("The vertical gray bar signals the week internal auditors breached the topic of financial impropriety with CEO Ken Lay. This mark signals broad organizational awareness of the massive crisis facing the company."),
                         br(),
                         p("Use the recommended keywords to view employee urgency across the organization."),
                         submitButton(text = "Apply Changes", icon = NULL)
                  ),
                  column(4,
                         textInput("key1","Keywords","ASAP"),
                         textInput("key2","","now"),
                         textInput("key3","","can't wait"),
                         textInput("key4","","hurry"),
                         textInput("key5","","fast")
                  ),
                  column(4,
                         textInput("key6","","necessary"),
                         textInput("key7","","need"),
                         textInput("key8","","failure"),
                         textInput("key9","","disaster"),
                         textInput("key10","","trouble")
                  ) 
                ),
                plotOutput('enrongraph'),
                
                hr()
                
                          )
  )

