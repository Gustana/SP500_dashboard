library(shinydashboard)
library(fontawesome)
library(plotly)
library(shiny)
library(dplyr)
library(lubridate)
library(padr)
library(tidyr)
library(DT)
library(glue)
library(scales)

options(scipen = 999)

stock <-  read.csv("dataset/all_stocks_5yr.csv")

stock <- stock %>% 
  mutate(
    date = ymd(date),
    Name = as.factor(Name)
  )

min_date <- min(stock$date)
max_date <- max(stock$date)

stock <- pad(stock, start_val = min_date, end_val = max_date, interval = "day", group = "Name")
stock <- stock %>% 
  fill(open, high, low, close, volume, .direction="down")

tech_stock <- stock %>% 
  filter(Name %in% c("AAPL", "GOOGL", "MSFT", "AMZN"))
