#################################
### Intermediate & Advanced R ###
#################################

# Adam M Chekroud
# November 4th, 2016

###########################
##### Wrapping up #########
###########################

# Example 1 will be downloading a large data set from the Centres of Medicare and Medicaid Services
# We will manipulate the dataset and visualise it on a map of the US


# ------------- Preprocessing -------------------

setwd("~/Desktop/IntermediateR-2016")

# The data are here
URL <- "https://data.medicare.gov/views/bg9k-emty/files/02ffa617-c42c-4766-8d53-4911e3ecd987?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Physician_Compare.zip"


# You can download data from a URL directly within R 
#     NB this takes some time, the zip is ~ 170mb (and ~700MB uncompressed)
download.file(url = URL, destfile = "physician-compare-bundle.zip", method = "curl")

## Unzip bundle to the working directory
system("unzip -o physician-compare-bundle.zip")
# Tidy up
system("rm -rf physician-compare-bundle.zip")





# ------------- Example -------------------

# install.packages(c("tidyverse", "doMC", "stringr", "maps", "mapproj"))

library(tidyverse); library(doMC); library(stringr); library(maps); library(mapproj)
registerDoMC() # register the parallel backend
options(scipen = 100) # stop R from using scientific notation


# read in the csv file

raw_practice <- read.csv("Physician_Compare_2014_Group_Practice_Public_Reporting_-_Clinical_Quality_Of_Care.csv",
                         as.is = TRUE)

str(raw_practice)

# histogram of one of the variables
qplot(raw_practice$Getting.a.flu.shot.during.flu.season.)

# dplyr is a package for data frame manipulation and database connections
# here is an example of how to select certain columns
practice <- dplyr::select(raw_practice, -starts_with("Footnote"))

# there is an alternative way or writing this using a "pipe"
# instead of saying f( g(x) ) you can simply say g(x) %>% f()
# this is very readable for complex pipelines
# pipes exist in other languages too (famous example is | in bash)

practice <- raw_practice %>% dplyr::select(-starts_with("Footnote"))

# We only have state abbreviations, but will need full state names later
# lets download a convenient csv that maps the two

URL2 <- "http://www.fonz.net/blog/wp-content/uploads/2008/04/states.csv"
download.file(url = URL2, destfile = "states.csv", method = "curl")

states <- read.csv("states.csv", as.is = TRUE)

head(states)

# dplyr allows you to do SQL-like joins in a much simpler language
# here we join the "states" dataframe to the "practice" data frame

practice <- full_join(practice, states, by = c("State" = "Abbreviation")) 

# lets make all the state names lowercase
practice$stateName <- str_to_lower(practice$State.y)

# summarise each column of the data frame, using the parallel version of lapply
mclapply(practice, function(i) summary(i, useNA="always"))

# next we calculate the average for each column, broken down by state, and view it
practice %>%
    group_by(State) %>%
    summarise_each(funs = "mean(., na.rm=TRUE)") %>% View

# lets calculate these averages and save it as a new dataframe that we will plot
av.practice <- practice %>%
    group_by(State) %>%
    summarise_each(funs = "mean(., na.rm=TRUE)") %>%
    left_join(., states, by = c("State" = "Abbreviation")) %>%
    mutate(region = str_to_lower(State.y.y))



### Mapping ----------
# create a data frame of map data for US states
us <- map_data("state")


# Plot a map of the US, coloured in according to the average % of ppl who get flu shots

ggplot() + 
    geom_map(data = us, map = us, aes(x=long, y=lat, map_id = region),
             fill = "#ffffff", color = "#ffffff", size = 0.15) + 
    geom_map(data = av.practice, map = us, 
             aes(fill = Getting.a.flu.shot.during.flu.season., map_id = region),
             color = "#ffffff", size = 0.15) + 
    scale_fill_gradientn(colours = c("#2b8cbe", "white", "#d7301f")) + 
    ggtitle("Getting a flu shot during flu season") +
    labs(x=NULL, y=NULL) +
    coord_map("albers", lat0 = 39, lat1 = 45) +
    theme(panel.border = element_blank(),
          panel.background = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5))


# Equivalent plot for depression screening

ggplot() + 
    geom_map(data = us, map = us, aes(x=long, y=lat, map_id = region),
             fill = "#ffffff", color = "#ffffff", size = 0.15) + 
    geom_map(data = av.practice, map = us, 
             aes(fill = Screening.for.depression.and.developing.a.follow.up.plan., map_id = region),
             color = "#ffffff", size = 0.15) + 
    scale_fill_gradientn(colours = c("#2b8cbe", "white", "#d7301f")) + 
    ggtitle("Screening for depression and developing a follow up plan") +
    labs(x=NULL, y=NULL) +
    coord_map("albers", lat0 = 39, lat1 = 45) +
    theme(panel.border = element_blank(),
          panel.background = element_blank(),
          axis.ticks = element_blank(),
          axis.text = element_blank(),
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5))














