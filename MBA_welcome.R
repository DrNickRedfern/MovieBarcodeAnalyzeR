welcome <- tabPanel(
  "Welcome",
  
  titlePanel("MovieBarcodeAnalyzeR"),
  
  p("The goal of ", tags$b("MovieBarcodeAnalyzeR"), " is to open up computational approaches to analyzing 
    colour in the cinema to users with no experience of using the statistical programming language R.", tags$br(), 
    "With this app you can upload your movie barcode, extract and download data, and produce a range of 
    visualizations and summaries in just a few minutes with no coding required."),
  
  tags$hr(style = "border-color: #446e9b;"),
  tabsetPanel(type = "tabs",
              tabPanel("Welcome",
                       fluidRow(style = "padding-top: 12px",
                                column(6, 
                                       p(tags$b("Movie barcodes"), "are a commonly used method of visualizing colour in motion pictures and 
                                         contain a wealth of information that can be used for further analysis.", 
                                         tags$b("MovieBarcodeAnalyzeR"), "is an easy-to-use application to access and interact with that information. 
                                         The app uses the", tags$a(href = "https://www.r-project.org", "R statistical programming language"), "to process and visualize colour data, 
                                         but no knowledge of coding is required - just select your barcode and choose how you 
                                         want to explore the data it contains."),
                                       p("To learn more about the methods used by ", tags$b("MovieBarcodeAnalyzeR"), "to analyze and visualize the data in a barcode 
                                         visit the ", tags$b("methodology"), "page."),
                                       p("Working with colour data requires an understanding of how colour is represented, and you can find more information 
                                         on the ", tags$b("colour spaces"), "page."),
                                       p("On the ", tags$b("analyze"), "page you can upload your movie barcode and select from a range of visualizations that 
                                         you can then download for use in an assignment or research article. You can also download the data from your barcode for 
                                         further analysis."),
                                       tags$hr(style = "border-color: #446e9b;"),
                                       tags$h4("Citing MovieBarcodeAnalyzeR"),
                                       p("If you use find this app useful as part of your research, please cite it using the following reference:"),
                                       tags$ul(
                                         tags$li("Redfern, N. (2021) DrNickRedfern/MovieBarcodeAnalyzeR: MovieBarcodeAnalyzeR (Version v0.1.0). Zenodo. http://doi.org/10.5281/zenodo.4701549."),
                                         tags$br(),
                                         p(tags$a(href = "https://doi.org/10.5281/zenodo.4701549", 
                                                  img(src="https://zenodo.org/badge/DOI/10.5281/zenodo.4701549.svg")))
                                       )
                                ),
                                column(6, 
                                       align="center", img(src = paste0("MBA_welcome_", sample.int(7, 1), ".jpeg"), align = "middle", width = "400px")
                                )
                       )
              ),
              tabPanel("About",
                       fluidRow(style = "padding-top: 12px",
                                column(6, 
                                       tags$h4("MovieBarcodeAnalyzeR"),
                                       p("Version 0.1.0 (April 2021)"),
                                       p("Access the code for this app on Github:"),
                                       p(tags$i(
                                         class = "fa fa-github-square", 
                                         style = "vertical-align: middle; font-size: 24px; padding-right: 12px; padding-bottom: 5px;"),
                                         tags$a(href = "https://github.com/DrNickRedfern/MovieBarcodeAnalyzeR", "DrNickRedfern/MovieBarcodeAnalyzeR")),
                                       p("If you have any suggestions to help improve this app, please ", 
                                         tags$a(href = "https://docs.github.com/en/github/managing-your-work-on-github/creating-an-issue", "raise an issue through Github"), "."),
                                       tags$hr(style = "border-color: #446e9b;"),
                                       p("Author: Nick Redfern"),
                                       p(tags$i(
                                         class = "fab fa-orcid", 
                                         style = "vertical-align: middle; font-size: 24px; padding-right: 12px; padding-bottom: 5px;"), tags$a(href = "https://orcid.org/0000-0002-7821-2404","0000-0002-7821-2404")),
                                       tags$i(class = "fab fa-researchgate", 
                                              style = "vertical-align: top; font-size: 24px; padding-right: 12px; padding-bottom: 15px;"), 
                                       tags$a(href = "https://www.researchgate.net/profile/Nick_Redfern", "ResearchGate/NickRedfern"),
                                       p(tags$i(
                                         class = "fab fa-wordpress", 
                                         style = "vertical-align: middle; font-size: 24px; padding-right: 12px; padding-bottom: 5px;"), tags$a(href = "https://computationalfilmanalysis.wordpress.com", "https://computationalfilmanalysis.wordpress.com")),
                                       tags$hr(style = "border-color: #446e9b;"),
                                       tags$h4("License"),
                                       p(tags$a(href = "https://www.gnu.org/licenses/gpl-3.0.html", "GNU General Public License Version 3 (GPLv3).")),
                                       p("Copyright (C) 2021  Nick Redfern"),
                                      p("This program is free software: you can redistribute it and/or modify it under the terms of the GNU General 
                                         Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) 
                                         any later version."),
                                      p("This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
                                        without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
                                        See the GNU General Public License for more details."),
                                       p(tags$a(href = "https://github.com/DrNickRedfern/MovieBarcodeAnalyzeR/blob/main/LICENSE", "GNU General Public License Version 3 (GPLv3).")),
                                ),
                                column(6,
                                       tags$h4("Dependencies"),
                                       p("This application requires the following packages to be available in your R library:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$b("entropy:"), "Hausser, J., and Strimmer, J. (2014) entropy: Estimation of Entropy, Mutual Information and Related Quantities. R package version 1.2.1.", tags$a(href = "https://CRAN.R-project.org/package=entropy", "https://CRAN.R-project.org/package=entropy.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("farver:"), "Pedersen, T.L., Nicolae, B., and Fran\u00E7ois, R. (2020) farver: High Performance Colour Space Manipulation. R package version 2.0.3.", tags$a(href = "https://CRAN.R-project.org/package=farver", "https://CRAN.R-project.org/package=farver.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("fpc:"), "Hennig, C. (2020) fpc: Flexible Procedures for Clustering. R package version 2.2-9.", tags$a(href = "https://CRAN.R-project.org/package=fpc", "https://CRAN.R-project.org/package=fpc.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("ggpubr:"), "Kassambara, A. (2020) ggpubr: 'ggplot2' Based Publication Ready Plots. R package version 0.4.0.", tags$a(href = "https://CRAN.R-project.org/package=ggpubr", "https://CRAN.R-project.org/package=ggpubr.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("grid:"), "R Core Team (2020) R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria.", tags$a(href = "https://www.R-project.org/", "https://www.R-project.org/.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("imager:"), "Barthelme, S. (2020) imager: Image Processing Library Based on 'CImg'. R package version 0.42.3.", tags$a(href = "https://CRAN.R-project.org/package=imager", "https://CRAN.R-project.org/package=imager.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("shiny:"), "Chang, W., Cheng, J., Allaire, J.J., Sievert, C., Schloerke, B., Xie, Y., Allen, J., McPherson, J., Dipert, A., and Borges, B. (2021) shiny: Web Application Framework for R. R package version 1.6.0.", tags$a(href = "https://CRAN.R-project.org/package=shiny", "https://CRAN.R-project.org/package=shiny.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("shinycssloaders:"), "Sali, A., and Attali, D. (2020) shinycssloaders: Add Loading Animations to a 'shiny' Output While It's Recalculating. R package version 1.0.0.", tags$a(href = "https://CRAN.R-project.org/package=shinycssloaders", "https://CRAN.R-project.org/package=shinycssloaders.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("shinythemes:"), "Chang, W. (2021) shinythemes: Themes for Shiny. R package version 1.2.0.", tags$a(href = "https://CRAN.R-project.org/package=shinythemes", "https://CRAN.R-project.org/package=shinythemes.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("tidyverse:"), "Wickham, H., et al., (2019) Welcome to the tidyverse, ", tags$i("Journal of Open Source Software"), "4 (43), 1686.", tags$a(href = "https://doi.org/10.21105/joss.01686", "https://doi.org/10.21105/joss.01686")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("treemapify:"), "Wilkins, D. (2021) treemapify: Draw Treemaps in 'ggplot2'. R package version 2.5.5.", tags$a(href = "https://CRAN.R-project.org/package=treemapify", "https://CRAN.R-project.org/package=treemapify.")),
                                         tags$li(style = "margin-bottom: 5px", tags$b("viridis:"), "Garnier, S. (2018) viridis: Default Color Maps from 'matplotlib'. R package version 0.5.1.", tags$a(href = "https://CRAN.R-project.org/package=viridis", "https://CRAN.R-project.org/package=viridis.")),
                                       ),
                                       p(tags$b("Please note"), tags$br(), "Package version numbers were correct at the time the current version of ", tags$b("MovieBarcodeAnalyzeR"), "was published. 
                                         The version you have in your R library may differ.")
                                )
                       )
              )
  )
)
