

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
  rename(age = how_old_are_you, 
         going_out = are_you_going_actually_going_trick_or_treating_yourself) %>% 
  mutate(year = str_extract(timestamp, '[0-9]{1,4}'), .after = timestamp) %>%
  mutate(id = row_number(timestamp) + 1e6) %>% 
  mutate(gender = NA_character_, .after = age) %>% 
  mutate(country = NA_character_, .after = age) %>% 
  select(id, year:york_peppermint_patties, necco_wafers) %>% 
  # replace all non integer age inputs as NA, convert values to integers
  mutate(age = as.integer(age), year = as.integer(year)) %>% 
  pivot_longer(butterfinger:necco_wafers, names_to = "candy_name",
               values_to = "rating") %>%
  clean_candy_names() %>% 
  select(id, year, going_out, age, gender, country, candy_name, rating)


# Clean 2016 data ---------------------------------------------------------

candy_2016_clean <- candy_2016 %>% 
  rename(going_out = are_you_going_actually_going_trick_or_treating_yourself,
         age = how_old_are_you,
         country = which_country_do_you_live_in,
         gender = your_gender) %>%
  mutate(id = row_number(timestamp) + 2e6, .before = timestamp) %>% 
  mutate(year = str_extract(timestamp, '[0-9]{1,4}'), .after = timestamp) %>%
  clean_country_names() %>% 
  select(id, year:york_peppermint_patties, gender, 
         -which_state_province_county_do_you_live_in) %>% 
  # replace all non integer age inputs as NA, convert values to integers
  mutate(age = as.integer(age), year = as.integer(year)) %>%
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy_name",
               values_to = "rating") %>%
  clean_candy_names() %>% 
  select(id, year, going_out, age, gender, country, candy_name, rating)


# Clean 2017 data ---------------------------------------------------------

candy_2017_clean <- candy_2017 %>% 
  rename(id = internal_id) %>% 
  pivot_longer(q1_going_out:q11_day, names_to = "col_names",
               values_to = "value") %>%
  select(id, col_names, value) %>%
  mutate(col_names = str_remove(col_names, "q[0-9]_")) %>%
  pivot_wider(names_from = col_names, values_from = value) %>%
  clean_names() %>%
  mutate(year = as.integer(2017), .after = id) %>%
  mutate(age = as.integer(age)) %>%
  clean_country_names() %>% 
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy_name",
               values_to = "rating") %>% 
  clean_candy_names () %>% 
  select(id, year, going_out, age, gender, country, candy_name, rating)
  

# Combine datasets --------------------------------------------------------

candy_2015_clean %>% 
  bind_rows(candy_2016_clean) %>% 
  bind_rows(candy_2017_clean) %>% 
  mutate(age = if_else((age > 0 & age < 100), age, NA_integer_)) %>% 
  write_csv("clean_data/candy_cleaned")
