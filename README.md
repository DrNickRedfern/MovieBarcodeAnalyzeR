# MovieBarcodeAnalyzeR

**MovieBarcodeAnalyzeR** is a shiny app for extracting and visualizing colour data from movie barcodes.

## Pre-requisties
There are four things you will need in order to use **MovieBarcodeAnalyzeR**: R, Rstudio, a collection of R packages, and the code to initialise the app.

### Step 1: install R
To download R, go to the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org), and download the latest version of R appropriate to your system.

### Step 2: install RStudio
RStudio is an integrated development environment (IDE) for R. Select the latest release of RStudio for your system at [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/).

### Step 3: install required packages
A *package* is a collection of functions that extends the base install of R. To run **MovieBarcodeAnalyzeR** you will need to install the following packages using the code below:

```R
install.packages(c("shiny", "shinycssloaders", "shinythemes", "tidyverse", "imager", "grid", "viridis", "ggpubr", "treemapify", "entropy", "farver", "fpc"))
```

You can copy and paste the above code into the console in RStudio and press `Enter`.
![RStudio console](/images/RStudio_console.png)

### Step 4: run MovieBarcodeAnalyzeR
You only need to complete steps 1 through 3 the first time you run **MovieBarcodeAnalyzeR**.
Everytime you want to run **MovieBarcodeAnalyzeR** use the following code to initialise the app (note that in R, object names are *case sensitive* and must be entered correctly in order to run):

```R
library(shiny)

runGithub("MovieBarcodeAnalyzeR", "DrNickRedfern")
```
Again, you can simply copy-and-paste this code to the consle in RStudio and hit `Enter` to start the app.
Once running, no coding is required to use the app.
