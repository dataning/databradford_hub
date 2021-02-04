library(tidyverse)
library(reactable)

schools <- readRDS("schools.rds")
glimpse(schools)
schools <- schools %>% 
  rename(postcode = pc1) %>% 
  select(school, year, postcode, admission, everything())

schools <- schools %>%
  mutate(
    year = case_when(
      year == "1516" ~ "2014",
      year == "1617" ~ "2015",
      year == "1718" ~ "2016",
      year == "1819" ~ "2017",
      year == "1920" ~ "2018",
      year == "2021" ~ "2019",
      year == "2122" ~ "2020"
    )
  )

janitor::tabyl(schools$admission)
schools[is.na(schools)] <- 0

saveRDS(schools, "schools.rds")
schools$applicants <- as.numeric(as.factor(schools$applicants))

green_pal <- function(x) rgb(colorRamp(c("#e8f9e9", "#2dc937"))(x), maxColorValue = 255)
orange_pal <- function(x) rgb(colorRamp(c("#ffe4cc", "#ff9500"))(x), maxColorValue = 255)
red_pal <- function(x) rgb(colorRamp(c("#ffe5e5", "#ff6666"))(x), maxColorValue = 255)

reactable(
  schools, searchable = TRUE, showSortable = TRUE,
  columns = list(
    admission = colDef(style = function(value) {
      normalized <- (value - min(schools$admission)) / (max(schools$admission) - min(schools$admission))
      color <- red_pal(normalized)
      list(background = color)}), 
    applicants = colDef(style = function(value) {
      normalized <- (value - min(schools$applicants)) / (max(schools$applicants) - min(schools$applicants))
      color <- orange_pal(normalized)
      list(background = color)}), 
    allocated = colDef(style = function(value) {
      normalized <- (value - min(schools$allocated)) / (max(schools$allocated) - min(schools$allocated))
      color <- green_pal(normalized)
      list(background = color)})
  )
)

naniar::vis_miss(schools)
