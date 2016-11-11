library(choroplethr)
library(dplyr)
library(readr)
library(choroplethrZip)
#library(tidyverse)
library(magrittr)
library(stringr)

ds <- read_csv('../data/Legally_Operating_Businesses.csv')
ds %<>% set_names(str_replace_all(names(.), ' ', '_'))
ds %<>% set_names(tolower(names(.)))

by_zip <- ds %>% count(address_zip) %>% arrange(-n) %>% set_names(c('region','value'))

nyc_fips = c(36005, 36047, 36061, 36081, 36085)
zip_choropleth(by_zip, title='Active Businesses 2016', legend='# of businesses',county_zoom = nyc_fips)

by_zip_sc <- ds %>% filter(license_category=='Sidewalk Cafe') %>% count(address_zip) %>% arrange(-n) %>% set_names(c('region','value'))
zip_choropleth(by_zip_sc,
               title='Sidewalk Cafes 2016',
               legend='# of SC',
               county_zoom=nyc_fips,
               num_colors=7,
               reference_map=TRUE)
