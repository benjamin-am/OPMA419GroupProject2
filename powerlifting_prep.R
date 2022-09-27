# OPMA 419 Group Project 2
# Benjamin LeBlanc, Shaan Gehlot, and Nevin Sangha
# Powerlifting - Deadlift Prediction
# Press 'Alt' + 'o' keys (not zero) to view (close) all sections
# Press 'Shift' + 'Alt' + 'o' to open all sections


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(janitor)
library(writexl)
library(Hmisc)
library(lubridate)
library(stringr)

# Set working directory ---------------------------------------------------
setwd("C:/Users/benro/OneDrive/Notes/Winter 2021/OPMA 419/Group Project 2")

# Importing Data ----------------------------------------------------------
plift <- read.csv("openpowerlifting.csv", stringsAsFactors = F) %>% 
  clean_names() %>% 
  select(name, sex, event, equipment, age, age_class, division, bodyweight_kg, weight_class_kg,
         best3squat_kg, best3bench_kg, best3deadlift_kg, total_kg, place, wilks, mc_culloch, glossbrenner, ipf_points,
         tested, country, federation, date, meet_country, meet_state, meet_name) 


# Manipulating Powerlifting Data --------------------------
bad_data <- plift[!complete.cases(plift), ]
plift_1 <- plift[complete.cases(plift), ]
plift_2 <- plift_1 %>% 
  mutate(date = ymd(date),
         country = gsub(" ", "", country, fixed = TRUE),
         tested = case_when(
           str_length(tested) > 1 ~ "Yes",
           TRUE ~ "No"
         )) %>% 
  filter(date >= ymd("2010-01-01"),
         age > 18,
         country > 1) %>% 
  mutate(country =
           case_when(
    str_detect(country, "USSR") ~ "Russia",
    str_detect(country, "WestGermany") ~ "WestGermany",
    TRUE ~ country
  ))
 



# Write to Excel Sheet ----------------------------------------------------
writexl::write_xlsx(plift_2, "plift.xlsx")



