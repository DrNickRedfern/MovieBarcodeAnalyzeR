colour_spaces <- tabPanel(
  "Colour spaces",
  
  titlePanel("Understanding colour spaces"),
  p("In order to analyze colour in film we need method for representing colours: specifically, we need to work in a ",
  tags$a(href = "https://en.wikipedia.org/wiki/Color_space", "colour space"), ", a geometrical representation of the range of colours that can be 
  represented by a ", tags$a(href = "https://en.wikipedia.org/wiki/Color_model", "colour model"), 
  ", where the ", tags$a(href = "https://en.wikipedia.org/wiki/Tuple", "tuple"), 
  " describing a colour corresponds to the coordinates of a colour in a 
  3-dimensional space."),
  p(tags$b("MovieBarcodeAnalyzeR"), " extracts RGB colour data from a barcode and converts this to the L*a*b* and LCH(ab) colour spaces for analysis. 
    Conversions between colour spaces are performed using the ", tags$a(href = "https://github.com/thomasp85/farver", "farver"), "package."),
  
  tabsetPanel(type = "tabs",
              tabPanel("RGB",
                       fluidRow(style = "padding-top: 12px",
                                column(5,
                                       p("The ", tags$a(href = "https://en.wikipedia.org/wiki/RGB_color_model", "RGB colour model"), 
                                       " is a defined by the chromaticity of three primary colours, 
                                         red, green, and blue, with colours produced through the additive mixing of these 
                                         primaries."),
                                       p("RGB colours are described by a tuple comprising three numbers that represent the 
                                         values of the red, green, and blue channels, respectively, with each channel represented on a 
                                         scale from 0-255. For example, cyan contains no red but has the maximum value for both the green 
                                         and blue channels, and so it has the tuple (0, 255, 255). In contrast, 
                                         a vivid cerise has the maximum value for the red channel with a little green and some blue, 
                                         and has the tuple (255, 51, 102)."),
                                       p("When the values in an RGB tuple are equal the colour is achromatic, 
                                         ranging from black (0, 0, 0) to white (255, 255, 255), with all other tuples on 
                                         this axis representing shades of grey (e.g., dark grey is (127, 127, 127))."),
                                       p("The RGB colour space is not perceptually uniform; that is, the perceived 
                                         difference between two RGB colours is not proportional to Euclidean distance 
                                         between them, so that differences in the values of the attributes of a colour do 
                                         not correspond to the differences we actually see between colours. For this reason, analyses 
                                         are conducted in the L*a*b* and LCH(ab) colour spaces."),
                                         p("However, it will be necessary when visualizing the colour data in a movie barcode to 
                                         convert the values of their respective attributes to the RGB colour space because 
                                         in order to display colours on a screen they must be RGB. Computer monitors use RGB colour; 
                                         they do ", tags$i("not"), "display L*a*b* or LCH(ab) colours.")
                                       ),
                                column(5,
                                       align="center", img(src = "RGB_colour_space.png", align = "middle", width = "100%")
                                       ),
                                column(2,
                                       p(tags$b("The RGB colour space."), tags$br(), "Values for the red and green channels are shown on the x- and
                                         y-axes, respectively. A range of values for the blue channel are shown in the panel headers.")
                                       )
                                ),
                       ),
              tabPanel("L*a*b*",
                       fluidRow(style = "padding-top: 12px",
                                column(5,
                                       p("The ", tags$a(href = "https://en.wikipedia.org/wiki/CIELAB_color_space", "CIE-L*a*b*"), 
                                         " colour space is a perceptually uniform colour space defined by three attributes:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$b("Lightness (L*)"), ": perceptual lightness, measured as a percentage"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("a*"), ": chromaticity along the green (-a*) - red (+a*) axis"),
                                         tags$li(style = "margin-bottom: 5px", tags$b("b*"), ": chromaticity along the blue (-b*) - yellow (+b*) axis")
                                       ),
                                       p("Theoretically, a* and b* are unbounded, but in practice most colour packages in R clamp the range of each 
                                         attribute to [-128, 127]."),
                                       p("Achromatic colours occur where the values of a* and b* are both zero and 
                                         change with increasing lightness from black (L* = 0%) to white (L* = 100%), with grey values between 
                                         these limits.")
                                ),
                                column(5,
                                       align="center", img(src = "LAB_colour_space.png", align = "middle", width = "100%")
                                ),
                                column(2,
                                       p(tags$b("The L*a*b* colour space"), tags$br(), "The values of a* and b* are shown on the x- and
                                         y-axes, respectively. A range of lightness values are shown in the panel headers.")
                                )
                                ),
              ),
              tabPanel("LCH(ab)",
                       fluidRow(style = "padding-top: 12px",
                                column(5,
                                       p(tags$a(href = "https://en.wikipedia.org/wiki/CIELAB_color_space#Cylindrical_model", "LCH(ab)"), 
                                       " is a polar representation of the L*a*b* colour space that is much easier 
                                         to understand and has the following attributes:"),
                                       tags$ul(
                                         tags$li(style = "margin-bottom: 5px", tags$b("Lightness (L*)"), ": perceptual lightness, measured as a percentage. 
                                                 This is identical to lightness in the L*a*b* colour space."),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Chroma"), ": the saturation or vividness of a colour, measured as 
                                                 the distance from the achromatic axis and reported as a percentage."),
                                         tags$li(style = "margin-bottom: 5px", tags$b("Hue"), ": the basic colour represented as the angle on  a colour 
                                                 wheel, where red = 0\u00B0, yellow = 90\u00B0, green = 180\u00B0, and blue = 270\u00B0.")
                                       ),
                                       p("Achromatic colours occur when C = 0%, and vary with lightness, from black 
                                         (L = 0%) to white (L = 100%). Hues are arbitrary for achromatic colours. ")
                                ),
                                column(5,
                                       align="center", img(src = "LCH_colour_space.png", align = "middle", width = "100%")
                                ),
                                column(2,
                                       p(tags$b("The LCH(ab) colour space"), tags$br(), "Hue and chroma across a range of lightness values.")
                                )
                                )
              )
  )
)