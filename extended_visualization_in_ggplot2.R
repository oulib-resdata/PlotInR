# title: Visualization in R with 'ggplot2'
# author: Data Carpentry contributors (www.datacarpentry.org) +
# modified by Claire M. Curry (OU Libraries - cmcurry@ou.edu) 
# under CC BY 4.0 and MIT licenses for instructional materials and software

# minutes: 150

# > ### Learning Objectives
# 
# > * Overall: Build complex and customized plots from data in a data frame.
# > * Produce appropriate plot types for your data
#       * Create multiple types of plots: Produce scatter plots, boxplots,
#         violin plots, and time series plots using ggplot.
# >     * Add measures of variation and summaries to plots.
# >     * Describe what faceting is and apply faceting in ggplot.
# > * Produce clear and accessible aesthetics and labels for your plot
#       * Modify the aesthetics of an existing ggplot plot
#         (including axis labels and color), focusing on
#         accessibility (colorblind palettes, using shapes and 
#         line types, changing font size)
#         and clarity (removing grids)
#       * Add and modify annotations and legends for clarity.

# We start by loading the required packages. 
# **`ggplot2`** is included in the **`tidyverse`** package.
# You may need to install **`tidyverse`** or **`RColorBrewer`** 
# if you did not do so before the workshop.


library(tidyverse)
library(RColorBrewer)
library(datasets)

# We will be using datasets included in base R and various packages to practice plotting today.

# ## Plotting with **`ggplot2`**
# 
# **`ggplot2`** is a plotting package that makes it simple to create complex plots
# from data in a data frame. It provides a more programmatic interface for
# specifying what variables to plot, how they are displayed, and general visual
# properties. Therefore, we only need minimal changes if the underlying data change
# or if we decide to change from a bar plot to a scatter plot. This helps in creating
# publication quality plots with minimal amounts of adjustments and tweaking.
# 
# **`ggplot2`** functions like data in the 'long' format, i.e., a column for every dimension,
# and a row for every observation. Well-structured data will save you lots of time
# when making figures with **`ggplot2`**
# 
# ggplot graphics are built step by step by adding new elements. Adding layers in
# this fashion allows for extensive flexibility and customization of plots.
# 
# To build a ggplot, we will use the following basic template that can be used for different types of plots:
# 
# 
# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()

# 
# - use the `ggplot()` function and bind the plot to a specific data frame using the
#       `data` argument
# 

# Please note today that we will be using built-in datasets.
# They will not appear in the environment
# and can only be loaded with certain packages.

ggplot(data = diamonds)


# - define a mapping (using the aesthetic (`aes`) function), by selecting the variables to be plotted and specifying how to present them in the graph, e.g. as x/y positions or characteristics such as size, shape, color, etc.


ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price))

# 
# - add 'geoms' - graphical representations of the data in the plot (points,
#   lines, bars). **`ggplot2`** offers many different geoms; we will use some 
#   common ones today, including:
#   
#       * `geom_point()` for scatter plots, dot plots, etc.
#       * `geom_boxplot()` for, well, boxplots!
#       * `geom_line()` for trend lines, time series, etc.  

# To add a geom to the plot use the `+` operator. Because we have two continuous variables,
# let's use `geom_point()` first:


ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price)) +
  geom_point()


# The `+` in the **`ggplot2`** package is particularly useful because it allows you
# to modify existing `ggplot` objects. This means you can easily set up plot
# templates and conveniently explore different types of plots, so the above
# plot can also be generated with code like this:


# Assign plot to a variable
diamonds_plot <- ggplot(data = diamonds,
                       mapping = aes(x = carat,
                                     y = price))
# note it doesn't print since it's assigned to an object.

# Draw the plot
diamonds_plot + 
    geom_point()

# 
# **Notes**
# 
# - Anything you put in the `ggplot()` function can be seen by any geom layers
#   that you add (i.e., these are universal plot settings). This includes the x- and
#   y-axis mapping you set up in `aes()`.
# - You can also specify mappings for a given geom independently of the
#   mappings defined globally in the `ggplot()` function.
# - The `+` sign used to add new layers must be placed at the end of the line containing
# the *previous* layer. If, instead, the `+` sign is added at the beginning of the line
# containing the new layer, **`ggplot2`** will not add the new layer and will return an 
# error message.
# 
# # This is the correct syntax for adding layers
diamonds_plot +
  geom_point()
