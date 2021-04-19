server <- function(input, output, session){
  
  # Analyze > upload
  # upload movie barcode
  image <- reactive({
    req(input$file1)
    if (is.null(input$file1$datapath))
      return(NULL)
    ext <- tools::file_ext(input$file1$datapath)
    validate(
      need(ext %in% c("png", "jpeg", "jpg"),
           "Image format not recognized. Please upload a jpeg/jpg or png file."))
    load.image(input$file1$datapath)
  })
  
  # set output image format for visualisations depending on the type of barcode
  im_format <- reactive({
    if(input$barcode_type == 1) {lch_im_format <- "pdf"}
    else{lch_im_format <- "jpeg"}
  })
  
  # is the barcode smoothed or not - interested functions want to know
  smoothed <- reactive({
    if(input$barcode_type == 1) {smoothed <- TRUE}
    else{smoothed <- FALSE}
  })
  
  # print the title of the image file
  output$barcode_title <- renderText({
    req(input$file1)
    paste("<b>", paste(tools::file_path_sans_ext(input$file1)[1]), "</b>")})
  
  # Show the uploaded barcode with the correct aspect ratio
  upload <- reactive({
    req(input$file1)
    barcode(image())
  })
  
  output$show_upload <- renderPlot({upload()})
  
  # get the colour data from a barcode 
  image_summary_data <- reactive({
      barcode_dat(image(), smoothed())
  })
  
  # download colour data as csv file
  output$barcode_data_download <- downloadHandler(
    filename = function() {paste0(tools::file_path_sans_ext(input$file1), ".csv")},
    content = function(file) {write.csv(image_summary_data(), file, row.names = FALSE)}
  )
  
  # Analyze > LCH(ab)
  # reactives for plots in LCH(ab) colour space
  lch_hist_out <- reactive({lch_hist_plot(image_summary_data())})
  
  ch_plot_polar_out <- reactive({ch_plot_polar(image_summary_data())})
  
  ch_plot_cart_out <- reactive({ch_plot_cart(image_summary_data())})
  
  lc_plot_out <- reactive({lc_plot(image_summary_data())})
  
  chroma_trend <- reactive({chroma_trend_plot(image_summary_data(), smoothed = smoothed())})
  
  lig_trend <- reactive({lig_trend_plot(image_summary_data(), smoothed = smoothed())})
  
  # switch for plots in LCH(ab) colour space
  lch_plot_viz <- eventReactive(input$runScript_lch_plot, {
    switch(input$select_lch_plot,
           "Histograms" = lch_hist_out(),
           "Hue vs Chroma - polar" = ch_plot_polar_out(),
           "Hue vs Chroma - cartesian" = ch_plot_cart_out(),
           "Chroma vs Lightness" = lc_plot_out(),
           "Chroma trend" = chroma_trend(),
           "Lightness trend" = lig_trend()
    )
  })
  
  # output and download
  output$lch_plot <- renderPlot({lch_plot_viz()})
  
  output$download_lch_plot <- downloadHandler(
    filename = function() {paste0(input$select_lch_plot, ".", im_format())},
    content = function(file) {
      ggsave(file, plot = lch_plot_viz(), device = im_format(), dpi = 600,
             width = 15.92, height = 15.92, units = "cm")}
  )
  
  # Analyze > L*a*b*
  # reactives for plots in L*a*b* colour space
  lab_hist_out <- reactive({lab_hist_plot(image_summary_data())})
  
  ab_plot_out <- reactive({ab_plot(image_summary_data())})
  
  # cannot plot 2-d density plot for unsmoothed barcode because the data set is too large
  ab_plot_2d_out <- reactive({
    validate(
      need(input$barcode_type == 1, "a vs b - density plot is not available for unsmoothed barcodes")
    )
    ab_plot_2d(image_summary_data())
    })
  
  # switch for plots in L*a*b* colour space
  lab_plot_viz <- eventReactive(input$runScript_lab_plot, {
    switch(input$select_lab_plot,
           "Histograms" = lab_hist_out(),
           "a vs b - scatterplot" = ab_plot_out(),
           "a vs b - density plot" =  ab_plot_2d_out()
    )
  })
  
  # output and download
  output$lab_plot <- renderPlot({lab_plot_viz()})
  
  output$download_lab_plot <- downloadHandler(
    filename = function() {paste0(input$select_lab_plot, ".", im_format())},
    content = function(file) {
      ggsave(file, plot = lab_plot_viz(), device = im_format(), dpi = 600,
             width = 15.92, height = 15.92, units = "cm")}
  )
  
  # Analyze > k-means clustering
  # user set limits from slider
  k_range <- reactive({cbind(input$centroids[1], input$centroids[2])})
  
  # k-means method differs depending on typoe of barcode
  # only use lower slider value for unsmoothed barcodes
  clusters <- eventReactive(input$runScript_palette, {
    if(input$barcode_type == 1) {cluster_smooth(image_summary_data(), kmin = k_range()[1], kmax = k_range()[2])}
    else{cluster_unsmooth(image_summary_data(), k_clusters = k_range()[1])}
  })
  
  # visualisation and summary
  palette_viz <- eventReactive(input$runScript_palette, {
    palette_treemap(clusters())
  })
  
  palette_sum <- eventReactive(input$runScript_palette, {
    palette_indices(clusters())
  })

  palette_clust <- eventReactive(input$runScript_palette, {
    palette_clusters(clusters())
  })
  
  # text headings
  RDE_text <- eventReactive(input$runScript_palette, {
    paste("<h5><b>Richness, diversity, evenness</b></h5>")
  })

  Clusters_text <- eventReactive(input$runScript_palette, {
    paste("<h5><b>Clusters</b></h5>")
  })
  
  # output and download
  output$palette_plot <- renderPlot({palette_viz()})
  
  output$RDE_heading <- renderText({RDE_text()})
  
  output$palette_summary <- renderTable({palette_sum()})
  
  output$Clusters_heading <- renderText({Clusters_text()})
  
  output$palette_clusters_table <- renderTable(palette_clust(), align = c("lrrrr"), digits = 3)
  
  output$download_palette <- downloadHandler(
    filename = function() {paste0(tools::file_path_sans_ext(input$file1), ".pdf")},
    content = function(file) {
      ggsave(file, plot = palette_viz(), device = "pdf", dpi = 600,
             width = 15.92, height = 10.2, units = "cm")}
  )
  
}