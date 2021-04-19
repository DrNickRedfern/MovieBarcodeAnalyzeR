# plot the uploaded barcode maintaining the correct aspect ratio
barcode <- function(im){
  
  ggplot() +
    annotation_custom(rasterGrob(im, width = unit(1, "npc"), height = unit(1, "npc")), -Inf, Inf, -Inf, Inf) +
    theme_void() +
    theme(aspect.ratio = 1/(dim(im)[1]/dim(im)[2]))
  
}

# get colour data from movie barcode
barcode_dat <- function(im, smoothed = "TRUE"){
  
  # convert a smoothed barcode to a data frame containing the column number and attributes in 
  # RGB, L*a*b*, and LCH(ab) colour spaces using the 100th row of pixels only
  if(smoothed == "TRUE"){
  col <- 1:length(imrow(R(im), 100))
  r <- 255 * imrow(R(im), 100); g <- 255 * imrow(G(im), 100); b <- 255 * imrow(B(im), 100) # rescale to [0-255]
  rgb <- cbind.data.frame(r, g, b)
  lab <- convert_colour(rgb, from = "rgb", to = "lab") %>% rename(L = l, A = a, B = b)
  ch <-convert_colour(lab, from = "lab", to = "lch") %>% rename(C = c, H = h) %>% select(C, H) # select C and H only as L is identical to L*
  df <- cbind.data.frame(col, rgb, lab, ch)
  }
  # convert an unsmoothed barcode to a data frame containing the column and row numbers of a pixel and attributes in 
  # RGB, L*a*b*, and LCH(ab) colour spaces
  else{
    r <- as.data.frame(R(im)) %>% rename(col = x, row = y, r = value)
    g <- as.data.frame(G(im)) %>% rename(g = value) %>% select(g)
    b <- as.data.frame(B(im)) %>% rename(b = value) %>% select(b)
    rgb <- cbind.data.frame(r, g, b) %>% mutate(r = r * 255, g = g * 255, b = b * 255) # rescale to [0-255]
    lab <- convert_colour(rgb[3:5], from = "rgb", to = "lab") %>% rename(L = l, A = a, B = b)
    ch <-convert_colour(lab, from = "lab", to = "lch") %>% rename(C = c, H = h) %>% select(C, H) # select C and H only as L is identical to L*
    df <- cbind.data.frame(rgb, lab, ch)
  }
  
  return(df)
}

# plot hue, chroma, and lightness histograms in LCH(ab) colour space as a single figure
lch_hist_plot <- function(df){
  
  # vector of colours for fill
  c <- viridis(3)
  
  # hue histogram
  # filter achromatic pixels with arbitrary hue values for plotting hue histogram only
  df_H <- df %>% filter(C > 0)
  
  hue_hist <- ggplot(data = df_H, aes(x = H, y = ..count..)) +
    geom_histogram(fill = c[1], binwidth = 1, bins = 360) +
    stat_bin(geom = "step", binwidth = 1, bins = 360, position = position_nudge(x = -0.5)) +
    geom_segment(aes(x = H, xend = ..x.. + 1, y = ..count..,
                     yend = ..count..), colour = "black", stat = "bin", binwidth = 1,
                 position = position_nudge(x = -0.5)) +
    scale_x_continuous(name = "Hue", expand = c(0.01, 0), 
                       limits = c(-0.5, 360.5), 
                       breaks = seq(0, 330, 30), 
                       labels = function(x) paste0(x, "\u00B0")) +
    theme_minimal() + 
    theme(axis.title.y = element_blank())
  
  # chroma histogram
  chroma_hist <- ggplot(data = df, aes(x = C, y = ..count..)) +
    geom_histogram(fill = c[2], binwidth = 1, bins = 100) +
    stat_bin(geom = "step", binwidth = 1, bins = 100, position = position_nudge(x = -0.5)) +
    geom_segment(aes(x = C, xend = ..x.. + 1, y = ..count..,
                     yend = ..count..), colour = "black", stat = "bin", binwidth = 1,
                 position = position_nudge(x = -0.5)) +
    scale_x_continuous(name = "Chroma", expand = c(0.01, 0), 
                       limits = c(-0.5, 100.5), 
                       breaks = seq(0, 100, 10), 
                       labels = function(x) paste0(x, "%"))+
    theme_minimal() + 
    theme(axis.title.y = element_blank())
  
  # lightness histogram
  lig_hist <- ggplot(data = df, aes(x = L, y = ..count..)) +
    geom_histogram(fill = c[3], binwidth = 1, bins = 100) +
    stat_bin(geom = "step", binwidth = 1, bins = 100, position = position_nudge(x = -0.5)) +
    geom_segment(aes(x = L, xend = ..x.. + 1, y = ..count..,
                     yend = ..count..), colour = "black", stat = "bin", binwidth = 1,
                 position = position_nudge(x = -0.5)) +
    scale_x_continuous(name = "Lightness", expand = c(0.01, 0), 
                       limits = c(-0.5, 100.5), 
                       breaks = seq(0, 100, 10), 
                       labels = function(x) paste0(x, "%"))+
    theme_minimal() + 
    theme(axis.title.y = element_blank())
  
  # arrange histograms as a single figure
  fig <- ggarrange(hue_hist, chroma_hist, lig_hist, align = "v", nrow = 3)
  return(fig)
}