# 
# # This will not add the new layer and will return an error message
diamonds_plot
+ geom_point()



# ## Building your plots iteratively
# 
# Building plots with **`ggplot2`** is typically an iterative process. We start by
# defining the dataset we'll use, lay out the axes, and choose a geom:

diamonds_plot +
    geom_point()

# 
# Then, we start modifying this plot to extract more information from it. For
# instance, we can add transparency (`alpha`) to avoid overplotting:


diamonds_plot +
    geom_point(alpha = 0.1)


# We can also add colors for all the points:
diamonds_plot+
    geom_point(alpha = 0.1,
               color = "blue")


# To color groups in the plot differently, 
# you could use a vector as an input to the argument **color**. 
# **`ggplot2`** will provide a different color corresponding to 
# different values in the vector. Here is an example where we 
# color with **`cut`**, a categorical variable:
# Reminder: a vector is a type of object in R.

diamonds_plot +
    geom_point(alpha = 0.1, 
               aes(color = cut))


# We can also specify the aesthetics directly inside 
# the mapping provided in the `ggplot()` function. 
# This will be seen by any geom layers and the mapping 
# will be determined by the x- and y-axis set up in `aes()`.
# Here we'll use a **different dataset** and change another aes
# called shape.
ggplot(data = airquality, 
       mapping = aes(x = Ozone,
                     y = Wind,
                     shape = as.factor(Month))) +
    geom_point()


# Notice that we can change the shape to the geom layer
# will be still determined by **`Month`**
ggplot(data = airquality, 
       mapping = aes(x = Ozone,
                     y = Wind)) +
  geom_point(aes(shape = as.factor(Month)))

# > ### Challenge
# >
# > Use what you just learned to create a scatter plot in the diamonds dataset
# of `price` as the  y axis and `cut` as the x-axis,
# Is this a good way to show this type of data?

ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
    geom_point()


# ## Boxplot
# A more appropriate way to visualize data in categories is boxplots.
# Boxplots show medians, quartiles, and outliers.
# Let's use boxplots to visualize the distribution of price within 
# each cut of diamond:

ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_boxplot()

# By adding points to boxplot, we can have a better idea of the number of
# measurements and of their distribution:

ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
    geom_boxplot(alpha = 0) +
    geom_jitter(alpha = 0.3, 
                color = "tomato")

# Challenge
# Notice how the boxplot layer is behind the jitter layer? What do you need to
# change in the code to put the boxplot in front of the points such that it's not
# hidden?
ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_jitter(alpha = 0.3, 
              color = "tomato") +
  geom_boxplot(alpha = 0)

## Challenge with boxplots:
##  Start with the boxplot we created:
ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, 
              color = "tomato")

##  1. Replace the box plot with a violin plot; see `geom_violin()`.
ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_violin(alpha = 0)

##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_violin()+
  scale_y_log10()
# You will note that it doesn't change the label on the y axis to reflect the log transform.
# Later we will change y-axis labels!

##  3. Create boxplot for `price` and `cut` overlaid on a jitter layer.
ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_jitter(color = "black",
              alpha = 0.5)+
  geom_boxplot(alpha = 0.5)

##  4. Add color to the data points on your boxplot according to the
##  color of the diamond (`color`).
## Note that color is both an argument in geom
## and is a COLUMN in diamonds.
ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     y = price)) +
  geom_jitter(color = "black",
              alpha = 0.5)+
  geom_boxplot(alpha = 0.9,
               aes(fill = color))


# ## Plotting time series data
# 
# Let's calculate number of records per month for airquality. First we need
# to group the data and count records within each group:

count_timeseries <- ChickWeight %>%
                 count(Time, Diet)

# 
# Time series data can be visualized as a line plot with days
# on the x axis and counts on the y axis:
ggplot(data = count_timeseries, 
       mapping = aes(x = Time,
                     y = n)) +
     geom_line()


# Unfortunately, this does not work because we plotted data for all the diets
# together. We need to tell ggplot to draw a line for each diets by modifying
# the aesthetic function to include `group = Diet`:

