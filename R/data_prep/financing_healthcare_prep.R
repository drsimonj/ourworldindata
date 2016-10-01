# Data sets about Financing Healthcare
#
# All data sets available from:
# https://ourworldindata.org/financing-healthcare/

library(tidyverse)
library(stringr)
library(countrycode)
source("R/data_prep/utility_functions.R")

# List to contain datasets extracted from the website
datalist <- list()

# Public Expenditure on Healthcare as Share of National GDP,1880 t --------

# Read data
d <- read_csv("https://ourworldindata.org/grapher/public-expenditure-on-healthcare-as-share-of-national-gdp.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp_public = `Public Expenditure on Health`
)

# Save to data list
datalist[["raw"]] <- d


# Public Health Insurance Coverage, 1910 to 1975 --------------------------

d <- read_csv("https://ourworldindata.org/grapher/public-health-insurance-coverage2.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_insurance = `Health Insurance Coverage`
)

# Save to data list
datalist[["insurance"]] <- d

# Expenditure of the National Health Service (NHS) in the UK,1950  --------

d <- read_csv("https://ourworldindata.org/grapher/expenditure-of-the-national-health-service-nhs-in-the-uk.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            nhs_exp = `NHS Expenditure %GDP 1950-2012`
)

# Save to data list
datalist[["nhs"]] <- d

# US Healthcare Expenditure, 1929 to 2013 ---------------------------------

d <- read_csv("https://ourworldindata.org/grapher/us-healthcare-expenditure.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp_private = `US Health Expenditure, Private`,
            health_exp_public = `US Health Expenditure, Public`
)

# Save to data list
datalist[["us"]] <- d

# Health Insurance Coverage in the U.S., 1987 to 2014 ---------------------

d <- read_csv("https://ourworldindata.org/grapher/health-insurance-coverage-in-the-us.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_insurance_govt = `Health Insurance Coverage US, Govt Plan`,
            health_insurance_private = `Health Insurance Coverage US, Private Plan`,
            health_insurance_any = `Health Insurance Coverage US, Any Plan`
)

# Save to data list
datalist[["insurance_type"]] <- d

# Total Healthcare Expenditure as Share of National GDP by Country --------

d <- read_csv("https://ourworldindata.org/grapher/total-healthcare-expenditure-as-share-of-national-gdp-by-country.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp_total = `Health Expenditure, Total (WDI)`
)

# Save to data list
datalist[["health_tot"]] <- d


# Public expenditure on healthcare as percent of total health care --------

d <- read_csv("https://ourworldindata.org/grapher/share-of-public-expenditure-on-healthcare-by-country.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp_public_percent = `Health Expenditure, Public Share (WDI)`
)

# Save to data list
datalist[["public_share"]] <- d


# Share of Out-of-Pocket Expenditure on Healthcare by Country,1995 --------

d <- read_csv("https://ourworldindata.org/grapher/share-of-out-of-pocket-expenditure-on-healthcare-by-country.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp_oop_percent = `Health Expenditure, Out-of-Pocket Share (WDI)`
)

# Save to data list
datalist[["oop_share"]] <- d

# Percentage of persons without health insurance in the US,1963 to --------

d <- read_csv("https://ourworldindata.org/grapher/percentage-of-persons-without-health-insurance-coverage-us.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            no_health_insurance = `Percentage of persons without health insurance`
)

# Save to data list
datalist[["no_insurance"]] <- d


# Healthcare Expenditure vs. GDP ------------------------------------------

d <- read_csv("https://ourworldindata.org/grapher/healthcare-expenditure-vs-gdp.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            gdp = `GDP per capita PPP 2011 – WDI`,
            health_exp_total = `Health Expenditure per capita (WDI)`
)

# Save to data list
datalist[["exp_gdp"]] <- d


# Interactive: Life Expectancy vs. Healthcare Expenditure -----------------

d <- read_csv("https://ourworldindata.org/grapher/life-expectancy-vs-healthcare-expenditure.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp_total = `Health Expenditure per capita (WDI)`,
            life_expectancy = `Life Expectancy (at birth) World Bank data`,
            continent = `Countries Continents`
)

# Save to data list
datalist[["life_exp"]] <- d


# Child Mortality vs. Health Expenditure ----------------------------------

d <- read_csv("https://ourworldindata.org/grapher/child-mortality-vs-health-expenditure.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            continent = `Countries Continents`,
            health_exp_total = `Health Expenditure per capita (WDI)`,
            child_mort = `Child mortality (Gapminder)`
)

# Save to data list
datalist[["child_mort"]] <- d

# Merge data frames -------------------------------------------------------

# Merge by country and year only
d <- reduce(datalist, full_join, by = c("country", "year"))

# Remove any existing continent columns and add continent via countrycode package
d <- d %>%
  select(-matches("continent")) %>%
  mutate(continent = countrycode(country, "country.name", "continent"))

# Nest duplicated columns
d <- d %>% nest_duplicated()

# Explore duplicated variables --------------------------------------------

# Find any nested variables (variables that appears multiple times)
keep(d, is.list)

# Two list variables: health_exp_public and health_exp_total

# Will need checking, but for now...

# Mutate nested variables into mean values
d <- d %>% mutate_if(is.list, funs(map_dbl(., na_mean)))

# # Save data object --------------------------------------------------------

# Name of data to export with package
financing_healthcare <- d

# Reorder columns
financing_healthcare <- financing_healthcare %>% select(year, country, continent, health_exp_total, health_exp_public, everything())

# Save for use in package
#devtools::use_data(financing_healthcare, overwrite = TRUE)
