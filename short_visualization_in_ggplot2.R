# title: Visualization in R with 'ggplot2'
# author: Data Carpentry contributors (www.datacarpentry.org) +
# modified by Claire M. Curry (OU Libraries - cmcurry@ou.edu) 
# under CC BY 4.0 and MIT licenses for instructional materials and software

# minutes: 75

# > ### Learning Objectives
# > * Understand the ggplot syntax of layers and geoms to build plots,
# >   with an emphasis on using the help/documentation to understand 
# >   the extensive customization options.
# > * Find appropriate plot types for your data
#       * Create density plots and boxplots
# > * Produce effective, accessible plots for your data
#       * Modify the aesthetics, labels, and theme of an existing ggplot plot,
#         focusing on accessibility (colorblind palettes, using shapes and 
#         line types together, changing font size, removing extraneous lines)
# >     * Add measures of variation and summaries to plots TBD
# >     * Apply faceting or geom_line() to plots in datasets with groupings TBD

# We start by loading the required packages. 
# **`ggplot2`** and **`dplyr` are included in the **`tidyverse`** package.
# You may need to install **`tidyverse`** or **`RColorBrewer`** 
# if you did not do so before the workshop.
# We will be using a dataset included in ggplot2 to practice plotting today.


library(ggplot2)
library(dplyr)
library(RColorBrewer)


#####################
# Plotting with **`ggplot2`**: understanding the syntax
#####################
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
# If you wanted to save any of these images in vector or raster formats,
# there are several functions to do this, but a common one is 
# [`ggsave()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.6/topics/ggsave).


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
# mpg comes with the ggplot2 package.
data(mpg)

#This will appear in your environment tab as <promise>
# The first time you use it, the full dataset will appear.
ggplot(data = mpg)
head(mpg)

# - define a mapping (using the aesthetic (`aes`) function),
# by selecting the variables to be plotted and specifying 
# how to present them in the graph, e.g. as x/y positions 
# or characteristics such as size, shape, color, etc.

ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy))

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


ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy)) +
  geom_point()

# Thus, building plots with **`ggplot2`** is typically an iterative process.
# We start by
# defining the dataset we'll use, lay out the axes, and choose a geom.

# **Notes, usually no time to cover, but explain if asked**
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
# # This is the correct syntax for adding layers (same plot as above)
ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy)) +
  geom_point()
# 
# # This will not add the new layer and will plot empty plot, then return an error message
ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy)) 
+ geom_point()


# Next, we start modifying this plot to extract more information from it. For
# instance, we can add transparency (`alpha`) to avoid overplotting and colors to match
#any color scheme you might have in a presentation:


ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy)) +
  geom_point(alpha = 0.1,
             color = "blue")


# To color groups in the plot differently, 
# you could use a vector as an input to the argument **color**. 
# **`ggplot2`** will provide a different color corresponding to 
# different values in the vector. Here is an example where we 
# color with **`drv`**, a categorical variable:
# Reminder: a vector is a type of object in R.

ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy,
                     color = drv))+
  geom_point()


# We can also specify the aesthetics directly inside 
# the mapping provided in the `ggplot()` function. 
# This will be seen by any geom layers and the mapping 
# will be determined by the x- and y-axis set up in `aes()`.
# Here we'll use change another aes
# called shape.
# Using shapes or line types in addition to colors to distinguish among values can also make figures
# more accessible or easier to read in black-and-white.

ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy,
                     color = drv,
                     shape = drv))+
  geom_point()



# Notice that we can change the aes to be located in the geom layer
# and it will be still work.  This can be used to layer several plots,
# which we'll do later.
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ,
                           y = hwy,
                           color = drv,
                           shape = drv))


# You can read more about the "grammar of graphics" approach taken by 
# ggplot2 here: https://ggplot2-book.org/mastery.html .

#####################
# Finding appropriate plot types
#####################

# > ### Challenge
# >
# > Use what you just learned to create a scatter plot in the mpg dataset
# of `hwy` (miles per gallon) as the  y axis and `drv` as the x-axis,
# Is this a good way to show this type of data?

ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_point(alpha = 0.1)

# geom_point is what Wickham et al call an "individual geom" https://ggplot2-book.org/individual-geoms.html
# It shows every data point. We'll continue using geom_point and also add in
# geom_line later in our workshop today.
# A more appropriate way to visualize data in categories is collective geoms.
# https://ggplot2-book.org/collective-geoms.html
# We'll use boxplot_geom today.  Boxplots show medians, quartiles, and outliers.
# Let's use boxplots to visualize the distribution of price within 
# each value of `drv`:

ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_boxplot()


#####################
# Producing effective, accessible plots
#####################
#### Accessibility
# People have to be able to read your plot for it to be effective
#Let's start by making the font big enough to read from a distance.
ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_boxplot()+

  #The theme layer is where these customizations happen.  
  theme(text = element_text(size = 20),
        axis.text.x = element_text(size = 18))