ggplot(data = count_timeseries, 
       mapping = aes(x = Time, 
                     y = n,
                     group = Diet)) +
    geom_line()


# We will be able to distinguish diets in the plot
# if we add colors (using `color` also automatically groups the data):
ggplot(data = count_timeseries,
       mapping = aes(x = Time,
                     y = n,
                     color = Diet)) +
    geom_line()


# ## Add measures of variation and summaries to your plots
# You can manually summarize your data as we did above,
# OR you could use the stat argument in geom_line.
ggplot(data = ChickWeight,
       mapping = aes(x = Time,
                     color = Diet)) +
  geom_line(stat = "count")

#geom and stat work very similarly as you can see by this
# identical plot as previously.

#Other summary statistics are also available.
ggplot(ChickWeight,
       aes(x = Time,
           y = weight,
           color = Diet)) +
  geom_point(stat='summary', 
             fun.y=mean)


# It's related to the stat_summary() layer that we'll try next. 
# Here we'll summarize means and standard deviations 
# for one continuous variable and one categorical variable.
ggplot(ChickWeight,
       aes(x = Time,
           weight,
           color = Diet)) +
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)})+
  stat_summary(geom = "point",
               fun.y = mean,
               size = 5)



# We can fix the overlap by setting displacement width
# We'll make sure both the point and the error bars match up.
dodge_width_for_diets <- 0.9

ggplot(ChickWeight,
       aes(x = Time,
           weight,
           color = Diet)) +
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)},
               position = position_dodge(width = dodge_width_for_diets))+
  stat_summary(geom = "point",
               fun.y = mean,
               size = 5,
               position = position_dodge(width = dodge_width_for_diets))

# This example shows we can add multiple summaries using group.
ggplot(data = ChickWeight,
       mapping = aes(y = weight,
                     x = Diet)) +
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)})+
  stat_summary(geom = "point",
               fun.y = mean,
               size = 5)+
  stat_summary(data = ChickWeight,
               mapping = aes(y = weight,
                             x = Diet,
                             group = as.factor(Chick)),
               geom = "point",
               fun.y = mean)+
  labs(x = "Diet",
       y = "Weight")


# This is just a brief introduction to the changes you can do
# with stat and stat_summary.  What to do will depend on your
# plotting needs.

# ## Faceting
# 
# **`ggplot2`** has a special technique called *faceting* that allows the user to split one
# plot into multiple plots based on a factor included in the dataset. We will use it to
# make a time series plot for each diet in ChickWeights:
# We'll take the previous color-based plot and add a layer called
# facet wrap.
ggplot(data = ChickWeight,
       mapping = aes(x = Time,
                     color = Diet)) +
  geom_line(stat = "count")+
  facet_wrap(~ Diet)

#Remove color = Diet to remove this extra piece of info.
ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count")+
  facet_wrap(~ Diet)

# The `facet_wrap` geometry extracts plots into an arbitrary number of dimensions
# to allow them to cleanly fit on one page. On the other hand, the `facet_grid`
# geometry allows you to explicitly specify how you want your plots to be
# arranged via formula notation (`rows ~ columns`; a `.` can be used as
# a placeholder that indicates only one row or column).
# 
# Let's modify the previous plot to compare how the weights on different diets
# have changed through time:

  
# One column, facet by rows
ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count")+
  facet_grid(. ~ Diet)



# One row, facet by column
ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count")+
  facet_grid(Diet ~ .)


# ## Customizing the appearance for accessibility and clarity
# 
# Usually plots with white background look more readable when printed.
# We can set the background to white using the function `theme_bw()`.
# Additionally, you can remove the grid:
ggplot(data = diamonds, 
       mapping = aes(x = carat,
                     y = price,
                     color = cut)) +
  geom_point()+
  theme_bw() +
  theme(panel.grid = element_blank())


# In addition to `theme_bw()`, which changes the plot background to white, **`ggplot2`**
# comes with several other themes which can be useful to quickly change the look
# of your visualization. The complete list of themes is available
# at <https://ggplot2.tidyverse.org/reference/ggtheme.html>. `theme_minimal()` and
# `theme_light()` are popular, and `theme_void()` can be useful as a starting
# point to create a new hand-crafted theme.
# 
# The [ggthemes](https://jrnold.github.io/ggthemes/reference/index.html) package
# provides a wide variety of options (including an Excel 2003 theme).
# The [**`ggplot2`** extensions website](https://www.ggplot2-exts.org) provides a list
# of packages that extend the capabilities of **`ggplot2`**, including additional
# themes.

