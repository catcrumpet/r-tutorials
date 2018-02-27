# this is a comment

# install some packages
install.packages("tidyverse")
install.packages(c("nycflights13", "gapminder", "Lahman"))


# Most of this stuff is ripped off from the book. If you have any confusion
# about a section or want to practice, you can review it in the book.


# 4 Workflow: basics ------------------------------------------------------


# 4.1 Coding Basics -------------------------------------------------------
# You can use R as a calculator:

1 / 200 * 30
# You should get: [1] 0.15

(59 + 73 + 2) / 3
# You should get: [1] 44.7

sin(pi / 2)
# You should get: [1] 1

# You can create new objects with "<-":
x <- 3 * 4

# Type the name of the object to see its value:
x
# You should get: [1] 12


# 4.2 What’s in a name? ---------------------------------------------------
# These are all valid names using different naming conventions:
i_use_snake_case <- 1
otherPeopleUseCamelCase <- 2
some.people.use.periods <- 3
And_aFew.People_RENOUNCEconvention <- 4

# R is case-sensitive:
x <- 4 
# Is NOT the same as:
X <- 3
# Be careful!

# I recommend using "snake case":
  # 1. Use all lower case letters.
  # 2. Separate words with "_".
some_important_variable <- "cat"
another_important_variable <- "more cats"


# 4.3 Calling functions ---------------------------------------------------
# R has a large collection of built-in functions that are called like this:
# function_name(arg1 = val1, arg2 = val2, ...)

# Let's try using seq():
seq(1, 10)

# Assign the output of a function to a variable:
y <- seq(1, 10, length.out = 5)

# Look for help using "?"
?seq


# Extra things ------------------------------------------------------------
# You can remove objects from your workspace using rm()
rm(x)

# If you reference an object that doesn't exist, you will get an error. Try it:
x
# You should get: Error: object 'x' not found

# You can clear your entire workspace using the following code:
rm(list = ls())

# Use rm() with caution!


# 5 Data transformation ---------------------------------------------------


# 5.1.1 Prerequisites -----------------------------------------------------
# Load some packages. This only needs to be done once per session.
library(nycflights13)
library(tidyverse)


# 5.1.2 nycflights13 ------------------------------------------------------
flights

# 5.1.3 dplyr basics ------------------------------------------------------


# 5.2 Filter rows with filter() -------------------------------------------
# Select all flights on January 1st:
filter(flights, month == 1, day == 1)

# Same thing but capture the output as an object:
jan1 <- filter(flights, month == 1, day == 1)


# 5.2.1 Comparisons -------------------------------------------------------
# Comparison operators:
  # >  : less than
  # >= : less than or equal to
  # <  : greater than
  # <= : greater than or equal to
  # != : not equal to
  # == : equal to


# 5.2.2 Logical operators -------------------------------------------------
# Logical operators:
  # & : and
  # | : or
  # ! : not

# Find all flights that departed in November or December:
filter(flights, month == 11 | month == 12)

# Shorthand: %in% is "is in the set of"
nov_dec <- filter(flights, month %in% c(11, 12))

# The following two are the same:
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)


# 5.2.3 Missing values ----------------------------------------------------
# NA is missing. It has represents the absence of a value and has special
# properties and behaviors.

# All of the following should result in NA:
NA > 5
10 == NA
NA + 10
NA / 2

NA == NA

# Use is.na() to detect NAs:
x <- NA
is.na(x)
# You should get: [1] TRUE

# Some consequences for filtering data.
df <- tibble(x = c(1, NA, 3))

# Look at the data:
df

# filter() only includes rows where the condition is TRUE; it excludes both 
# FALSE and NA values. If you want to preserve missing values, ask for them 
# explicitly.

# Compare the results of:
filter(df, x > 1)
# To:
filter(df, is.na(x) | x > 1)


# 5.3 Arrange rows with arrange() -----------------------------------------
arrange(flights, year, month, day)

# Use desc() to re-order by a column in descending order:
arrange(flights, desc(arr_delay))

# Missing data and arrange().
# Missing values are always sorted at the end:
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))


# 5.4 Select columns with select() ----------------------------------------
# Select columns by name
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
select(flights, year:day)

# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

# There are a number of helper functions you can use within select():
  # starts_with("abc"): matches names that begin with “abc”.
  # ends_with("xyz"): matches names that end with “xyz”.
  # contains("ijk"): matches names that contain “ijk”.
  # matches("(.)\\1"): selects variables that match a regular expression.
    # This is more advanced, and we will cover it if there is time and interest.
  # num_range("x", 1:3) matches x1, x2 and x3.

# You can use select() to rename variables:
select(flights, cat_year = year, cat_day = day)

# But rename() is a bit more convenient for renaming:
rename(flights, cat_year = year, cat_day = day)
# Compare this with the previous select() statement.

# Another option is to use select() in conjunction with the everything() helper. 
# This is useful if you have a handful of variables you’d like to move to the 
# start of the data frame.
select(flights, time_hour, air_time, everything())


# 5.5 Add new variables with mutate() -------------------------------------
# You can break code across lines like this:
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)

# Note that you can refer to columns that you’ve just created:
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

# If you only want to keep the new variables, use transmute():
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)


# 5.5.1 Useful creation functions -----------------------------------------
# Arithmetic operators: 
  # + : add          1 + 2 = 3
  # - : subtract     1 - 5 = -4
  # * : multiply     2 * 3 = 6
  # / : divide       4 / 2 = 2
  # ^ : exponentiate 2 ^ 3 = 8

# Modular arithmetic: 
  # %/% : integer division 7 %/% 5 = 1
  # %%  : remainder        7 %% 5 = 2

# Logs: 
  # log()   : natural logarithm log(10) ~ 2.718282
  # log2()  : base 2 logarithm  log2(8) = 3
  # log10() : base 10 logarithm log10(100) = 2

# Offsets: 
  # lead() : find the n leading value
  # lag()  : find the n lagging value
x <- 1:10
x
lag(x)
lead(x)
lag(x, n = 2)
lead(x, n = 2)
lag(x, n = 2, default = 0)

# Cumulative and rolling aggregates: 
  # cumsum()  : running sum
  # cumprod() : running product
  # cummin()  : running min
  # cummax()  : running max
  # cummean() : running mean
cumsum(x)
cummean(x)
# If you need rolling aggregates (i.e. a sum computed over a rolling window), 
# try the RcppRoll package.

# Logical comparisons (see above)

# Ranking: 
  # min_rank()     : equivalent to rank(ties.method = "min")

  # The following are a bit more advanced:
  # row_number()   : equivalent to rank(ties.method = "first")
  # ntile()        : a rough rank, which breaks the input vector into n buckets.
  # dense_rank()   : like min_rank(), but with no gaps between ranks
  # percent_rank() : a number between 0 and 1 computed by rescaling min_rank to [0, 1]
  # cume_dist()    : a cumulative distribution function. Proportion of all values less than or equal to the current rank.

y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
# Go largest to smallest using desc():
min_rank(desc(y))

row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)


# 5.6 Grouped summaries with summarise() ----------------------------------
# summarise() collapses a data frame to a single row:
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
# Notice the na.rm? That's important here. We'll find out why later.

# group_by() changes the unit of analysis from the complete dataset to 
# individual groups. 
by_day <- group_by(flights, year, month, day)

# Notice the second line in the output starting with "Groups":
by_day

# Now we can summarise the data by groups.
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# This is just a preview of grouping and summarising. We will continue with
# these topics next session.
