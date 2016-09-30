# Data sets about Financing Healthcare
#
# All data sets available from:
# https://ourworldindata.org/financing-healthcare/

library(tidyverse)
library(stringr)
library(countrycode)

# List to contain datasets extracted from the website
datalist <- list()

# Public Expenditure on Healthcare as Share of National GDP,1880 t --------

# Read data
d <- read_csv("https://ourworldindata.org/grapher/public-expenditure-on-healthcare-as-share-of-national-gdp.csv?country=ALL")

# Rename variables
d <- rename(d,
            year = Year,
            country = Country,
            health_exp = `Public Expenditure on Health`
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