#It's also hard to read the sideways y-axis label.
ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_boxplot()+
  
  #Let's look in help for theme (?theme) and find the angle option.  
  theme(text = element_text(size = 20),
        axis.text.x = element_text(size = 18),
        axis.title.y = element_text(angle = 0))

#Oops, now the y-axis label is at the top.  Check back in ?theme and see "vjust".
ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_boxplot()+
  
  #Let's look in help for theme (?theme) and find the angle option.  
  theme(text = element_text(size = 20),
        axis.text.x = element_text(size = 18),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5))

#Next, let's make the details on the plot bigger.  The defaults might be fine in a manuscript,
# but this could be hard to read at the back of a room in a presentation, or on a small
# Zoom seminar screen.  We'll check ?geom_boxplot to find the right options.
ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_boxplot(size = 2,
               outlier.size = 3)+
  theme(text = element_text(size = 20),
        axis.text.x = element_text(size = 18),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5))

#These colors not very color-blind friendly, with both red and green present in similar
#color saturation that don't contrast,
# although having the different shapes helps.
# Another layer to add to our plot is aesthetic scaling using variations on 
# scale_*_continuous(), scale_*_discrete(), and scale_*_manual(values=c()).
# (More options are shown on the cheatsheet.)  The asterisk is replaced with the aes()
# you need to use, such as fill, color, or shape.

# Let's use the package RColorBrewer for a colorblind accessible palette to change the color scale.
# You can also specify the type of color set you want.
# "div" (diverging color gradients with pale area in middle of range),
# "qual" (qualitative that do not imply magnitude changes),
# "seq" (sequences from low to high values),
# or "all" (which is default)

RColorBrewer::display.brewer.all(type = "qual",  #our three categories are not diverging from a central value nor are they a sequence
                                 colorblindFriendly = TRUE)

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ,
                           y = hwy,
                           color = drv,
                           shape = drv),
             size = 3)+
  theme(text = element_text(size = 20),
        axis.text.x = element_text(size = 18),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5))+
  #The new layer we add here is a layer specifying the color palette.
  scale_color_brewer(palette = "Set2")

# We can now distinguish among the plot types regardless of color printing
# or color-related visual impairments, making the plot easier for all readers.
# This principle is called [**universal design**](https://en.wikipedia.org/wiki/Universal_design).
# ?pch will show you all shapes as does [the ggplot2 cheatsheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf).
# Additional information on making visualizations accessible
# can be found at <https://a11yproject.com/checklist#color-contrast>.

# For more on changing aesthetics using scale_*_ (color, shape, fill), see
# [the ggplot2 cheatsheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf)



# Finally, plots with white background look more readable when printed, 
# as well as meeting more journal standards for publication.
# We can set the background to white using the function `theme_bw()`.
# Additionally, you can remove the grid.
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ,
                           y = hwy,
                           color = drv,
                           shape = drv),
             size = 3)+
  # The new layer for black and white background.
  theme_bw()+ #order matters here, it will overwrite the element_blank in theme() below if you put it afterwards.
  theme(text = element_text(size = 20),
        axis.text.x = element_text(size = 18),
        axis.title.y = element_text(angle = 0,
                                    vjust = 0.5),
        panel.grid = element_blank() #new argument to theme to remove the panel grid lines
        )+
  scale_color_brewer(palette = "Set2")

# ## Saving your theme customizations
# If you like the changes you created better than the default theme, you can save them as
# an object to be able to easily apply them to other plots you may create:
presentation_theme <- theme(text = element_text(size = 20),
                               axis.text.x = element_text(size = 18),
                               axis.title.y = element_text(angle = 0,
                                                           vjust = 0.5),
                               panel.grid = element_blank())

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ,
                           y = hwy,
                           color = drv,
                           shape = drv),
             size = 3)+
  # The new layer for black and white background.
  theme_bw()+ #order matters here, it will overwrite the element_blank in theme() below if you put it afterwards.
  presentation_theme +
  #Note it doesn't require the () here because presentation_theme
# is an object, not a function.
  scale_color_brewer(palette = "Set2")


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

# The [hrbrthemes](https://cran.r-project.org/web/packages/hrbrthemes/index.html) package
# provides many more themes as well.





#### Adding summary statistics to increase effectiveness.
# Now that the plot is accessible, let's make sure we communicate to our viewer more effectively.
# Two ways we can do this are by adding summary information and grouping.

# For example, by adding a collective/summary geom (boxplot) to a geom_jitter plot,
# we can have a better idea of the number of
# measurements and of their distribution:
ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_boxplot(size = 2,
               outlier.size = 3)+
  geom_jitter(alpha = 0.3)+
  theme_bw()+
  presentation_theme



