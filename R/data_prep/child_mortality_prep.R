# Data sets about Child mortality.
#
# All data sets available from:
# https://ourworldindata.org/child-mortality/

library(tidyverse)
library(stringr)
library(countrycode)

# List to contain datasets extracted from the website
datalist <- list()

# Child mortality, 1751 to 2013 -------------------------------------------

# Read in data
d <- read_csv("https://ourworldindata.org/grapher/child-mortality.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            child_mort = `Under 5 mortality rate`
)

# Save to data list
datalist[["raw"]] <- d

# Sweden: Children per woman that survived childhood vs thosethat  --------

# Read in data
d <- read_csv("https://ourworldindata.org/grapher/Children-woman-death-vs-survival.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            survival_per_woman = `Children that survived past their 5th birthday per woman (based on Gapminder)`,
            deaths_per_woman = `Children that died before 5 years of age per woman (based on Gapminder)`
)

# Save to data list
datalist[["survival"]] <- d

# Poverty and child mortality ---------------------------------------------

# Read in data
d <- read_csv("https://ourworldindata.org/grapher/poverty-and-child-mortality.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = `Country`,
            continent = `Countries Continents`,
            child_mort = `Child Mortality Estimates (CME Info)`,
            population = `Total population (Gapminder)`,
            poverty = `Poverty headcount at $1.90 a day (2011 PPP)`
)

# Save to data list
datalist[["poverty"]] <- d

# Correlation between child mortality and mean years of schooling ---------

# Read in data
d <- read_csv("https://ourworldindata.org/grapher/correlation-between-child-mortality-and-mean-years-of-schooling-for-those-aged-15-and-older.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            continent = `Countries Continents`,
            child_mort = `Gapminder (child mortality estimates version 8)`,
            education = `Barro Lee Education Dataset: Educational Attainment (average years of total education)`
)

# Save to data list
datalist[["schooling"]] <- d

# Per capita total health expenditure vs child mortality ------------------

# Read in data
d <- read_csv("https://ourworldindata.org/grapher/per-capita-total-expenditure-on-health-vs-child-mortality.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp = `Health expenditure per capita, PPP (World Bank)`,
            child_mort = `Child Mortality Estimates (CME Info)`
)

# Save to data list
datalist[["total_health"]] <- d

# Merge data frames -------------------------------------------------------

# Merge by country and year only
d <- reduce(datalist, full_join, by = c("country", "year"))

# Remove any existing continent columns and add continent via countrycode package
d <- d %>%
  select(-matches("continent")) %>%
  mutate(continent = countrycode(country, "country.name", "continent"))

# Explore nested variables ------------------------------------------------

# Investigate variables that appeared multiple times across datasets and are duplicated
dup_var <- d %>% select(matches("\\.[xy]")) %>% names()

# Condense to the stems (original names) of these variables
dup_var_stems <- dup_var %>% str_replace("(\\.[x|y])+", "") %>% unique()

# For each stem, nest relevant data into a single variable
for (stem in dup_var_stems) {
  d <- d %>% nest_(key_col = stem, nest_cols = names(d)[str_detect(names(d), stem)])
}

# Find any nested variables (variables that appears multiple times)
keep(d, is.list)

# Only nested variable is child_mort.
# Explore variability across different versions...
d %>%
  select(child_mort) %>%
  unnest() %>%
  mutate(mu = rowMeans(., na.rm= TRUE)) %>%
  arrange(mu) %>%
  mutate(row = 1:n()) %>%
  select(-mu) %>%
  gather(key, value, -row) %>%
  ggplot(aes(x = value, y = row, color = key)) +
    geom_point()

# There is some variability, particularly in the child mortality of 200 - 400
# range. But otherwise, there seems to be a reasonable and unskewed clustering
# around the mean at each level. Therefore, decision is to calculate child_mort
# as the mean of existing estimates.
d <- d %>% mutate(child_mort = map_dbl(child_mort, rowMeans, na.rm = TRUE))


# Save data object --------------------------------------------------------

# Name of data to export with package
child_mortality <- d

# Reorder columns
child_mortality <- child_mortality %>% select(year, country, continent, population, child_mort, everything())

# Save for use in package
#devtools::use_data(child_mortality, overwrite = TRUE)
