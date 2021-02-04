# Load package
# devtools::install_github("mattflor/chorddiag")
devtools::install_github("mattflor/chorddiag")
library(chorddiag)
pacman::p_load(tidyverse, data.table, here, chorddiag)

# Create dummy data
m <- matrix(c(1,  2, 3, 4,
              5, 6, 7, 8,
              9, 10, 11, 12,
              13,   14,  15, 16, 17, 18),
            byrow = TRUE,
            nrow = 6, ncol = 6)

# A vector of 4 colors for 4 groups
haircolors <- c("", "", "", "", "", "")
dimnames(m) <- list(have = haircolors,
                    prefer = haircolors)
groupColors <- c("#00653a", "#005EB8", "#FFDD89", "#F26223", "#1b565c", "#000000", )

# Build the chord diagram:
p <- chorddiag(m, groupColors = groupColors, groupnamePadding = 20)
p

# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/chord_interactive.html"))