# plot attribute histograms in L*a*b* colour space
lab_hist_plot <- function(df){
  
  # vector of colours for fill
  c <- viridis(3)
  
  # a* histogram
  a_hist <- ggplot(data =df, aes(x = A, y = ..count..)) +
    geom_histogram(fill = c[1], binwidth = 1, bins = 257) +
    stat_bin(geom = "step", binwidth = 1, bins = 257, position = position_nudge(x = -0.5)) +
    geom_segment(aes(x = A, xend = ..x.. + 1, y = ..count..,
                     yend = ..count..), colour = "black", stat = "bin", binwidth = 1,
                 position = position_nudge(x = -0.5)) +
    scale_x_continuous(name = "Green - Red (a*)", expand = c(0.01, 0), 
                       limits = c(-128.5, 128.5), 
                       breaks = seq(-128, 128, 16)) +
    theme_minimal() + 
    theme(axis.title.y = element_blank())
  
  # b* histogram
  b_hist <- ggplot(data = df, aes(x = B, y = ..count..)) +
    geom_histogram(fill = c[2], binwidth = 1, bins = 257) +
    stat_bin(geom = "step", binwidth = 1, bins = 257, position = position_nudge(x = -0.5)) +
    geom_segment(aes(x = B, xend = ..x.. + 1, y = ..count..,
                     yend = ..count..), colour = "black", stat = "bin", binwidth = 1,
                 position = position_nudge(x = -0.5)) +
    scale_x_continuous(name = "Blue - Yellow (b*)", expand = c(0.01, 0), 
                       limits = c(-128.5, 128.5), 
                       breaks = seq(-128, 128, 16)) +
    theme_minimal() + 
    theme(axis.title.y = element_blank())
  
  # lightness histogram
  lig_hist <- ggplot(data = df, aes(x = L, y = ..count..)) +
    geom_histogram(fill = c[3], binwidth = 1, bins = 100) +
    stat_bin(geom = "step", binwidth = 1, bins = 100, position = position_nudge(x = -0.5)) +
    geom_segment(aes(x = L, xend = ..x.. + 1, y = ..count..,
                     yend = ..count..), colour = "black", stat = "bin", binwidth = 1,
                 position = position_nudge(x = -0.5)) +
    scale_x_continuous(name = "Lightness", expand = c(0.01, 0), 
                       limits = c(-0.5, 100.5), 
                       breaks = seq(0, 100, 10), 
                       labels = function(x) paste0(x, "%"))+
    theme_minimal() + 
    theme(axis.title.y = element_blank())
  
  # arrange histograms as a single figure
  fig <- ggarrange(a_hist, b_hist, lig_hist, align = "v", nrow = 3)
  return(fig)
}

# hue vs chroma plot with polar co-ordinates
ch_plot_polar <- function(df){
  
  ggplot(data = df) + 
    geom_point(aes(x = H, y = C, colour = rgb(r, g, b, maxColorValue = 255))) +
    scale_colour_identity() +
    coord_polar(theta = "x") +
    scale_x_continuous(limits = c(0, 360), breaks = seq(0, 330, 30), 
                       labels = function(x) paste0(x, "\u00B0")) +
    scale_y_continuous(name = "Chroma", limits = c(0,100), breaks = seq(0, 100, 25), 
                       labels = function(x) paste0(x, "%")) +
    theme_minimal() +
    theme(axis.title.x = element_blank())

}

# hue vs chroma plot with cartesian co-ordinates
ch_plot_cart <- function(df){
  
  # filter achromatic pixels with arbitrary hue values when plotting hue
  df <- df %>% filter(C > 0)
  
  ggplot(data = df) + 
    geom_point(aes(x = H, y = C, colour = rgb(r, g, b, maxColorValue = 255))) +
    scale_colour_identity() +
    scale_x_continuous(name = "Hue", limits = c(0, 360), breaks = seq(0, 330, 30), 
                       labels = function(x) paste0(x, "\u00B0")) +
    scale_y_continuous(name = "Chroma", limits = c(0,100), breaks = seq(0, 100, 25), 
                       labels = function(x) paste0(x, "%")) +
    theme_minimal() +
    theme(axis.title.x = element_blank())
  
}

