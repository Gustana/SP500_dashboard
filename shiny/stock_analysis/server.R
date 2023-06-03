function(input, output){
  output$plot_overall <- renderPlotly({
    overall_data <- stock %>% 
      group_by(date) %>% 
      mutate(sum_open= sum(open)) #%>% 
      # mutate(text = glue("Date: {date}
      #                    Open Price: {sum_open}"))
    
    plot_overall <- overall_data %>% ggplot(mapping = aes(x = date, 
                                                      y = sum_open#,
                                                      #text = label
                                                      )
                                            ) +
      geom_line(col = "blue")+
      labs(title = "S&P 500 Stock Open Price Movement 2013 - 2018",
           subtitle = "source: kaggle",
           x = NULL,
           y = "open price",
      )+
      scale_y_continuous(labels = dollar_format(prefix = "$ "))+
      theme_classic()
    
    ggplotly(plot_overall)
  })
  
  # define reactive values
  date_range_reactive <- reactiveValues(date_range = NULL)
  
  date_range_update_event <- observeEvent(input$btn_update_info, {
    date_range_reactive$date_range <- input$date_range_comparison
  })
  
  output$aapl_open_price_moving_rate <- renderValueBox({
    
    if(!is.null(date_range_reactive$date_range)){
      min_date <- date_range_reactive$date_range[1]
      max_date <- date_range_reactive$date_range[2]
      
      print(min_date)
    }
    
    min_open_price <- tech_stock %>% 
      filter(date == min_date, Name == "AAPL") %>% 
      select(open)
    
    max_open_price <- tech_stock %>% 
      filter(date == max_date, Name == "AAPL") %>% 
      select(open)
    
    open_price_moving_rate = max_open_price/min_open_price
    
    valueBox(
      paste0(round(open_price_moving_rate*100, 2), "%"),
      "AAPL",
      icon = fa_i("apple"),
      color = "purple"
    )
  })
  
  output$googl_open_price_moving_rate <- renderValueBox({
    
    min_open_price <- tech_stock %>% 
      filter(date == min_date, Name == "GOOGL") %>% 
      select(open)
    
    max_open_price <- tech_stock %>% 
      filter(date == max_date, Name == "GOOGL") %>% 
      select(open)
    
    open_price_moving_rate = max_open_price/min_open_price
    
    valueBox(
      paste0(round(open_price_moving_rate*100, 2), "%"),
      "GOOGL",
      icon = fa_i("google"),
      color = "maroon"
    )
  })
  
  output$msft_open_price_moving_rate <- renderValueBox({
    
    min_open_price <- tech_stock %>% 
      filter(date == min_date, Name == "MSFT") %>% 
      select(open)
    
    max_open_price <- tech_stock %>% 
      filter(date == max_date, Name == "MSFT") %>% 
      select(open)
    
    open_price_moving_rate = max_open_price/min_open_price
    
    valueBox(
      paste0(round(open_price_moving_rate*100, 2), "%"),
      "MSFT",
      icon = fa_i("microsoft"),
      color = "teal"
    )
  })
  
  output$amzn_open_price_moving_rate <- renderValueBox({
    
    min_open_price <- tech_stock %>% 
      filter(date == min_date, Name == "AMZN") %>% 
      select(open)
    
    max_open_price <- tech_stock %>% 
      filter(date == max_date, Name == "AMZN") %>% 
      select(open)
    
    open_price_moving_rate = max_open_price/min_open_price
    
    valueBox(
      paste0(round(open_price_moving_rate*100, 2), "%"),
      "AMZN",
      icon = fa_i("amazon"),
      color = "orange"
    )
  })
  
  output$plot_tech_stock <- renderPlotly({
    tech_stock <- tech_stock %>% 
      select(Name, open, date)
    
    plot_tech_stock <- tech_stock %>% ggplot(mapping = aes(x = date, 
                                                           y = open,
                                                           text = glue("{Name}
                                                              Date: {date}
                                                              Open Price: {open}"),
                                                           group = Name
                                                           )
    ) +
      geom_line(aes(color = Name))+
      labs(title = "Big Technology Stock Open Price Comparison",
           subtitle = "source: kaggle",
           x = NULL,
           y = "open price",
           color = "Ticker Code"
      )+
      scale_y_continuous(labels = dollar_format(prefix = "$ "))+
      theme_classic()
    
    ggplotly(plot_tech_stock, tooltip = "text")
  })
  
  output$raw_data <- renderDataTable({
    datatable(
      data = stock,
      options = list(
        scrollX = T
      )
    )
  })
}