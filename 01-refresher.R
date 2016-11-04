#################################
### Intermediate & Advanced R ###
#################################

# Adam M Chekroud
# November 4th, 2016

## download everything from github: git clone https://github.com/achekroud/IntermediateR-2016.git

# Open up R Studio
# Open up intermediate-R-2016.R from that folder:  File > Open script

# Setting your working directory tells R where you are on the computer
setwd("~/Desktop/IntermediateR-2016")

# Setting the seed ensures reproducibility of random sequences
set.seed(1)


###########################
##### Refresher ###########
###########################

###### Data Types


## Scalars & Vectors

# Scalars
a <- 1
b <- "B"
c <- TRUE

# Use class to see what type the object is
class(a)
class(b)
class(c)

# Vectors
x <- c(1,2,3,4,5)
x

# append some more elements to x
x <- c(x,6,7,8,9,10)
x

# concatenate vectors
xx <- c(x,x)
xx

# Colon creates a vector between integers, incrementing by 1
y <- 1:10
y

# You can go backwards
y1 <- 10:1
y1 

# Seq is a more generalized form
y2 <- seq(from = 1, to = 10, by = .5)
y2

# Vectors can also be created by repeating values
y3 <- rep(c(1,2), times = 5)
y3


# Vectors can contain non-numeric data types

# Like strings
z1 <- c("a", "b", "c", "d", "e")
z1

# Or Booleans
z2 <- y3 == 2
z2



## Indexing 

# randomly pick 10 numbers between 1 and 10, with replacement
x <- sample(1:10, size = 10, replace=T)
y <- sample(1:10, size = 10, replace=T)
x

# You can name elements of a vector
names(x) <- letters[1:10]

# You can index vectors numerically (by position)
x[1]
x[1:5]
x[10:6]
x[c(1,3,5)]

# You can index vectors by name too
x[c('a', 'c', 'e')]

# You can index vectors with logical expressions

# x where x is greater than 5
x[x>5]

# x where x is 1 or x is 2
x[x==1 | x==2]

# x where x is in the vector provided (1, 2)
x[x %in% c(1,2)]

# You can also index according to values from a different vector.

# x where y is greater than 5
x[y>5]

# You should be really careful about NAs when indexing
# put an NA at the end of x
x1 <- c(x, NA)
x1

# now ask for x1 where x1 is greater than 5
x1[x1>5]   # includes the NA!

# Use 'which' to avoid grabbing NAs accidentally
x1[which(x1>5)]

# You could also still use %in%
x1[x1 %in% c(1,2)]

# You can also grab the vector that isn't NA
x1[!is.na(x1)]

# You can also index an indexed vector
x[x>5][1:2] # first two elements of x where x is greater than 5


# Vector functions

# There are loads of functions that are applied to vectors
length(x)    # how long is the vector?
range(x)     # what are the range of values?
min(x)       # the minimum value?
max(x)       # the maximum value?
summary(x)   # descriptive/summary?

sort(x)      # sort my vector





## Matrices

# Make a matrix as follows
mat1 <- matrix(1:9, nrow = 3, ncol = 3)
mat1

# you can fill in the values by row rather than by column too
mat2 <- matrix(1:9, nrow = 3, ncol = 3, byrow=T)
mat2

# You can also build a matrix from vectors
# By combining rows
mat3 <- rbind(1:5, 6:10, 11:15)
mat3

# or by combining columns
mat4 <- cbind(1:5, 6:10, 11:15)
mat4

# You can name the rows and columns of matrices
mat5 <- cbind(mat4, mat4)

colnames(mat5)  <- paste("var",1:6, sep="")
row.names(mat5) <- paste("row",1:5, sep="")
mat5

# Indexing matrices
# You again use brackets [], but now you index [i,j] for row i and column j.

mat5[1,1]
mat5[5,6]

# To extract an entire row or an entire column, you can leave the other entry blank
# Column 3
mat5[,3]

# Row 3
mat5[3,]

# You can also slice multiple columns or rows at the same time
mat5[1:3,1:2] # rows 1 to 3, columns 1 to 2

# If you use matrices to model networks, you may want to create an adjacency matrix in which a '1' in row i, column j expresses a link between two nodes. You can use indexing to label a list of nodes

adj.mat <- matrix(0, nrow=10, ncol=10)

node1 <- sample(1:10, size = 30, replace=T)
node2 <- sample(1:10, size = 30, replace=T)

adj.mat[cbind(node1,node2)] <- 1
adj.mat

# There are many useful matrix commands, e.g.

dim(mat5)     # matrix dimensions?
ncol(mat5)    # how many columns?
nrow(mat5)    # how many rows?
head(mat5)    # top 6 rows?
tail(mat5)    # bottom 6 rows?

# Matrices can only include data of one class! 
# If you have one value that is a character, the entire matrix will change to character.
mat5[1,1] <- "a"
mat5

# Don't get burned




##  Lists
# These are collections of arbitrary set of R objects:
#    from vectors, matrices, strings, other lists, even regression results.
# They are one of the workhorse data types of R for this reason (e.g. collecting function outputs)
# They do not coerce the character of each object to be the same, unlike each vector in a matrix.
# They have a slightly different indexing scheme
x <- rnorm(50)
y <- rnorm(50)

# we can make a list of stuff, containing vectors, matrixes, even model outputs
stuff <- list(1:10, matrix(rnorm(9), 3, 3), letters[sample(1:26,26)], lm(y ~ x))

stuff

# always helpful to inspect the structure of a list, but complicated lists can get messy
str(stuff)
# at least know how long the list is 
length(stuff)

# You can name each slot on the list
names(stuff) <- letters[1:4]

