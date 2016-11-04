#################################
### Intermediate & Advanced R ###
#################################

# Adam M Chekroud (adapted from Edwin Chen @edchedch)
# November 4th, 2016

###########################
##### Plotting ############
###########################


# install.packages("ggplot2")

library(ggplot2)

## Scatterplots with qplot()

# Let's look at how to create a scatterplot in ggplot2. We'll use the `iris` data frame that's automatically loaded into R.

# What does the data frame contain? We can use the `head` function to look at the first few rows.

head(iris)         # by default, head displays the first 6 rows
head(iris, n = 10) # we can also explicitly set the number of rows to display

# (The data frame actually contains three types of species: setosa, versicolor, and virginica.)

# Let's plot `Sepal.Length` against `Petal.Length` using ggplot2's `qplot()` function.

qplot(Sepal.Length, Petal.Length, data = iris)
# Plot Sepal.Length vs. Petal.Length, using data from the `iris` data frame.

# To see where each species is located in this graph, we can color each point by adding a `color = Species` argument.

qplot(Sepal.Length, Petal.Length, data = iris, color = Species) # dude!

# Similarly, we can let the size of each point denote sepal width, by adding a `size = Sepal.Width` argument.

qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width)
# We see that Iris setosa flowers have the narrowest petals.

qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width, alpha = I(0.7))
# By setting the alpha of each point to 0.7, we reduce the effects of overplotting.

# Finally, let's fix the axis labels and add a title to the plot.

qplot(Sepal.Length, Petal.Length, data = iris, color = Species,
      xlab = "Sepal Length", ylab = "Petal Length", 
      main = "Sepal vs. Petal Length in Fisher's Iris data")

## Other common geoms

# In the scatterplot examples above, we implicitly used a *point* **geom**, the default when you supply two arguments to `qplot()`.

# These two invocations are equivalent.
qplot(Sepal.Length, Petal.Length, data = iris, geom = "point")
qplot(Sepal.Length, Petal.Length, data = iris)

#But we can easily use other types of geoms to create other kinds of plots.

### Barcharts: geom = "bar"

movies = data.frame(
    director = c("spielberg", "spielberg", "spielberg", "jackson", "jackson"),
    movie = c("jaws", "avatar", "schindler's list", "lotr", "king kong"),
    minutes = c(124, 163, 195, 600, 187)
)

# Plot the number of movies each director has.
qplot(director, data = movies, geom = "bar", ylab = "# movies")
# By default, the height of each bar is simply a count.

# But we can also supply a different weight.
# Here the height of each bar is the total running time of the director's movies.
qplot(director, weight = minutes, data = movies, geom = "bar", ylab = "total length (min.)")

### Line charts: geom = "line"

qplot(Sepal.Length, Petal.Length, data = iris, geom = "line", color = Species) 
# Using a line geom doesn't really make sense here, but hey.

# `Orange` is another built-in data frame that describes the growth of orange trees.
qplot(age, circumference, data = Orange, geom = "line",
      colour = Tree,
      main = "How does orange tree circumference vary with age?")

# We can also plot both points and lines.
qplot(age, circumference, data = Orange, geom = c("point", "line"), colour = Tree)