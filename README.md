
## About this Project
This small application is the sample result of a larger side project (read: rabbit hole) to dust-off my data skills and learn more about measuring/predicting behavior using text-based data. My analysis started with a SQL version of the Enron emails released to the public by the FCC following the bankruptcy and criminal cases.

Primary data was spread over four tables. I configured a custom table useful for basic (read: not graph or noSQL) analysis. After staging the data, I imported into R where I calculate term frequency, plotted with ggplot2, and deployed with Shiny.

## About the Data
Original data obtained through http://bailando.sims.berkeley.edu/enron_email.html

SQL data stored as separate tables:

[Message: Message ID, Sender, Date, Body, other fields]
[Recipients: Message ID, Date, Recipients]
[Directory: Name of person, Email Addresses, Position in the Company]

I transformed that into (sketchy SQL munging queries included in the repository) 

[Bagofwords_xxx: 
    Message ID, 
    Sender, 
    Date, 
    Daily Aggregated Email Content (subject + body),
    Position of the Person, 
    Classification as Enron employee (irrelevant for "Internal" data-set),
    Direction of the message (Above, Below, Peer) in respect of the sender
    ]

Cleaned and prepared data sets in the repository:
BagofWords_Internal -> emails sent from Enron employees
BagofWords_Total -> emails sent from anyone

The data is still stored at the individual and message direction level but content is aggregated by day. Message direction was set by a weighted average of the recipients' level in the organization. For example: if a lower level employee sends a message to a peer and a superior, their weighted average would demonstrate a message "above" their position in the organization. This heuristic is based on anecdotal and some empirical research that suggests including superiors in communication implies an intention of communicating for the purposes of oversight or permission.


## About the Scripts 
I've provided both the Shiny App folder and the stand-alone R analysis for folks interested in each of those usages.
Enronapp -> former (includes relevant data in the folder)
R_Only_Analysis -> latter 
