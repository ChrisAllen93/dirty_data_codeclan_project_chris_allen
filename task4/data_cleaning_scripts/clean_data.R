

# Load in libraries -------------------------------------------------------

library(tidyverse)
library(janitor)
library(readxl)


# Source functions --------------------------------------------------------

source("data_cleaning_scripts/cleaning_functions.R")

# Read in data sets -------------------------------------------------------


candy_2015 <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx") %>%
  clean_names()
candy_2016 <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx") %>%
  clean_names()
candy_2017 <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx") %>%
  clean_names()


# Clean 2015 data ---------------------------------------------------------

candy_2015_clean <- candy_2015 %>% 
  # renaming non-standard column headings
  rename(age = how_old_are_you, 
         going_out =
           are_you_going_actually_going_trick_or_treating_yourself) %>%
  # creating standard column headings
  mutate(year = as.integer(str_extract(timestamp, '[0-9]{1,4}')),
         id = row_number(timestamp) + 1e6,
         gender = NA_character_,
         country = NA_character_,
         age = as.integer(age)) %>%
  # reorder columns and pivot candy names and ratings
  select(id, year, going_out, age, gender, country, where(is.character)) %>%
  pivot_longer(-(id:country), names_to = "candy_name", values_to = "rating") %>%
  clean_candy_names() %>%
  clean_country_names()

# Clean 2016 data ---------------------------------------------------------

candy_2016_clean <- candy_2016 %>%
  # renaming non-standard column headings
  rename(going_out = are_you_going_actually_going_trick_or_treating_yourself,
         age = how_old_are_you,
         country = which_country_do_you_live_in,
         gender = your_gender) %>%
  # creating standard column headings
  mutate(id = row_number(timestamp) + 2e6,
         year = as.integer(str_extract(timestamp, '[0-9]{1,4}')),
         age = as.integer(age)) %>%
  # reorder columns and pivot candy names and ratings
  select(id, year, going_out, age, gender, country, where(is.character)) %>%
  pivot_longer(-(id:country), names_to = "candy_name", values_to = "rating") %>%
  clean_candy_names() %>%
  clean_country_names()

# Clean 2017 data ---------------------------------------------------------

candy_2017_clean <- candy_2017 %>% 
  # renaming non-standard column headings
  rename(id = internal_id) %>%
  rename_with(.fn = ~ gsub("q[0-9]+_","",.x)) %>% 
  # creating standard column headings
  mutate(year = as.integer(2017),
         age = as.integer(age)) %>% 
  # reorder columns and pivot candy names and ratings
  select(id, year, going_out, age, gender, country, where(is.character)) %>%
  pivot_longer(-(id:country), names_to = "candy_name", values_to = "rating") %>% 
  clean_candy_names() %>%
  clean_country_names()

# Combine data sets -------------------------------------------------------

candy_2015_clean %>% 
  bind_rows(candy_2016_clean) %>% 
  bind_rows(candy_2017_clean) %>% 
  mutate(age = if_else((age > 0 & age < 100), age, NA_integer_)) %>%
  write_csv("clean_data/candy_cleaned")
