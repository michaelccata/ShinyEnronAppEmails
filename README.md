This small application is the sample result of a larger side project (read: rabbit hole) to train my data skills and learn more about measuring/predicting behavior. My analysis started with the Berkeley SQL version of the Enron Emails

The data was spread over four tables so I configured a custom table useful for basic (read: not graph oriented) analysis. After staging the data, I imported into R where I calculate term frequency, plotted with ggplot2, and deployed with Shiny.

Original data obtained through http://bailando.sims.berkeley.edu/enron_email.html

Cleaned and prepared data sets in the repository.
