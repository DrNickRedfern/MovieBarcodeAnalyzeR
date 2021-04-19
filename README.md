# MovieBarcodeAnalyzeR

**MovieBarcodeAnalyzeR** is a shiny app for extracting and visualizing colour data from movie barcodes.

Movie barcodes are a commonly used method of visualizing colour in motion pictures and contain a wealth of information that can be used for further analysis. 

![escape_room](/images/escape_room_unsmoothed.png)

The goal of **MovieBarcodeAnalyzeR** is to open up computational approaches to analyzing colour in the cinema to users with no experience of using the statistical programming language R. With this app you can upload your movie barcode, extract and download data, and produce a range of visualizations and summaries in just a few minutes with no coding required. 

## Set up and use the app
There are four things you will need in order to use **MovieBarcodeAnalyzeR**: R, Rstudio, a collection of R packages, and the code to initialise the app. All of the software and code required to run the app is freely available.

### Step 1: install R
To download R, go to the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org), and download and install the latest version of R appropriate to your system.

### Step 2: install RStudio
RStudio is an integrated development environment (IDE) for R. Select the latest release of RStudio for your system at [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/).

Once installed, open Rstudio to complete the next steps.

### Step 3: install required packages
A *package* is a collection of functions that extends the base install of R. To run **MovieBarcodeAnalyzeR** you will need to install the following packages using the code below:

```R
install.packages(c("shiny", "shinycssloaders", "shinythemes", "tidyverse", "imager", "grid", "viridis", "ggpubr", "treemapify", "entropy", "farver", "fpc"))
```

You can copy and paste the above code into the console (highlighted below) in RStudio and press `Enter`.

![RStudio console](/images/RStudio_console_2.png)

### Step 4: run MovieBarcodeAnalyzeR
You only need to complete steps 1 through 3 the first time you run **MovieBarcodeAnalyzeR**.

Anytime you want to run **MovieBarcodeAnalyzeR** use the following code to initialise the app (note that in R, object names are *case sensitive* and must be entered correctly in order to run):

```R
shiny::runGitHub('MovieBarcodeAnalyzeR', 'DrNickRedfern', ref = "main")
```
Again, you can simply copy-and-paste this code to the console in RStudio and hit `Enter` to start the app.

Once **MovieBarcodeAnalyzeR** is running, no coding is required to use the app.

## MovieBarcodeAnalyzeR
The app contains details on how data is processed and visualized.

## Try out the app
If you would like to try out **MovieBarcodeAnalyzeR** I have included the smoothed and unsmoothed barcodes of the trailer for *Escape Room* in the images folder of this repository that you can download.
