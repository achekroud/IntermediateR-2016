#################################
### Intermediate & Advanced R ###
#################################

# Adam M Chekroud
# November 4th, 2016

###########################
##### Best Practices ######
###########################

# It is important to consider the readability of your code!

# Two extremely helpful resources:
#     - https://google.github.io/styleguide/Rguide.xml
#     - http://adv-r.had.co.nz/Style.html

# Brief examples from Hadley Wickham

# File names should be meaningful and end in .R.

# # Good
# fit-models.R
# utility-functions.R
# 
# # Bad
# test.r
# stuff_V1.r

# # If files need to be run in sequence, prefix them with numbers:
# 0-download.R
# 1-preprocess.R
# 2-plotting.R

# Function names should be:
#   - lowercase
#   - separated_by_underscores
#   - meaningful!

# # Good
# first_day
# 
# # Bad
# dayOne
# FirstDayOfTheMonth
# dm1

# Syntax

# Place spaces around all operators (=, +, -, <-, etc.)
#   Same applies when using = in function calls.
# Always put a space after a comma, and never before (just like in regular English).

# Good
average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad
average<-mean(feet/12+inches,na.rm=TRUE)

# Place a space before left parentheses, except in a function call.

# Good
if (debug) do(x)
plot(x, y)

# Bad
if(debug)do(x)
plot (x, y)

# Extra spacing (i.e., more than one space in a row) is ok if it improves alignment of assignments

list(
    total = a + b + c, 
    mean  = (a + b + c) / n
)


# Curly braces

# An opening curly brace should never go on its own line and should always be followed by a new line.
# A closing curly brace should always go on its own line, unless it's followed by else.

# Always indent the code inside curly braces.

# Good
if (y < 0 && debug) {
    message("Y is negative")
}

if (y == 0) {
    log(x)
} else {
    y ^ x
}

# Bad

if (y < 0 && debug)
    message("Y is negative")

if (y == 0) {
    log(x)
} 
else {
    y ^ x
}

# It's ok to leave very short statements on the same line:

if (y < 0 && debug) message("Y is negative")


# Line length

# Strive to limit your code to 80 characters per line. (fits on a printed page)
# If you find yourself running out of room, this is a good indication
#  that you should put some of the work into a separate function.

# Comments
#   Make extensive use of comments!
#   Comments should explain why, not how
#   Always start with # and a space
#   Consider commented lines of --- and === to divide sections

# ------------------

# There are loads of resources online to learn more advanced R programming!
# http://adv-r.had.co.nz is a helpful book
# These guidelines are especially important if you write a package, or work with collaborators

