
library(shiny)
library(ggplot2)
library(quantmod)
library(DT)
library(dplyr)
library(magrittr)


#Subset Finance sector
nasdaq_names = stockSymbols(exchange = "NASDAQ")
nyse_names = stockSymbols(exchange = "NYSE")
amex_names = stockSymbols(exchange = "AMEX")
df = rbind(nasdaq_names,nyse_names,amex_names)

#Convert all values into millions
idx = grep("B",df$MarketCap)
x = df$MarketCap; df$MarketCap = as.numeric(substr(x,2,nchar(x)-1))
df$MarketCap[idx] = df$MarketCap[idx]*1000 #For the billion cases
idx = which(df$MarketCap>0)
df = df[idx,]
Finance = df %>% filter(Sector=="Finance")

fluidPage(
  title = 'Financial Firms Data',
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "Finance"',
        checkboxGroupInput('show_vars', 'Choose data elements:',
                           names(Finance), selected = names(Finance))
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('Finance', DT::dataTableOutput('mytable1'))
      )
    )
  )
)