# ## Changing color and shape aesthetics using scale_*_
# 
# Another layer to add to our plot is aesthetic scaling using variations on 
# scale_*_continuous(), scale_*_discrete(), and scale_*_manual(values=c()).
# (More options are shown on the cheatsheet.)  The asterisk is replaced with the aes()
# you need to use, such as fill, color, or shape.

diamond_carat_price_plot <- ggplot(data = diamonds, 
                            mapping = aes(x = carat,
                                          y = price,
                                          color = cut)) +
  geom_point()+
  theme_bw() +
  theme(panel.grid = element_blank())

diamond_carat_price_plot + 
  scale_color_brewer(palette = "Blues")

# To show all palette choices:
RColorBrewer::display.brewer.all()

# This doesn't help guide us for colorblind accessibility,
# but there is argument to specify this.

RColorBrewer::display.brewer.all(colorblindFriendly = TRUE)

# You can also specify the type of color set you want.
# "div" (diverging color gradients with pale area in middle of range),
# "qual" (qualitative that do not imply magnitude changes),
# "seq" (sequences from low to high values),
# or "all" (which is default)

RColorBrewer::display.brewer.all(type = "qual",
                                 colorblindFriendly = FALSE)
RColorBrewer::display.brewer.all(type = "qual",
                                 colorblindFriendly = TRUE)

# If you'd like to go directly to printing in black and white (or consider your readers
# may print a paper out in black-and-white to read), there is a scale for that.

diamond_carat_price_plot + 
  scale_color_grey(start = 0.2, end = 0.8, na.value = "red")


# Using shapes or line types instead of colors to distinguish among values can also make figures
# more accessible or easier to read in black-and-white.  Let's go back to our weight and length 
# plot.  Let's try to distinguish among plot types.


# We'll save the main plot as an object so we don't have to retype it to test each aes().

# Let's first test using default colors.
diamond_carat_price_plot
# And then with RColorBrewer for a colorblind accessible palette.
RColorBrewer::display.brewer.all(type = "seq",
                                 colorblindFriendly = TRUE)

diamond_carat_price_plot +
  scale_color_brewer(palette = "YlGnBu")

#Let's check the automated shapes.
ggplot(data = diamonds, 
       mapping = aes(x = carat,
                     y = price,
                     color = cut,
                     shape = cut,
                     size = 5)) +
    geom_point()
  
# We can now distinguish among the plot types regardless of color printing or color-related visual impairments, making the plot easier for all readers.  This principle is called [**universal design**](https://en.wikipedia.org/wiki/Universal_design).
# ?pch will show you all shapes as does the ggplot2 cheatsheet.
# Additional information on making visualizations accessible
# can be found at <https://a11yproject.com/checklist#color-contrast>.

# ## Changing the axis and axis label font sizes and angle

# Now, let's change names of facet labels and axis titles.

# First, remember this plot?
# One column, facet by rows
ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count")+
  facet_grid(. ~ Diet)

#The facet labels are not informative, so we use a labeller function
# add the variable name.  You can also write your own labeller function,
# but that is beyond the scope of this workshop.

ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count")+
  facet_grid(. ~ Diet,
             labeller = label_both)

# Here we give the axes have more informative names. 
ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count") +
  facet_grid(. ~ Diet,
             labeller = label_both) +
  theme_bw() +
  theme(panel.grid = element_blank())+
  labs(title = "Sample size of chicks during diet experiment",
       x = "Time of observation",
       y = "Number of individuals") +
  theme_bw()

# Note that it is also possible to change the fonts of your plots. If you are on
# Windows, you may have to install
# the [**`extrafont`** package](https://github.com/wch/extrafont), and follow the
# instructions included in the README for this package.

