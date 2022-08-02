
# Load in libraries -------------------------------------------------------

library(tidyverse)
library(janitor)
library(readxl)

# Read in data ------------------------------------------------------------

# read in ship data and clean column names
ship_data <- read_xls("raw_data/seabirds.xls",
                      sheet = "Ship data by record ID") %>%
  clean_names()

# read in bird data and clean/rename column names
bird_data <- read_xls("raw_data/seabirds.xls",
                      sheet = "Bird data by record ID") %>%
  clean_names() %>% 
  rename(common_name = species_common_name_taxon_age_sex_plumage_phase,
         scientific_name = species_scientific_name_taxon_age_sex_plumage_phase,
         abbreviation = species_abbreviation)


# Clean data --------------------------------------------------------------

# join bird and ship data tables, select columns of interest and remove NAs
ship_data %>% 
  left_join(bird_data, by = "record_id") %>% 
  select(record_id, lat, long, common_name, scientific_name, abbreviation,
         count) %>% 
  filter(!is.na(count)) %>% 
  # remove age category and plummage codes from bird names
  mutate(abbreviation = str_remove_all(abbreviation, " [A-Z0-9]+"),
         common_name = str_remove_all(common_name, " [A-Z]{2}[0-9]| [A-Z]+|"),
         common_name = str_remove_all(common_name, " sensu lato"),
         scientific_name = str_remove_all(scientific_name, 
                                          " [A-Z]{2}[0-9]| [A-Z]+|")
  ) %>% 
  write_csv("clean_data/clean_data.csv")
