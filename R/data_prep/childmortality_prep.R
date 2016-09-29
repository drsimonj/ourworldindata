# Data sets about Child mortality.
#
# source: https://ourworldindata.org/child-mortality/

library(tidyverse)

# Child mortality vs healthcare expenditure -------------------------------

# https://ourworldindata.org/child-mortality/#health-care-and-child-mortality

# Read in data (and save if new)
as_file <- "data/raw_downloads/child-mortality-vs-health-expenditure.RData"
if (file.exists(as_file)) {
  load(as_file)
} else {
  d <- read_csv("https://ourworldindata.org/grapher/child-mortality-vs-health-expenditure.csv?country=ALL")
  save(d, file = as_file)
}

# Rename variables
d <- rename(d,
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

# Read in data (and save if new)
as_file <- "data/raw_downloads/correlation-between-child-mortality-and-mean-years-of-schooling-for-those-aged-15-and-older.RData"
if (file.exists(as_file)) {
  load(as_file)
} else {
  d <- read_csv("https://ourworldindata.org/grapher/correlation-between-child-mortality-and-mean-years-of-schooling-for-those-aged-15-and-older.csv?country=ALL")
  save(d, file = as_file)
}

# Rename variables
d <- rename(d,
       year = Year,
       country = Country,
       continent = `Countries Continents`,
       child_mort = `Gapminder (child mortality estimates version 8)`,
       education = `Barro Lee Education Dataset: Educational Attainment (average years of total education)`
    )

# Select relevant variables and remove and any rows with missing data
d <- d %>%
       select(country, year, education) %>%
       filter(!is.na(education))

# Join to main data frame
childmortality <- childmortality %>% full_join(d)


# Child mortality and poverty ---------------------------------------------

# https://ourworldindata.org/child-mortality/#child-mortality-and-income-level

# Read in data (and save if new)
as_file <- "data/raw_downloads/poverty-and-child-mortality.RData"
if (file.exists(as_file)) {
  load(as_file)
} else {
  d <- read_csv("https://ourworldindata.org/grapher/poverty-and-child-mortality.csv?country=ALL")
  save(d, file = as_file)
}

# Rename variables
d <- rename(d,
            year = Year,
            country = `Country`,
            continent = `Countries Continents`,
            child_mort = `Child Mortality Estimates (CME Info)`,
            population = `Total population (Gapminder)`,
            poverty = `Poverty headcount at $1.90 a day (2011 PPP)`
)

# Select relevant variables and remove and any rows with missing data
d <- d %>%
  select(country, year, population, poverty) %>%
  filter(!is.na(poverty) | !is.na(population))

# Join to main data frame
childmortality <- childmortality %>% full_join(d)


# Save data object --------------------------------------------------------

# Reorder columns
childmortality <- childmortality %>% select(year, country, continent, population, child_mort, everything())

# Save for use in package
#devtools::use_data(childmortality, overwrite = TRUE)
