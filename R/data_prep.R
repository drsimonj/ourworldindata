library(tidyverse)


# Child Mortality vs Health Expenditure -----------------------------------

# Read in data & give columns easy names
# see: https://ourworldindata.org/grapher/child-mortality-vs-health-expenditure?tab=data
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

# Rename data object and save for package
child_mortality <- d
devtools::use_data(child_mortality)
