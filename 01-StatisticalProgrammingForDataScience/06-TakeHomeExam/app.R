## app.R ##
library(shinydashboard)
library(ggplot2)

# load data
rental_df <- readRDS("examdata.RDS")

# first column of the bashboard
ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Rental Price", tabName = "rental_price", icon = icon("th")),
      menuItem("Car Space", tabName = "car_space", icon = icon("th")),
      menuItem("Location", tabName = "location", icon = icon("th"))
    )
  ),
  
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "rental_price",
              fluidRow(
                h2("Price Distribution"),
                column(width = 6,
                       box(plotOutput("plot1", height = 300)),
                       selectInput("select", "select the type", unique(rental_df$type), unique(rental_df$type)[1])
                ),
                column(width = 6,
                       box(plotOutput("plot2", height = 300))
                )
              ),
              fluidRow(
                h2("Price and Type"),
                column(width = 6,
                       box(plotOutput("plot3", height = 300)),
                       selectInput('type', 'select the type', unique(rental_df$type), unique(rental_df$type)[1])
                ),
                column(width = 6,
                       box(plotOutput("plot4", height = 300))
                )
              ),
              fluidRow(
                h2("Bedroom with price"),
                box(plotOutput("plot5", height = 300)),
                box(
                  title = "Number of bedroom",
                  sliderInput("Slider_Bedroom", "Number of bedroom:", 0, 4, 1)
                )
              )
      ),
      
      
      # Second tab content
      tabItem(tabName = "car_space",
              fluidRow(
                h2("Widgets tab content"),
                column(width = 6,
                       box(plotOutput("plot6", height = 300)),
                       box(
                         title = "Number of bedroom",
                         sliderInput("Slider_Car_space", "Number of bedroom:", 1, 5, 1)
                       )
                ),
                column(width = 6,
                       box(plotOutput("plot7", height = 300))
                )
              ),
              
              fluidRow(
                h2("Car Space and Type"),
                column(width = 6,
                       box(plotOutput("plot8", height = 300)),
                       selectInput('type_car', 'select the type', unique(rental_df$type), unique(rental_df$type)[1])
                ),
                column(width = 6,
                       box(plotOutput("plot9", height = 300))
                )
              ),
              
              fluidRow(
                h2("Car Space with price"),
                box(plotOutput("plot10", height = 300)),
                box(
                  title = "Number of Car Space",
                  sliderInput("Slider_Car_Space", "Number of bedroom:", 0, 4, 1)
                )
              )
              
              
      ),
      
      
      # Third tab content
      tabItem(tabName = "location",
              fluidRow(
                h2("Property"),
                box(plotOutput("plot11", height = 300))
              )
              
      )
    )
  )
)

server <- function(input, output) {
  
  # tab 1
  output$plot1 <- renderPlot({
    ggplot(rental_df, aes(x = price)) + geom_histogram() + labs(x = "Price", title = "The distribution of prices")
  })
  
  output$plot2 <- renderPlot({
    ggplot(rental_df, aes(x = price)) + geom_histogram() + labs(x = "Price", title = "The distribution of prices") + facet_wrap("type")
  })
  
  output$plot3 <- renderPlot({
    boxplot(price~type,data=rental_df[rental_df$type == input$type, ], main = paste("Boxplot of price and type: ", input$type))
  })
  
  output$plot4 <- renderPlot({
    anova_regression_property <- aov(price ~ type, data = rental_df)
    HSD_property <- TukeyHSD(anova_regression_property)
    plot(HSD_property) 
  })
  
  output$plot5 <- renderPlot({
    plot(rental_df[rental_df$bedroom == input$Slider_Bedroom, ]$bedroom, rental_df[rental_df$bedroom == input$Slider_Bedroom, ]$price, xlab = "number of bedroom", ylab = "price")
  })
  
  
  # tab 2
  output$plot6 <- renderPlot({
    ggplot(rental_df, aes(x = car_space)) + geom_histogram() + labs(x = "Car Space", title = "The distribution of Car Space")
  })
  
  output$plot7 <- renderPlot({
    ggplot(rental_df, aes(x = car_space)) + geom_histogram() + labs(x = "Car Space", title = "The distribution of car Space") + facet_wrap("type")
  })
  
  output$plot8 <- renderPlot({
    boxplot(car_space~type,data=rental_df[rental_df$type == input$type_car, ], main = paste("Boxplot of car space and type: ", input$type_car))
  })
  
  output$plot9 <- renderPlot({
    anova_regression_property <- aov(car_space ~ type, data = rental_df)
    HSD_property_car_space <- TukeyHSD(anova_regression_property)
    plot(HSD_property_car_space) 
  })
  
  output$plot10 <- renderPlot({
    plot(rental_df[rental_df$car_space == input$Slider_Car_Space, ]$car_space, rental_df[rental_df$car_space == input$Slider_Car_Space, ]$price, xlab = "number of car space", ylab = "price")
  })
  
  
  # tab 3
  output$plot11 <- renderPlot({
    barplot(table(rental_popu_df$type))
  })
  
}

shinyApp(ui, server)