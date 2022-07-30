
# Load in libraries -------------------------------------------------------

library(tidyverse)
library(janitor)

# Read in data ------------------------------------------------------------

decathlon_raw <- read_rds("raw_data/decathlon.rds") %>% clean_names

# Clean Raw Data ----------------------------------------------------------

decathlon_raw %>% 
  # clean column headings
  clean_names() %>% 
  # convert row names into athlete_name column
  rownames_to_column(var = "athlete_name") %>%
  # format athlete_name string
  mutate(athlete_name = str_to_title(athlete_name)) %>%
  # rename column heading
  rename(javelin = javeline) %>% 
  # write cleaned data to file
  write_csv("clean_data/clean_data.csv")