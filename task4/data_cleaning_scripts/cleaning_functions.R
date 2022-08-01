clean_country_names <- function(dataframe) {
  
  us_list <- c("merica", "ahemamerca", "alaska", "america","california","murica",
               "murrika","newjersey","newyork","northcarolina","pittsburgh",
               "trumpistan", "unhingedstates", "uniedstates","unitestates",
               "unitesstates", "uniteds", "us", "theunitedstates",
               "theunitedstatesofamerica", "unitedsates", "unitedstaes",
               "ipretendtobefromcanada,butiamreallyfromtheunitedstates",
               "unitedstate", "unitedstatea", "unitedstated", "usofa", "ussa",
               "ud", "USA", "sub-canadiannorthamericamerica",
               "theyooessofaaayyyyyy", "unitsstates")
  
  uk_list <- c("endland", "england", "scotland", "uk", "unitedkingdom",
               "unitedkindom")
  
  canada_list <- c("can", "canada")
  
  exclude_list <- c("a", "canae", "cascadia", "earth", "fearandloathing",
                    "idontknowanymore", "insanitylately", "namerica", "narnia",
                    "sovietcanuckistan", "subscribetodmuzonyoutube", "denial",
                    "godscountry", "neverland", "oneofthebestones", "seeabove",
                    "somewhere", "eua", "thereisntoneforoldmen",
                    "therepublicofcascadia", "thisone")
  
  dataframe %>%
    mutate(country = str_remove_all(country, "[0-9]*"),
           country = str_to_lower(country),
           country = str_remove_all(country, "[`.' !?0-9]"),
           country = if_else(str_detect(country, "uniteds"),"USA", country),
           country = if_else(str_detect(country, "usa"),"USA", country)) %>% 
    mutate(country = case_when(
      country %in% us_list ~ "USA",
      country %in% uk_list ~ "UK",
      country %in% canada_list ~ "Canada",
      country %in% exclude_list ~ NA_character_,
      !is.na(country) & country != "" ~ "Other"
    ), .after = country)

}

clean_candy_names <- function(dataframe) {
  
  not_candy <- c("Bonkers (the board game)",
                 "Anonymous brown globs that come in black and orange wrappers\t(a.k.a. Mary Janes)",
                 "Any full-sized candy bar",
                 "Candy that is clearly just the stuff given out for free at restaurants",
                 "Cash, or other forms of legal tender",
                 "Chardonnay",
                 "Chick-o-Sticks (we don’t know what that is)",
                 "Creepy Religious comics/Chick Tracts",
                 "Dental paraphernalia",
                 "Generic Brand Acetaminophen",
                 "Glow sticks",
                 "Gum from baseball cards",
                 "Healthy Fruit",
                 "Hugs (actual physical hugs)",
                 "Jolly Rancher (bad flavor)",
                 "Jolly Ranchers (good flavor)",
                 "JoyJoy (Mit Iodine!)",
                 "Senior Mints",
                 "Kale smoothie",
                 "Minibags of chips",
                 "Real Housewives of Orange County Season 9 Blue-Ray",
                 "Sandwich-sized bags filled with BooBerry Crunch",
                 "Spotted Dick",
                 "Those odd marshmallow circus peanut things",
                 "Vials of pure high fructose corn syrup, for main-lining into your vein",
                 "Vicodin",
                 "White Bread",
                 "Whole Wheat anything",
                 "abstained_from_m_ming",
                 "anonymous_brown_globs_that_come_in_black_and_orange_wrappers",
                 "broken_glow_stick",
                 "dental_paraphenalia",
                 "lapel_pins",
                 "mint_leaves",
                 "person_of_interest_season_3_dvd_box_set_not_including_disc_4_with_hilarious_outtakes",
                 "peterson_brand_sidewalk_chalk",
                 "any_full_sized_candy_bar") %>%
    make_clean_names()
  
dataframe %>%
  filter(!is.na(rating)) %>% 
  mutate(candy_name = case_when(
    candy_name == "bonkers_the_candy" ~ "bonkers",
    candy_name == "boxo_raisins" ~ "box_o_raisins",
    candy_name %in% "anonymous_brown_globs_that_come_in_black_and_orange_wrappers" ~ "mary_jane",
    TRUE ~ candy_name
  )) %>% 
    filter(!candy_name %in% not_candy) 

}