# chroma vs lightness plot
lc_plot <- function(df){
  
  ggplot(data = df) +
    geom_point(aes(x = C, y = L, colour = rgb(r, g, b, maxColorValue = 255))) +
    scale_colour_identity() +
    scale_x_continuous(name = "Chroma", limits = c(0, 100), breaks = seq(0, 100, 20), 
                       labels = function(x) paste0(x, "%")) +
    scale_y_continuous(name = "Lightness", limits = c(0, 100), breaks = seq(0, 100, 20), 
                       labels = function(x) paste0(x, "%")) +
    theme_minimal()
  
}

# chroma vs frame plot: as frames are time ordered this plot shows the trend in chroma over time
# for unsmoothed barcodes the trend is plotted using using the default method = 'gam' and formula 'y ~ s(x, bs = "cs")
chroma_trend_plot <- function(df, smoothed = "TRUE"){
  
  if(smoothed == "TRUE"){
    p <- ggplot(data = df) +
      geom_path(aes(x = col, y = C), colour = "grey40") +
      geom_point(aes(x = col, y = C, colour = rgb(r, g, b, maxColorValue = 255)))+
      scale_colour_identity() +
      scale_x_continuous(name = "Frame") +
      scale_y_continuous(name = "Chroma", limits = c(0, 100), breaks = seq(0, 100, 20), 
                         labels = function(x) paste0(x, "%")) +
      theme_minimal()
  }
  else{
    p <- ggplot(data = df) +
      geom_point(aes(x = col, y = C, colour = rgb(r, g, b, maxColorValue = 255)))+
      geom_smooth(aes(x = col, y = C), colour = "grey65") +
      scale_colour_identity() +
      scale_x_continuous(name = "Frame") +
      scale_y_continuous(name = "Chroma", limits = c(0, 100), breaks = seq(0, 100, 20), 
                         labels = function(x) paste0(x, "%")) +
      theme_minimal()
  }
  
  return(p)

}

# lightness vs frame plot: as frames are time ordered this plot shows the trend in lightness over time
# for unsmoothed barcodes the trend is plotted using using the default method = 'gam' and formula 'y ~ s(x, bs = "cs")
lig_trend_plot <- function(df, smoothed = "TRUE"){
  
  if(smoothed == "TRUE"){
    p <- ggplot(data = df) +
      geom_path(aes(x = col, y = L), colour = "grey40") +
      geom_point(aes(x = col, y = L, colour = rgb(r, g, b, maxColorValue = 255)))+
      scale_colour_identity() +
      scale_x_continuous(name = "Frame") +
      scale_y_continuous(name = "Lightness", limits = c(0, 100), breaks = seq(0, 100, 20), 
                         labels = function(x) paste0(x, "%")) +
      theme_minimal()
  }
  else{
    p <- ggplot(data = df) +
      geom_point(aes(x = col, y = L, colour = rgb(r, g, b, maxColorValue = 255)))+
      geom_smooth(aes(x = col, y = L), colour = "grey65") +
      scale_colour_identity() +
      scale_x_continuous(name = "Frame") +
      scale_y_continuous(name = "Lightness", limits = c(0, 100), breaks = seq(0, 100, 20), 
                         labels = function(x) paste0(x, "%")) +
      theme_minimal()
  }
  
  return(p)
  
}

# distribution of pixels on a* and b* axes of L*a*b* colour space
ab_plot <- function(df){
  
  ggplot(data = df) + 
    geom_point(aes(x = A, y = B, colour = rgb(r, g, b, maxColorValue = 255))) +
    scale_x_continuous(name = "Green - Red (a*)") +
    scale_y_continuous(name = "Blue - Yellow (b*)") +
    scale_colour_identity() +
    theme_minimal()

}

# distribution of pixels on a* and b* axes of L*a*b* colour space with 2D density overlaid
ab_plot_2d <- function(df){
  
  ggplot(data = df) +
    geom_point(aes(x = A, y = B), colour = "black") +
    geom_density_2d_filled(aes(x = A, y = B), alpha = 0.75, bins = 20) +
    scale_x_continuous(name = "Green - Red (a*)") +
    scale_y_continuous(name = "Blue - Yellow (b*)") +
    scale_fill_viridis(option = "viridis", discrete = TRUE) +
    guides(fill = FALSE) +
    theme_minimal()

}