# Challenge
# Notice how the boxplot layer is behind the jitter layer? What do you need to
# change in the code to put the boxplot in front of the points such that it's not
# hidden?
ggplot(data = mpg,
       mapping = aes(x = drv,
                     y = hwy))+
  geom_jitter(alpha = 0.3)+
  # ANSWER: change the layer order!
  geom_boxplot(size = 2,
               outlier.size = 3,
               alpha = 0.1)+  #BONUS: make the boxplot transparent to see all the points
  theme_bw()+
  presentation_theme



# Some collective geoms add summaries/variation automatically (like boxplots and violin plots)
# What if we want to add means and counts and error bars?  And how do we do this per group?
# You can do this by manually summarizing your data OR by using a geom that summarizes.
# We can use stat_summary to get collective 
# summaries other than quantiles (which are in geom_boxplot)

# Here we'll summarize means and standard deviations 
# for one continuous variable and one categorical variable.
ggplot(data = mpg,
       mapping = aes(x = class,
                     y = hwy,
                     color = drv
       )) + 
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               #use fun = mean on newest version of R
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)}, #na.rm = TRUE is not necessary with our dataset, but here to make it compatible if you use it on another dataset that contains NAs
               #use fun.max on newest version of R
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)}, #na.rm = TRUE is not necessary with our dataset, but here to make it compatible if you use it on another dataset that contains NAs
               #use fun.min on newest version of R
               position = position_dodge(width = 0.5)
  )+
  stat_summary(geom = "point",
               fun.y = mean,
               #use fun = mean on newest version of R
               size = 5,
               position = position_dodge(width = 0.5))+

  theme_bw()+
  presentation_theme


#geom and stat work very similarly as you can see by this
# identical plot as previously.  It's useful to know both exist,
# because the easiest method will depend on your data's current format.

# This is just a brief introduction to the changes you can do
# with stat and stat_summary.  What to do will depend on your
# plotting needs, including adding means to boxplots, 
# adding different error bars, etc.

# We will expand this plot into a different format now in 
# Grouping via faceting
# 
# **`ggplot2`** has a special technique called *faceting* that allows the user to split one
# plot into multiple plots based on a category included in the dataset.
# We'll take the previous category-based plot and add a layer called
# facet wrap.
ggplot(data = mpg,
       mapping = aes(x = class,
                     y = hwy,
                     color = drv
       )) + 
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               #use fun = mean on newest version of R
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)}, #na.rm = TRUE is not necessary with our dataset, but here to make it compatible if you use it on another dataset that contains NAs
               #use fun.max on newest version of R
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)}, #na.rm = TRUE is not necessary with our dataset, but here to make it compatible if you use it on another dataset that contains NAs
               #use fun.min on newest version of R
               position = position_dodge(width = 0.5)
  )+
  stat_summary(geom = "point",
               fun.y = mean,
               #use fun = mean on newest version of R
               size = 5,
               position = position_dodge(width = 0.5))+
  
  theme_bw()+
  presentation_theme +
  facet_wrap( ~ class)

# The `facet_wrap` geometry extracts plots into an arbitrary number of dimensions
# to allow them to cleanly fit on one page. On the other hand, the `facet_grid`
# geometry allows you to explicitly specify how you want your plots to be
# arranged via formula notation (`rows ~ columns`; a `.` can be used as
# a placeholder that indicates only one row or column).
# 
# Let's modify the previous plot to present more info.
ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy,
                     color = as.factor(cyl)
       )) + 
  stat_summary(geom = "errorbar", 
               fun.y = mean,
               #use fun = mean on newest version of R
               fun.ymax = function (x) {mean (x) + sd(x, na.rm = TRUE)}, #na.rm = TRUE is not necessary with our dataset, but here to make it compatible if you use it on another dataset that contains NAs
               #use fun.max on newest version of R
               fun.ymin = function (x) {mean (x) - sd(x, na.rm = TRUE)}, #na.rm = TRUE is not necessary with our dataset, but here to make it compatible if you use it on another dataset that contains NAs
               #use fun.min on newest version of R
               position = position_dodge(width = 0.5)
  )+
  stat_summary(geom = "point",
               fun.y = mean,
               #use fun = mean on newest version of R
               size = 5,
               position = position_dodge(width = 0.5))+
  
  theme_bw()+
  presentation_theme +
  facet_grid(drv ~ class)




# This wraps up our short tour of editing plots in ggplot2.  
# The goal here has been to show you some of the syntax and grammar
# ggplot2 uses, and help you understand how to use the documentation
# and cheatsheets to find options to customize plots for your needs.
# Please reach out to me or any of our information specialists
# for additional help with R at libraries.ou.edu/davis .