# ### Challenge
# 
# Let's change the orientation of the labels
# and adjust them vertically and horizontally 
# so they don't overlap if they are longer. 
# (Ours are short but longer names would be a problem.)
# * Use help for element_text to find the argument to adjust the text angle.
# * You can use a 90-degree angle, or experiment to find the appropriate angle.

ggplot(data = ChickWeight,
       mapping = aes(x = Time)) +
  geom_line(stat = "count") +
  facet_grid(. ~ Diet,
             labeller = label_both)+
  labs(title = "Sample size of chicks during diet experiment",
       x = "Time of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(text = element_text(size = 16),
        axis.text.x = element_text(colour = "grey80",
                                     size = 12,
                                     angle = 45,
                                     hjust = 0.5, 
                                     vjust = 0.5),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5))

# ## Customize legends and add text for clarity

# You can change the default value of the legend title.
ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price,
                     color = cut)) +
  geom_point() +
  labs(x = "Carats",
       y = "Price") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16))+
  guides(color=guide_legend(title="Quality of cut"))+
  scale_color_brewer(type = "seq", palette = 18)

# an equally valid way to change it.
ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price,
                     color = cut)) +
  geom_point() +
  labs(x = "Carats",
       y = "Price") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16))+
  scale_color_brewer(type = "seq",
                     palette = 18,
                     name = "Quality of cut")

# Or in labs().
ggplot(data = diamonds,
       mapping = aes(x = carat,
                     y = price,
                     color = cut)) +
  geom_point() +
  labs(x = "Carats",
       y = "Price",
       color = "Quality of cut") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16))+
  scale_color_brewer(type = "seq",
                     palette = 18)


# In this plot, we could show individuals in the legend.
ggplot(data = ChickWeight,
       mapping = aes(x = Time,
                     y = weight,
                     color = as.factor(Chick))) +
  geom_line() +
  labs(x = "Observation time",
       y = "Weight") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16))

# However, what we want is to connect individuals so readers
# can see trends, but the identity of individual chicks is not 
# relevant.  We'll remove the legend.
ggplot(data = ChickWeight,
       mapping = aes(x = Time,
                     y = weight,
                     color = as.factor(Chick))) +
  geom_line() +
  labs(x = "Observation time",
       y = "Weight") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16),
        legend.position = "none")

# Or, you may need the legend, but it needs better labels.
ggplot(data = MASS::snails,
       mapping = aes(x = Species,
                     y = Deaths,
                     fill = as.factor(Exposure))) +
  geom_boxplot() +
  labs(x = "Experimental Species",
       y = "Count of snail deaths") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16))+
  scale_fill_grey(labels = c("One week",
                               "Two weeks",
                               "Three weeks",
                               "Four weeks"),
                    name = "Exposure")

# Next we'll add text to graphs.
# Perhaps you have a point graph where you want values as symbols or to add labels.
ggplot(data = airquality,
       mapping = aes(x = Wind,
                     y = Ozone,
                     color = Temp)) +
  geom_text(label = as.factor(airquality$Month)) +
  labs(x = "Wind",
       y = "Ozone") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16))

# You can also use geom_text() to add labels.  Here we use labels instead of colors in a legend.
# group instead of color or fill is used to get summaries for the different categories.
# This example dataset we will call directly without loading
# its library (`boot`).  To do this we put the library name
# with two colons, followed by the dataset name.

ggplot(data = boot::poisons,
       mapping = aes(x = treat,
                     y = time,
                     group = poison)) +
  geom_point(stat = "summary",
             fun.y = mean)+
  geom_text(stat = "summary",
            fun.y = mean,
            nudge_x = 0.1,
            aes(label = boot::poisons$poison)) +
  labs(x = "Treatment",
       y = "Animal survival time") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16),
        legend.position = "none")

# Finally, you can add individual text items to plots
# using another layer function called annotate().
# Again we have to call the dataset from its library directly.
ggplot(data = boot::poisons,
       mapping = aes(x = treat,
                     y = time,
                     group = poison)) +
  geom_point(stat = "summary",
             fun.y = mean)+
  geom_text(stat = "summary",
            fun.y = mean,
            nudge_x = 0.1,
            aes(label = boot::poisons$poison)) +
  geom_hline(yintercept = 0.5)+
  annotate(geom = "text",   
#note this uses a text geom - you could also add line segments or points.
           x=0.5,
           y=0.525,
           hjust = "left",
           label="Survival time within range")+
  labs(x = "Treatment",
       y = "Animal survival time") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16),
        legend.position = "none")


