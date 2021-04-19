methodology <- tabPanel(
  "Methodology",
  
  titlePanel("Methodology"),
  p("On this page you can find out how ", tags$b("MovieBarcodeAnalyzeR"), "processes your barcode and the types of visualizations from which you can choose."),
  
  tabsetPanel(type = "tabs",
              tabPanel("Movie barcodes as method",
                       fluidRow(style = "padding-top: 12px",
                                column(5,
                                       p("Analyzing colour in motion pictures is a computationally intensive process. 
                                         It is therefore necessary to reduce the number of data points to something manageable with 
                                         the computational resources of a desktop computer or laptop."),
                                       p("The workflow involved in analysing colour in the cinema involves two stages: "),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$b("Sampling:"), "selecting frames for inclusion in an analysis based on their 
                                                 timecode (every",  tags$i("n"),"-th frame or ",  tags$i("n"), "frames per second) or their 
                                                 representativeness based on the segmentation of a film into coherent sequences."),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Data reduction:"), "the pixels in a frame are reduced to a 
                                                 single value or a small set of values that are usually based on either 
                                                 the average or dominant colour of the pixels, or the representativeness 
                                                 of a set of exemplar colours in a palette based on clustering methods.")
                                       ),
                                       p("A ", tags$b("movie barcode"), "is a common method of sampling frames from a film 
                                         and reducing the amount of pixel information of a frame to manageable level (usually) by averaging that is then arranged 
                                         in an aesthetically pleasing way. Because the colours are directly derived from 
                                         a film and a presented in the order in which they were sampled, a movie barcode contains 
                                         both colour and temporal information about a film that we can extract and use in our analysis."),
                                       p("Movie barcodes can be ", tags$b("unsmoothed"), ", in which the pixel data for the rows of sampled 
                                         frame is reduced by averaging to a column the width of a single pixel; or they can be", tags$b("smoothed"), 
                                         " by averaging the values of each column of the unsmoothed barcode."),
                                       p("Software for creating movie barcodes is freely available and includes", 
                                         tags$a(href = "https://zerowidthjoiner.net/movie-barcode-generator", "Movie Barcode Generator"), ",",
                                         tags$a(href = "https://www.partsnotincluded.com/framevis-video-visualizer/", "FrameVis"), ",",
                                         tags$a(href = "http://wordpress.mrreid.org/moviebarcode/comment-page-1/", "VLC + ImageMagick"), ",",
                                         tags$a(href = "https://github.com/detsutut/chroma", "chromaR"),
                                         ", and many others.")
                                ),
                                column(5,
                                       align="center", img(src = "barcode_example.png", align = "middle", width = "100%")
                                       ),
                                column(2,
                                       p(tags$b("Movie barcodes for the ", tags$i("John Wick: Chapter 3 - Parabellum"), " trailer"), 
                                       tags$br(), "Top: the original, unsmoothed barcode."),
                                       p("Bottom: the smoothed barcode.")
                                       )
                       ),
              ),
              tabPanel("Processing and visualizing colour data",
                       fluidRow(style = "padding-top: 12px",
                                column(6,
                                       tags$h4("Data processing"),
                                       p("You can upload both smoothed and unsmoothed versions of movie barcodes to ",
                                         tags$b("MovieBarcodeAnalyzeR"), ". Make sure to select the type of barcode 
                                         you want to analyze before proceeding because the behaviour of", tags$b("MovieBarcodeAnalyzeR"),
                                         "will change depending on the type of barcode selected."),
                                       p("In a ", tags$b("smoothed"), " barcode every row of the image has the same colour information 
                                          and so only the 100th row of pixels is extracted for analysis. This is an efficient way of analyzing the available colour data."),
                                       p("All of the pixels are used when analyzing an", tags$b("unsmoothed"), " barcode. 
                                         This means that the computational resources required to process an unsmoothed barcode are much greater and 
                                         will therefore take longer to complete."), 
                                       p("The methods used to process data derived from an unsmoothed barcode may differ from those 
                                         used when working with smoothed barcodes and some visualizations are not available when using an unsmoothed barcode. 
                                         This is ", tags$b("important"), " to remember when using this 
                                         app for research. Differences in method will be clearly stated in the relevant section 
                                         on the methodology page and on the relevant tab of the analyze page."),
                                       p("RGB pixel data is extracted from a barcode using ", 
                                         tags$a(href = "https://cran.r-project.org/web/packages/imager/vignettes/gettingstarted.html", "imager"), 
                                         " and converted to the L*a*b* and LCH(ab) colour spaces with ", 
                                         tags$a(href = "https://rdrr.io/cran/farver/man/convert_colour.html", "farver::convert_colour"), 
                                         " using the default white reference (", tags$a(href = "https://en.wikipedia.org/wiki/Illuminant_D65", "Illuminant D65"), "). See the colour spaces page for more information."),
                                       p("You can download the pixel data for your barcode as a ", tags$b("csv"), " file.")
                                       ),
                                column(6,
                                       tags$h4("Visualizations"),
                                       p("Colour data extracted from a movie barcode can be analyzed in either the LCH(ab) or L*a*b* colour spaces."),
                                       p("In the ", tags$b("LCH(ab)"), " colour space you can select from the following visualisations:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$b("Hue, Chroma, and Lightness histograms:"), " the distribution of values for the different colour attributes"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Hue vs Chroma - polar:"), " a polar plot with hue represented as the angle on the colour wheel 
                                                 and chroma as the distance from the centre of the wheel"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Hue vs Chroma - cartesian:"), " a scatterplot with hue on the x-axis and chroma on the y-axis"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Chroma vs Lightness:"), " a scatterplot plot with chroma of the x-axis and lightness on the y-axis"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Chroma trend:"), " the trend in chroma over successive frames in a barcode"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Lightness trend:"), " the trend in lightness over successive frames in a barcode"),
                                       ),
                                       p("In the ", tags$b("L*a*b*"), " colour space you can select from the following visualisations:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$b("a*, b*, and Lightness histograms:"), " the distribution of values for the different colour attributes"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("a vs b - scatterplot:"), " a cartesian plot of with a* on the x-axis and b* on the y-axis"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("a vs b - density plot:"), "  a 2-d density plot showing the concentration of data points in the plane defined by a* and b. 
                                                 This plot is useful as many pixels in a barcode will have the same values for a* and b* (e.g., all achromatic pixels) and so will not be visible in the scatterplot.")
                                       ),
                                       p(tags$b("Please note"), tags$br(), tags$a(href = "https://en.wikipedia.org/wiki/Achromatic", "Achromatic pixels"),
                                         "(i.e., pixels where chroma = 0%) with arbitrary hue values are 
                                         filtered prior to plotting the hue histogram and the Hue vs Chroma - cartesian plot. No filtering is applied to 
                                         the chroma or lightness histograms or to the Hue vs Chroma - polar plot."),
                                       p("For unsmoothed barcodes, trends in chroma and lightness are plotted using a ", 
                                         tags$a(href = "https://en.wikipedia.org/wiki/Generalized_additive_model", "generalized additive model"), ", which is the default method employed by ",
                                         tags$a(href = "https://ggplot2.tidyverse.org/reference/geom_smooth.html", "ggplot::geom_smooth"), "when N \u2265 1000. For smoothed barcodes, the path
                                         through the data is plotted."),
                                       p("The a vs b - density plot is not available for unsmoothed barcodes because the dataset will be too large to process."),
                                       )
                                
                       ),
              ),
              tabPanel("k-means clustering",
                       fluidRow(style = "padding-top: 12px",
                                column(6,
                                       tags$h4(tags$i("k"), "-means clustering"),
                                       p(tags$b(tags$i("k"), "-means clustering"), " is used to construct a palette of up to twenty 
                                         colours for a barcode."),
                                       p(tags$a(href = "https://en.wikipedia.org/wiki/K-means_clustering", tags$i("k"), "-means clustering"), 
                                         " is a method of sorting ", tags$i("n"), "objects (i.e., pixels) into", tags$i("k")," clusters (i.e., colours) so that
                                         each object belongs to a cluster, the mean of which functions as a protype representing all the objects in that cluster."),
                                       p(tags$b("MovieBarcodeAnalyzeR"), "handles", tags$i("k"), "-means clustering differently for smoothed and unsmoothed barcodes to reduce 
                                         the time taken to compute the palette:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", "For", tags$i("smoothed"), "barcodes,", tags$i("k"), "-means clustering is applied using ", 
                                                 tags$a(href = "https://rdrr.io/cran/fpc/man/kmeansruns.html", "fpc::kmeansruns"),
                                                 ", which finds the optimal solution based on the average silhouette width for a range of 
                                                 possible values of ", tags$i("k"), " selected by the user, from a minimum of ", tags$i("k"), 
                                                 " = 4 to a maximum of ", tags$i("k"), " = 20 clusters. The number of starts of the ", tags$i("k"), 
                                                 "-means algorithm is 50 and the maximum number of iterations is 50."),
                                         tags$li(style = "margin-bottom: 5px", "For", tags$i("unsmoothed"), "barcodes,", tags$i("k"), "-means clustering 
                                         is applied using ", tags$a(href = "https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/kmeans", "stats::kmeans"),
                                         "for a single value of ", tags$i("k"), " selected by the user. The number of starts of the ", tags$i("k"), "-means algorithm is 50 and the 
                                                 maximum number of iterations is 50.")
                                       ),
                                       p("Prior to running the ", tags$i("k"), "-means algorithm ", tags$b("MovieBarcodeAnalyzeR"), " will ", 
                                         tags$a(href = "http://rfunction.com/archives/62", "set a seed"), "(specifically, ", tags$code("set.seed(1234)"),") 
                                         so that the results are reproducible and running the algorithm on the same data with the same settings will produce the same result each time."),
                                       p("The palette of colours for a barcode is visualized as a ", tags$a(href = "https://en.wikipedia.org/wiki/Treemapping", tags$b("treemap")), 
                                       ", an efficient way of presenting a colour palette that retains information about the prevalence of a particular colour. 
                                        The area of each branch of the treemap is proportional to the number of pixels assigned to a cluster."),
                                       p("A summary of the percentage of pixels in a cluster and the colour attributes of the cluster prototype in the L*a*b* colour space is also returned.")
                                       ),
                                column(6, withMathJax(), tags$h4("Richness, diversity, and evenness"),
                                       p("A range of descriptive statistics for each palette are provided:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$a(href = "https://en.wikipedia.org/wiki/Species_richness", "Richness:"), "the number of a colours (", tags$i("k"), ") in a palette."),
                                         tags$li(style = "margin-bottom: 5px", tags$a(href = "https://en.wikipedia.org/wiki/Entropy_(information_theory)", "Shannon entropy:"), "the degree to which data is distributed over its possible values:"),
                                         withMathJax("$$H = - \\sum_{i=1}^{k} p_{i}\\log_{2}p_{i}$$"),        
                                         p("The greater the value of ", tags$i("H"), ", the greater the diversity of a palette.", tags$i("H"), "sensitive to the rarer pixels in a palette."),
                                         tags$li(style = "margin-bottom: 5px", tags$a(href = "https://en.wikipedia.org/wiki/Diversity_index#Inverse_Simpson_index", "Simpson's reciprocal diversity:"), "a measure of how pixels are distributed across colours that is sensitive to the most abundant cluster in a palette, with values in the range [1, ", tags$i("k"), "] that increase as diversity increases:"),
                                         withMathJax("$$S^{'} = \\frac{1}{\\sum_{i=1}^{k} p_{i}^{2}}$$"),
                                         tags$li(style = "margin-bottom: 5px", tags$a(href = "https://en.wikipedia.org/wiki/Species_evenness", "Pielou's ", tags$i("J'"), ":"), "the evenness of a palette, equal to the ratio of the observed entropy to the maximum possible entropy for ", tags$i("k"), " colours:"),
                                         withMathJax("$$J^{'} = \\frac{H}{\\log_{2}k}$$"),
                                         tags$li(style = "margin-bottom: 5px", tags$a(href = "http://www.tiem.utk.edu/~gross/bioed/bealsmodules/simpsonDI.html", "Simpson's evenness index:"), "the ratio of ", tags$i("S'"), " to the richness of the palette:"),
                                         withMathJax("$$S_{E} = \\frac{S^{'}}{k}$$")
                                       ),
                                       tags$br(),
                                       p("For more information on these different indices see Heip, C. H. R., Herman, P. M. J., and Soetaert, K. (1998) ", tags$a(href = "https://www.semanticscholar.org/paper/Indices-of-diversity-and-evenness-Heip-Herman/4a720e577a35cf74505b9ffae42f03b3ffecb371", "Indices of diversity and evenness"), ", ", tags$i("Oc?anis"), "24 (4): 61-87.")
                                )
                       )
              )
  )
)