# k-means cluster analysis for smoothed barcodes using fpc::kmeansruns
# returns optimal clustering for a range specified by the user based on the average silhouette width
cluster_smooth <- function(df, kmin = "10", kmax = "20"){
  
  # calculate means and sds for rescaling
  mu_l <- mean(df$L); sd_l <- sd(df$L)
  mu_a <- mean(df$A); sd_a <- sd(df$A)
  mu_b <- mean(df$B); sd_b <- sd(df$B)
  
  # select and scale L*a*b* values
  df <- df %>% select(L, A, B) %>% scale
  
  # apply k means clustering
  set.seed(1234)
  kMeans <- kmeansruns(df, krange = kmin:kmax, criterion = "asw", iter.max = 50, runs = 50)
  
  # rescale centers and convert to RGB for plotting
  lab <- as.data.frame(kMeans$centers)
  df_r <- lab %>% mutate(L_r = (L * sd_l) + mu_l, 
                        A_r = (A * sd_a) + mu_a,
                        B_r = (B * sd_b) + mu_b) %>% 
    select(L_r, A_r, B_r)
  rgb <- convert_colour(df_r, from = "lab", to = "rgb")
  col <- cbind.data.frame(df_r, rgb)
  
  # put number of pixels in each cluster into data frame and calculate percentage of pixels in a cluster
  size <- kMeans$size %>% data.frame %>% rename(size = 1) %>% mutate(per = size/sum(size))
  
  # combine data frames for return
  df_out <- cbind.data.frame(col, size)

  return(df_out)
}

# k-means cluster analysis for unsmoothed barcodes
# returns clustering for a value of k supplied by the user
cluster_unsmooth <- function(df, k_clusters = "10"){

  # calculate means and sds for rescaling
  mu_l <- mean(df$L); sd_l <- sd(df$L)
  mu_a <- mean(df$A); sd_a <- sd(df$A)
  mu_b <- mean(df$B); sd_b <- sd(df$B)

  # select and scale L*a*b* values
  df <- df %>% select(L, A, B) %>% scale

  # apply k means clustering
  set.seed(1234)
  kMeans <- kmeans(df, centers = k_clusters, iter.max = 50, nstart = 50)
  
  # rescale centers and convert to RGB for plotting
  lab <- as.data.frame(kMeans$centers)
  df_r <- lab %>% mutate(L_r = (L * sd_l) + mu_l,
                         A_r = (A * sd_a) + mu_a,
                         B_r = (B * sd_b) + mu_b) %>%
    select(L_r, A_r, B_r)
  rgb <- convert_colour(df_r, from = "lab", to = "rgb")
  col <- cbind.data.frame(df_r, rgb)

  # put number of pixels in each cluster into data frame and calculate percentage of pixels in a cluster
  size <- kMeans$size %>% data.frame %>% rename(size = 1) %>% mutate(per = size/sum(size))

  # combine data frames for return
  df_out <- cbind.data.frame(col, size)

  return(df_out)
}

# treemap of palette returned by k-means clustering
palette_treemap <- function(df){
  
  ggplot(data = df) +
    geom_treemap(aes(area = per), 
                 fill = rgb(df$r, df$g, df$b, maxColorValue = 255)) +
    theme(plot.title = element_text(face = "bold", size = 12),
          aspect.ratio = 1/1.56)
  
}

# A selection of indices summarising the richness, diversity, and evennes of a palette returned by k-means clustering
# indices include the number of colours in the palette (k), Shannon entropy, Simpson's S', Pielou's J', and Simpson's E
palette_indices <- function(df){
  
  df <- df %>% mutate(entropy = entropy.empirical(size, unit = "log2"),
                      p_2 = per^2)
  
  e <- df %>% distinct(entropy)
  s <- df %>% summarise(Simpson = 1/sum(p_2))
  
  pal_sum <- df %>% summarise(n = n()) %>% rename(k = n)
  pal_sum <- cbind.data.frame(pal_sum, e, s)
  pal_sum <- pal_sum %>% mutate(`Pielou's J'` = entropy/log2(k)) %>%
    mutate(`Simpson's E` = Simpson/k) %>%
    rename(`Shannon entropy` = entropy, `Simpson's S'` = Simpson)
  
  return(pal_sum)
  
}

# return a data frame containing the percentage if pixels in a cluster and the L*a*b* attributes from k-means clustering
palette_clusters <- function(df){
  
 df %>% select(per, L_r, A_r, B_r) %>% arrange(desc(per)) %>% 
    mutate(temp = format(round(per * 100, 1), nsmall = 1),
           Size = paste0(temp, "%"),
           row = 1:length(per),
           Cluster = paste("Cluster", row, sep = " "),
           `L*` = round(L_r, 3),
           `a*` = round(A_r, 3),
           `b*` = round(B_r, 3)) %>%
    select(Cluster, Size, `L*`, `a*`, `b*`)
}