# ## Saving your theme customizations
# If you like the changes you created better than the default theme, you can save them as
# an object to be able to easily apply them to other plots you may create:
# 

presentation_theme <-  theme(text = element_text(size = 16),
        axis.text.x = element_text(colour = "black",
                                   size = 20,
                                   hjust = 0.5, 
                                   vjust = 0.5),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5))

ggplot(data = boot::poisons,
       mapping = aes(x = treat,
                     y = time,
                     group = poison)) +
  geom_point(stat = "summary",
             fun.y = mean)+
  geom_text(stat = "summary",
            fun.y = mean,
            nudge_x = 0.1,
            aes(label = boot::poisons$poison)) +
  geom_hline(yintercept = 0.5)+
  annotate(geom = "text",   
           #note this uses a text geom - you could also add line segments or points.
           x=0.5,
           y=0.525,
           hjust = "left",
           label="Survival time within range")+
  labs(x = "Treatment",
       y = "Animal survival time") +
  theme_bw()+
  presentation_theme

#Note it doesn't require the () here because presentation_theme
# is an object, not a function.

# ## Arranging and exporting plots
# Faceting is a great tool for splitting one plot into multiple plots, 
# but sometimes you may want to produce a single figure that contains 
# multiple plots using different variables or even different data frames.
# The **`gridExtra`** package allows us to combine separate ggplots into a single
# figure using `grid.arrange()`:

install.packages("gridExtra")
library(gridExtra)

individual_weight_boxplot <- ggplot(data = ChickWeight,
                             mapping = aes(x = Time,
                                           y = weight,
                                           color = as.factor(Chick))) +
  geom_line() +
  labs(x = "Observation time",
       y = "Individual Weight") +
  theme_bw()+
  theme(axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        text = element_text(size = 16),
        legend.position = "none")

dodge_width_for_diets <- 0.9
diet_means_sd_plot <- ggplot(ChickWeight,
       aes(x = Time,
           weight,
           color = Diet)) +
  labs(y = "Mean and sd weights")+
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)},
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)},
               position = position_dodge(width = dodge_width_for_diets))+
  stat_summary(geom = "point",
               fun.y = mean,
               size = 5,
               position = position_dodge(width = dodge_width_for_diets))+
  theme_bw()+
  presentation_theme


grid.arrange(diet_means_sd_plot,
             individual_weight_boxplot,
             ncol = 2, 
             widths = c(6, 4))

# In addition to the `ncol` and `nrow` arguments, used to make simple arrangements,
# there are tools for constructing more complex layouts at
# https://cran.r-project.org/web/packages/gridExtra/vignettes/arrangeGrob.html .
# 
# After creating your plot, you can save it to a file in your favorite format.
# The Export tab in the **Plot** pane in RStudio will save your plots at low resolution,
# which will not be accepted by many journals and will not scale well for posters. 
# 
# Instead, use the `ggsave()` function, which allows you easily change the dimension
# and resolution of your plot by adjusting the appropriate arguments (`width`, `height`,
# and `dpi`). 
# 
# Make sure you create the `fig_output/`
# folder in your working directory first.

ggsave("fig_output/diet_means_sd_plot.png",
       diet_means_sd_plot,
       width = 15,
       height = 10)

# This also works for grid.arrange() plots.
# Note that specifying the extension changes the file type saved.
# check ?ggsave to see the other extensions you can use listed under the device argument.
combo_plot <- grid.arrange(diet_means_sd_plot,
                        individual_weight_boxplot,
                        ncol = 2, 
                        widths = c(6, 4))
# Note that you don't need dpi for vector outputs like pdf, svg, or eps.
ggsave("fig_output/combo_plot_chick_weight.pdf",
       combo_plot, 
       width = 10)


# Note: The parameters `width` and `height` also determine the 
# font size in the saved plot.

# This wraps up our tour of editing plots in ggplot2.  
# There are so many more things you can do as needed for
# presentations or manuscripts.  Please feel free to reach out 
# to me or a DAVIS information specialist for additional help with R.