# You can access objects from a list using the index number and [[ ]]
stuff[[1]]   # by position
stuff[[2]]
stuff[["a"]] # by name

# You can also use
stuff[1]
# but this will return a list of length 1
is.list(stuff[1])
is.list(stuff[[1]])

# This has important implications for what you can index
stuff[1][[1]][1:5]  # first list, first object of that list, first five elements of the vector
stuff[[1]][1:5]     # first object of the list, first five elements of the vector
stuff[1][1:5]       # first list, first five elements of the list [NB there is only 1 thing! returns 4 NAs]

stuff[1:5]          # first five list items
stuff[[1:5]]        # will fail to index recursively

# You can access objects in a list using names
stuff$a        # dollar operator
stuff[['b']]   # quoted name (first object)
stuff['b']     # quoted name (first list)
stuff[["b"]]   # single or double quotes fine

# You can also apply functions to lists

# lapply stands for list apply
# it will apply whatever function you want to each object in the list
lapply(stuff, class)  # what class is each item
lapply(stuff, length) # how long is each item

# You can make your own custom functions too
#  this one will extract the first thing from each object
lapply(stuff, function(x) return(x[1]) )

# There are easy extensions to this function that will take advantage of parallel processing! 
#  the parallel package contains a function called mclapply
#  take advantage of HPC workshops on parallel processing, or HPC office hours!



## Dataframes

# Dataframes are just lists where each object is a vector of the same length.
#     This allows you to create something that looks like a matrix, 
#     but each column can contain different types of data, like character, logical, or factors.

d <- data.frame(index=1:10, 
                outcome = rnorm(10), 
                id = paste('subject', 1:10, sep="."), 
                treatment = sample(c("T","C"), 10, replace=T), 
                stringsAsFactors=F)

d

# NB Factors store character values as numbers (a unique number for each unique string) and store the string as a label for that number. This can be very useful in some applications, but we won't dive into it today.

# Dataframes can be indexed using matrix notations

d[1,]                  # first row
d[,1:3]                # columns 1 to 3
d[,c("index", "id")]   # columns caled index and id

# you can also use the dollar operator
d$id

# or list notation
d[["treatment"]]
d[[4]]



## Loops

# For loops are simple
# Make a vector of 8 random normals, and loop along it printing each element
x = rnorm(8)
for (i in x){
    print(i)
}

# You can loop along any kind of vector
letters
# loop along the first 10 letters printing something

for (letter in letters[1:10]){
    print(paste(letter," & ", letter))
}

# Often, we want to loop across an index:
x = rnorm(10)
y = rnorm(length(x))

# for each element, subtract y from x
for (i in 1:length(x)){
    print(x[i] - y[i])
}

# NOTE-- objects created in loops cannot be accessed outside the loop
for (i in 1:length(x)){
    print(i)
    out = x[i] - y[i]
}
out
# you'll only get the object 'out' from the last iteration of the loop

# It is important to know when NOT to use a loop
x <- rnorm(10000)

# proc.time() determines how much real time (and CPU time) a process takes

# Grow the vector add.1
add.1 <- NULL
ptm <- proc.time()
for (i in 1:length(x)){
    add.1 <- c(add.1, x[i] + 1)
}
proc.time() - ptm

# You get the same result, much faster, if you pre-allocate the vector
add.2 <- rep(NA, length(x))
ptm <- proc.time()
for (i in 1:length(x)){
    add.2[i] <- x[i] + 1
}
proc.time() - ptm

identical(add.1, add.2)

# Vector operations are much better than loops, because someone good at coding did it for you
ptm <- proc.time()
add.3 <- x + 1
proc.time() - ptm

identical(add.1, add.3)


# You could sum a vector using a loop or a vector operation
total.1 <- 0
ptm <- proc.time()
for (i in 1:length(x)){
    total.1 <- total.1 + x[i]
}
proc.time() - ptm

ptm <- proc.time()
total.2 <- sum(x)
proc.time() - ptm

# Using apply (and related functions)
# Suppose we have a dataset with many columns, and we want to transform each column so that it is mean-zero.
sample.data <- matrix(NA, nrow = 10000, ncol = 500)

# generate some data
for (i in 1:ncol(sample.data)){
    sample.data[,i] <- rnorm(10000, mean=i, sd=1+log(i))
}

# We could write a loop to go through each column and make this transformation
new.data <- matrix(NA, nrow(sample.data), ncol(sample.data))

ptm <- proc.time()
for (i in 1:ncol(new.data)){
    column <- sample.data[,i]
    column.mean <- mean(sample.data[,i])
    new.data[,i] <-  column - column.mean
}
proc.time() - ptm

# Or we can use apply to loop across rows or columns
ptm <- proc.time()
new.data.2 <- apply(sample.data, 2, function(x) x - mean(x))
proc.time() - ptm

identical(new.data, new.data.2)

# Apply is sometimes faster than a loop. 
# It is often easier to write an apply function than it is to write out a simple loop.


## functions

# DRY principle -- Don't Repeat Yourself
# Use a function instead of writing out the same calculations over and over

# For instance, write a function to obtain the coefficients, SEs, and p-values from a regression model.

# Generate data
x = rnorm(100)
e = rnorm(100)
y = 3 + 2 * x + e

# and get the values we want
lm.1 = lm(y ~ x)
summary(lm.1)
summary(lm.1)$coefficients[,-3]

# But we can embed this in a function to avoid repeating these lines of code
lm.output = function(y, x){
    model = lm(y ~ x)
    coefs = summary(model)$coefficients
    return(coefs[,-3])
}

lm.output(y, x)
