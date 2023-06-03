dashboardPage(
  dashboardHeader(
    title = "S&P 500 Analysis"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
           "Overview",
           tabName = "overview",
           icon = fa_i("chart-simple")
      ),
      menuItem(
        "Tech Stock Comparison",
        tabName = "comparison",
        icon = fa_i("code-compare")
      ),
      menuItem(
        "Raw Data",
        tabName = "raw_data",
        icon = fa_i("database")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "overview",
        fluidRow(
          box(
            width = 12,
            plotlyOutput(
              outputId = "plot_overall"
            )
          )
        )
      ),
      tabItem(
        tabName = "comparison",
        fluidRow(
          box(
            width = 12,
            dateRangeInput(
              inputId = "date_range_comparison",
              label = "Date Range Filter: ",
              start = min_date,
              end = max_date,
              width = "40%"
            ),
            actionButton(
              inputId = "btn_update_info",
              label = "Update Information",
              icon = fa_i("circle-notch")
            ),
          ),
          box(
            width = 12,
            h3(
              "Moving Open Price Rate"
            ),
            fluidRow(
              valueBoxOutput(outputId = "aapl_open_price_moving_rate", width = 6),
              valueBoxOutput(outputId = "googl_open_price_moving_rate", width = 6)
            ),
            fluidRow(
              valueBoxOutput(outputId = "msft_open_price_moving_rate", width = 6),
              valueBoxOutput(outputId = "amzn_open_price_moving_rate", width = 6)
            )
          )
        ),
        fluidRow(
          box(
            width = 12,
            plotlyOutput(
              outputId = "plot_tech_stock"
            )
          )
        )
      ),
      tabItem(
        tabName = "raw_data",
        fluidRow(
          box(
            width = 12,
            dataTableOutput(outputId = "raw_data")
          )
        )
      )
    )
  )
)