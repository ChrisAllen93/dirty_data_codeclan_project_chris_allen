
# clean_country_names -----------------------------------------------------

clean_country_names <- function(dataframe) {
  
  us_list <-    c("merica", "ahemamerca", "alaska", "america","california",
                   "murica", "murrika","newjersey","newyork","northcarolina",
                   "pittsburgh", "trumpistan", "unhingedstates", "uniedstates",
                   "unitestates", "unitesstates", "uniteds", "us",
                   "theunitedstates", "theunitedstatesofamerica", "unitedsates",
                   "unitedstaes", "unitedstate", "unitedstatea", "unitedstated",
                   "usofa","ussa","ud", "USA", "theyooessofaaayyyyyy",
                   "unitsstates", "sub-canadiannorthamericamerica",
                   "ipretendtobefromcanada,butiamreallyfromtheunitedstates"
                   )
  
  uk_list <-    c("endland", "england", "scotland", "uk", "unitedkingdom",
                  "unitedkindom")
  
  canada_list <- c("can", "canada")
  
  exclude_list <- c("a", "canae", "cascadia", "earth", "fearandloathing",
                    "idontknowanymore", "insanitylately", "namerica", "narnia",
                    "sovietcanuckistan", "subscribetodmuzonyoutube", "denial",
                    "godscountry", "neverland", "oneofthebestones", "seeabove",
                    "somewhere", "eua", "thereisntoneforoldmen",
                    "therepublicofcascadia", "thisone", "atlantis",
                    "Not the USA or Canada",
                    "atropicalislandsouthoftheequator")
  
  list_of_countries %>%
    # removal of number, punctuation/spaces and converting to lowercase
    mutate(country = str_remove_all(country, "[0-9]*"),
           country = str_to_lower(country),
           country = str_remove_all(country, "[`.' !?0-9]")) %>%
    # filter out all countries in the exclusion list, i.e. are not countries
    filter(!country %in% exclude_list) %>% 
    # detect close matches to USA, picks up typos or repeated inputs
    mutate(country = if_else(str_detect(country, "uniteds"), "USA", country),
           country = if_else(str_detect(country, "usa"),"USA", country)) %>%
    # check remaining countries against the country lists
    mutate(country = case_when(
      country %in% us_list ~ "USA",
      country %in% uk_list ~ "UK",
      country %in% canada_list ~ "Canada",
      !is.na(country) & country != "" ~ "Other"
    ), .after = country) %>% 
    arrange(country, country)

}

# clean_candy_names -------------------------------------------------------

clean_candy_names <- function(dataframe) {

  candy_list <- c("butterfinger",
                  "mary_jane",
                  "brach_products_not_including_candy_corn",
                  "bubble_gum",
                  "cadbury_creme_eggs",
                  "snickers",
                  "dark_chocolate_hershey",
                  "dots",
                  "fuzzy_peaches",
                  "good_n_plenty",
                  "gummy_bears_straight_up",
                  "hershey_s_milk_chocolate",
                  "milky_way",
                  "reese_s_peanut_butter_cups",
                  "junior_mints",
                  "peanut_m_m_s",
                  "regular_m_ms",
                  "rolos",
                  "smarties_american",
                  "x100_grand_bar",
                  "black_jacks",
                  "bonkers",
                  "bottle_caps",
                  "box_o_raisins",
                  "candy_corn",
                  "chiclets",
                  "caramellos",
                  "goo_goo_clusters",
                  "heath_bar",
                  "hershey_s_kissables",
                  "kinder_happy_hippo",
                  "kit_kat",
                  "hard_candy",
                  "lemon_heads",
                  "licorice",
                  "licorice_not_black",
                  "lindt_truffle",
                  "lollipops",
                  "mars",
                  "mary_janes",
                  "maynards",
                  "milk_duds",
                  "laffy_taffy",
                  "reggie_jackson_bar",
                  "pixy_stix",
                  "nerds",
                  "nestle_crunch",
                  "nown_laters",
                  "pencils",
                  "tolberone_something_or_other",
                  "runts",
                  "mint_kisses",
                  "mint_juleps",
                  "mint_m_ms",
                  "ribbon_candy",
                  "skittles",
                  "smarties_commonwealth",
                  "starburst",
                  "swedish_fish",
                  "sweetums",
                  "three_musketeers",
                  "peanut_butter_bars",
                  "peanut_butter_jars",
                  "trail_mix",
                  "twix",
                  "york_peppermint_patties",
                  "necco_wafers",
                  "coffee_crisp",
                  "dove_bars",
                  "hersheys_dark_chocolate",
                  "hersheys_kisses",
                  "licorice_yes_black",
                  "mike_and_ike",
                  "blue_m_ms",
                  "red_m_ms",
                  "third_party_m_ms",
                  "mr_goodbar",
                  "peeps",
                  "reeses_pieces",
                  "sourpatch_kids_i_e_abominations_of_nature",
                  "sweet_tarts",
                  "sweetums_a_friend_to_diabetes",
                  "tic_tacs",
                  "whatchamacallit_bars",
                  "green_party_m_ms",
                  "independent_m_ms",
                  "take_5")

dataframe %>%
  mutate(candy_name = case_when(
    candy_name == "bonkers_the_candy" ~ "bonkers",
    candy_name == "boxo_raisins" ~ "box_o_raisins",
    candy_name %in% 
      "anonymous_brown_globs_that_come_in_black_and_orange_wrappers"
    ~ "mary_jane",
    TRUE ~ candy_name
  )) %>% 
    filter(!is.na(rating),
           candy_name %in% candy_list)

}