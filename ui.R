source("MBA_welcome.R")
source("MBA_colour_spaces.R")
source("MBA_methodology.R")
source("MBA_analyze.R")

ui <- navbarPage(
  "MovieBarcodeAnalyzeR",
  
  theme = shinytheme("spacelab"), 
  
  welcome,
  methodology,
  colour_spaces,
  analyze
  
)