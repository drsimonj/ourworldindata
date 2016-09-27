# Data sets about Child mortality.
#
# source: https://ourworldindata.org/child-mortality/

library(tidyverse)

# Child mortality vs healthcare expenditure -------------------------------

# https://ourworldindata.org/child-mortality/#health-care-and-child-mortality

d <- read_csv("https://ourworldindata.org/grapher/child-mortality-vs-health-expenditure.csv?country=ALL") %>%
  rename(
    year = Year,
    country = Country,
    health_exp = `Health Expenditure per capita (WDI)`,
    child_mort = `Child mortality (Gapminder)`,
    continent = `Countries Continents`
  )

# Adding Continent information because
# continent information is held in only certain rows (eg where `year == 2015`)

# Extract the rows with continents
cont <- d  %>% select(country, continent) %>% filter(!is.na(continent))

# Remove continent column from `d`, then join continent info
d <- d %>%
  select(-continent) %>%
  left_join(cont)

# Remove rows with missing data on health_exp & child_mort
d <- d %>% filter(!(is.na(health_exp) & is.na(child_mort)))

# Save to main data frame
childmortality <- d

# Child mortality vs education --------------------------------------------

# https://ourworldindata.org/child-mortality/#better-education-of-women-reduces-child-mortality

d <- read_csv("https://ourworldindata.org/grapher/correlation-between-child-mortality-and-mean-years-of-schooling-for-those-aged-15-and-older.csv?country=ALL") %>%
  rename(
    year = Year,
    country = Country,
    continent = `Countries Continents`,
    child_mort = `Gapminder (child mortality estimates version 8)`,
    education = `Barro Lee Education Dataset: Educational Attainment (average years of total education)`
  )

# Remove duplicate rows from previous data set
# and any rows with missing data on new variable(s)
d <- d %>%
       select(country, year, education) %>%
       filter(!is.na(education))

# Save to main data frame
childmortality <- childmortality %>% full_join(d)

# Save data object --------------------------------------------------------

devtools::use_data(childmortality)
