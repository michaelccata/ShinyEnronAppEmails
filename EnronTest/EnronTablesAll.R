
#### File Load - Larger Data Set
enrontotal <- read.csv("/Users/michaelcata/Documents/EnronGit/EnronBagofWords_Total.csv",check.names=FALSE)


#### Data Formatting
enrontotal$texta <- as.character(enrontotal$texta)


#### Hierarchy Levels
enrontotal$hier <- factor(enrontotal$hier, levels = c("CEO", "President", "Vice President", "In-House Lawyer", "Managing Director", "Director", "Manager", "Trader", "Employee", "N/A", "NULL"))

#### Email Destination
enrontotal$direct <- factor(enrontotal$direct, levels = c("Above","Peer","Below","NULL"))

#### Uncertainty Measure
enrontotal$trend <- (str_count(enrontotal$text, 'could | \\? | would | should | think | believe | maybe | later | uncertain | uncertainty | not sure | maybe | may | warning | ASAP | hurry | now | faster | find out | help | try | wait | illegal | criminal | fraud | adjust | recalculate | wrong | incorrect | inaccurate'))/str_count(enrontotal$text,"\\S+")


#### Traditional Shiny Graph
enrongraph <- ggplot(enrontotal, aes(newdate,trend))+facet_grid(direct~hier, scales="fixed")+geom_smooth(aes(group=hier, color=hier),breaks=FALSE)+theme(legend.position="none")+labs(x='Mid 1998 - Late 2002',y="Uncertainty in Tone")+geom_rect(aes(xmin='2001-08-22', xmax='2001-09-02', ymin=0,ymax=+Inf), alpha=0.2, fill="grey")+ylim(-.01,.05)


#### 50k Broader Trends
enrongraph <- ggplot(enrontotal, aes(newdate,trend))+facet_wrap(~direct, scales="fixed")+geom_smooth(aes(group=hier, color=hier),breaks=FALSE)+theme(legend.position="none")+labs(x='Mid 1998 - Late 2002',y="Uncertainty in Tone")+geom_rect(aes(xmin='2001-08-22', xmax='2001-09-02', ymin=0,ymax=+Inf), alpha=0.2, fill="grey")+ylim(-.01,.05)



