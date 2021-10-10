analyze <- tabPanel(
  "Analyze",
  
  titlePanel("Analyze your barcode"),
  p("Upload your barcode and select your visualization in a colour space or construct a palette."),
  p(tags$b("MovieBarcodeAnalyzeR"), "accepts ", tags$b("jpeg/jpg"), " or ", tags$b("png"), " image files only."),
  
  tabsetPanel(type = "tabs",
              tabPanel("Upload",
                       fluidRow(style = "padding-top: 12px", 
                                sidebarLayout(
                                  column(4,
                                         sidebarPanel(
                                           width = 12,
                                           fileInput("file1", "Upload a barcode",
                                                     multiple = FALSE,
                                                     accept = c("image/png",
                                                                "image/jpeg",
                                                                "image/jpg")),
                                           radioButtons("barcode_type", label = ("Barcode type"),
                                                        choices = list("Smoothed" = 1, "Unsmoothed" = 2), 
                                                        selected = 1),
                                           p(tags$b("Please note"), tags$br(), "Using an ", tags$b("unsmoothed barcode"), " will take much longer to process and result in large file sizes on download.
                                             Therefore, visualizations of unsmoothed barcodes will be returned as jpegs to minimise file sizes."),
                                           p("Visualizations of ", tags$b("smoothed barcodes"), " will be returned as a pdf file."),
                                           p("All downloaded images will have a resolution of 600 dpi regardless of file format.")
                                         )
                                  ),
                                  column(8,
                                         mainPanel(
                                           width = 12,
                                           column(7,
                                                  htmlOutput("barcode_title"),
                                                  tags$br(),
                                                  imageOutput("show_upload") %>% withSpinner(color = "#446e9b")
                                           ),
                                           column(5,
                                                  tags$h4("Download your data"),
                                                  downloadButton("barcode_data_download", "Download data as a csv"),
                                                  tags$br(),
                                                  tags$br(),
                                                  p("The following co-ordinates and attributes are returned:"),
                                                  p("For ", tags$b("smoothed barcodes:")),
                                                  tags$ul(
                                                    tags$li("col: the index of a pixel on the x-axis of the barcode"),
                                                  ),
                                                  p("For", tags$b("unsmoothed barcodes:")),
                                                  tags$ul(
                                                    tags$li("col: the index of a pixel on the x-axis of the barcode"),
                                                    tags$li("row: the index of a pixel on the y-axis of the barcode")
                                                  ),
                                                  p("For ", tags$b("all barcodes:")),
                                                  tags$ul(
                                                    tags$li("r: the value of the red channel of a pixel in RGB space"),
                                                    tags$li("g: the value of the green channel of a pixel in RGB space"),
                                                    tags$li("b: the value of the blue channel of a pixel in RGB space"),
                                                    tags$li("L: the lightness value of a pixel in the L*a*b*/LCH(ab) spaces"),
                                                    tags$li("A: the chromaticity of a pixel on the red-green axis in L*a*b* space"),
                                                    tags$li("B: the chromaticity of a pixel on the blue-yellow axis in L*a*b* space"),
                                                    tags$li("C: the chroma of a pixel in LCH(ab) space"),
                                                    tags$li("H: the hue of a pixel in LCH(ab) space"),
                                                  ),
                                                  p("See the colour spaces page for more details on the different colour attributes.")
                                           )
                                         )
                                  )
                                )
                       )
              ),
              tabPanel("LCH(ab)",
                       fluidRow(style = "padding-top: 12px", 
                                sidebarLayout(
                                  column(4,
                                         sidebarPanel(
                                           width = 12,
                                           selectInput("select_lch_plot", "Select a visualization",
                                                       choices = c(Choose = '',
                                                                   "Histograms",
                                                                   "Hue vs Chroma - polar",
                                                                   "Hue vs Chroma - cartesian",
                                                                   "Chroma vs Lightness",
                                                                   "Chroma trend",
                                                                   "Lightness trend"
                                                       )
                                           ),
                                           p(tags$b("Please note"), tags$br(), "Achromatic pixels (C = 0%) with arbitrary hue values are filtered prior to plotting the hue
                                             histogram and the Hue vs Chroma - cartesian plot."),
                                           p("The trend plots for ", tags$b("smoothed barcodes"), " barcodes plot a path through the data points."),
                                           p("For ", tags$b("unsmoothed barcodes"), "the trendline is plotted using a generalized additive model."),
                                           tags$br(),
                                           actionButton("runScript_lch_plot", "Plot the data"),
                                           tags$hr(style = "border-color: #446e9b;"),
                                           downloadButton("download_lch_plot", label = "Download plot")
                                         )
                                  ),
                                  column(8,
                                         mainPanel(
                                           width = 12,
                                           plotOutput("lch_plot") %>% withSpinner(color = "#446e9b")
                                         )
                                  )
                                )
                       )
              ),
              tabPanel("L*a*b*",
                       fluidRow(style = "padding-top: 12px",
                                sidebarLayout(
                                  column(4,
                                         sidebarPanel(
                                           width = 12,
                                           selectInput("select_lab_plot", "Select a visualisation",
                                                       choices = c(Choose = '', 
                                                                   "Histograms",
                                                                   "a vs b - scatterplot",
                                                                   "a vs b - density plot"
                                                       )
                                           ),
                                           p(tags$b("Please note"), tags$br(), "The a vs b - density plot is not availbale for unsmoothed barcodes."),
                                           tags$br(),
                                           actionButton("runScript_lab_plot", "Plot the data"),
                                           tags$hr(style = "border-color: #446e9b;"),
                                           downloadButton("download_lab_plot", label = "Download plot")
                                         )
                                  ),
                                  column(8,
                                         mainPanel(
                                           width = 12,
                                           plotOutput("lab_plot") %>% withSpinner(color = "#446e9b")
                                         )
                                  )
                                )
                       )
                       
              ),
              tabPanel("Palette",
                       fluidRow(style = "padding-top: 12px",
                                sidebarLayout(
                                  column(4,
                                         sidebarPanel(
                                           width = 12,
                                           p("For ", tags$b("smoothed barcodes"), ", use the slider to select the upper and lower limits of 
                                             the range of ", tags$i("k"), " values to be searched. The optimal palette for that range based 
                                             on the average silhouette width is returned."),
                                           p("For ", tags$b("unsmoothed barcodes"), ", use the ", 
                                             tags$i("lower"), "marker to select a value for ", tags$i("k"), ". A palette with ", tags$i("k"), " 
                                             clusters is returned."),
                                           sliderInput("centroids", "Select clusters",
                                                       min = 4, max = 20,
                                                       value = c(10, 20)
                                                       ),
                                           actionButton("runScript_palette", "Plot the data"),
                                           tags$hr(style = "border-color: #446e9b;"),
                                           downloadButton("download_palette", label = "Download plot")
                                         )
                                  ),
                                  column(8,
                                         mainPanel(
                                           width = 12,
                                           fluidRow(
                                             column(6,
                                                    tags$h4("Palette"),
                                                    plotOutput("palette_plot") %>% withSpinner(color = "#446e9b")
                                             ),
                                             column(6,
                                                    tags$h4("Summary"),
                                                    htmlOutput("RDE_heading"),
                                                    tableOutput("palette_summary") %>% withSpinner(color = "#446e9b"),
                                                    tags$br(),
                                                    htmlOutput("Clusters_heading"),
                                                    tableOutput("palette_clusters_table") %>% withSpinner(color = "#446e9b")
                                             )
                                           )
                                         )
                                  )
                                )
                       )
              )
  )
)
