# title: Visualization in R with 'ggplot2'
# author: Data Carpentry contributors (www.datacarpentry.org) +
# modified by Claire M. Curry (OU Libraries - cmcurry@ou.edu) 
# under CC BY 4.0 and MIT licenses for instructional materials and software

# minutes: 150

# > ### Learning Objectives
# 
# > * Overall: Build complex and customized plots from data in a data frame.
# > * Produce appropriate plot types for your data
#       * Create multiple types of plots: Produce scatter plots, boxplots, violin plots, and time series plots using ggplot.
# >     * Add measures of variation and summaries to plots.
# >     * Describe what faceting is and apply faceting in ggplot.
# > * Produce clear and accessible aesthetics and labels for your plot
#       * Modify the aesthetics of an existing ggplot plot
#         (including axis labels and color), focusing on
#         accessibility (colorblind palettes, using shapes and line types, changing font size)
#         and clarity (removing grids)
#       * Add and modify annotations and legends for clarity.

# We start by loading the required packages. 
# **`ggplot2`** is included in the **`tidyverse`** package.
# You may need to install **`tidyverse`** or **`RColorBrewer`** 
# if you did not do so before the workshop.


library(tidyverse)
library(RColorBrewer)

# 
# Next, we download the data file and and load it into R.

surveys_complete <- read_csv("data_output/surveys_complete.csv")

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

ggplot(data = surveys_complete)


# - define a mapping (using the aesthetic (`aes`) function), by selecting the variables to be plotted and specifying how to present them in the graph, e.g. as x/y positions or characteristics such as size, shape, color, etc.


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

# 
# - add 'geoms' – graphical representations of the data in the plot (points,
#   lines, bars). **`ggplot2`** offers many different geoms; we will use some 
#   common ones today, including:
#   
#       * `geom_point()` for scatter plots, dot plots, etc.
#       * `geom_boxplot()` for, well, boxplots!
#       * `geom_line()` for trend lines, time series, etc.  

# To add a geom to the plot use the `+` operator. Because we have two continuous variables,
# let's use `geom_point()` first:


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()


# The `+` in the **`ggplot2`** package is particularly useful because it allows you
# to modify existing `ggplot` objects. This means you can easily set up plot
# templates and conveniently explore different types of plots, so the above
# plot can also be generated with code like this:


# Assign plot to a variable
surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))

# Draw the plot
surveys_plot + 
    geom_point()


# Create a ggplot and draw it
surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
surveys_plot + 
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
surveys_plot +
  geom_point()
# 
# # This will not add the new layer and will return an error message
surveys_plot
+ geom_point()



# ## Building your plots iteratively
# 
# Building plots with **`ggplot2`** is typically an iterative process. We start by
# defining the dataset we'll use, lay out the axes, and choose a geom:

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point()

# 
# Then, we start modifying this plot to extract more information from it. For
# instance, we can add transparency (`alpha`) to avoid overplotting:


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1)


# We can also add colors for all the points:


ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_point(alpha = 0.1, color = "blue")


# To color each species in the plot differently, you could use a vector as an input to the argument **color**. **`ggplot2`** will provide a different color corresponding to different values in the vector. Here is an example where we color with **`species_id`**:



ggplot(data = surveys_complete, 
       mapping = aes(x = weight,
                     y = hindfoot_length)) +
    geom_point(alpha = 0.1, 
               aes(color = species_id))


# We can also specify the colors directly inside the mapping provided in the `ggplot()` function. This will be seen by any geom layers and the mapping will be determined by the x- and y-axis set up in `aes()`.


ggplot(data = surveys_complete, 
       mapping = aes(x = weight,
                     y = hindfoot_length,
                     color = species_id)) +
    geom_point(alpha = 0.1)


# Notice that we can change the geom layer and colors will be still determined by **`species_id`**


  
ggplot(data = surveys_complete,
       mapping = aes(x = weight,
                     y = hindfoot_length,
                     color = species_id)) +
    geom_jitter(alpha = 0.1)





# > ### Challenge
# >
# > Use what you just learned to create a scatter plot of `weight` over
# > `species_id` with the plot types showing in different colors. Is this a good
# > way to show this type of data?

ggplot(data = surveys_complete, 
       mapping = aes(x = species_id,
                     y = weight)) +
    geom_point(aes(color = plot_type))


# ## Boxplot
# 
# We can use boxplots to visualize the distribution of weight within each species:

ggplot(data = surveys_complete,
       mapping = aes(x = species_id,
                     y = weight)) +
    geom_boxplot()


# By adding points to boxplot, we can have a better idea of the number of
# measurements and of their distribution:

ggplot(data = surveys_complete, 
       mapping = aes(x = species_id,
                     y = weight)) +
    geom_boxplot(alpha = 0) +
    geom_jitter(alpha = 0.3, 
                color = "tomato")

# 
# Notice how the boxplot layer is behind the jitter layer? What do you need to
# change in the code to put the boxplot in front of the points such that it's not
# hidden?


## Challenge with boxplots:
##  Start with the boxplot we created:
ggplot(data = surveys_complete, 
       mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato")

##  1. Replace the box plot with a violin plot; see `geom_violin()`.

##  2. Represent weight on the log10 scale; see `scale_y_log10()`.

##  3. Create boxplot for `hindfoot_length` overlaid on a jitter layer.

##  4. Add color to the data points on your boxplot according to the
##  plot from which the sample was taken (`plot_id`).
##  *Hint:* Check the class for `plot_id`. Consider changing the class
##  of `plot_id` from integer to factor. Why does this change how R
##  makes the graph?




# ## Plotting time series data
# 
# Let's calculate number of counts per year for each species. First we need
# to group the data and count records within each group:

yearly_counts <- surveys_complete %>%
                 count(year, species_id)

# 
# Time series data can be visualized as a line plot with years on the x axis and counts
# on the y axis:


ggplot(data = yearly_counts, 
       mapping = aes(x = year, y = n)) +
     geom_line()


# Unfortunately, this does not work because we plotted data for all the species
# together. We need to tell ggplot to draw a line for each species by modifying
# the aesthetic function to include `group = species_id`:

ggplot(data = yearly_counts, 
       mapping = aes(x = year, 
                     y = n,
                     group = species_id)) +
    geom_line()


# We will be able to distinguish species in the plot if we add colors (using `color` also automatically groups the data):


ggplot(data = yearly_counts,
       mapping = aes(x = year,
                     y = n,
                     color = species_id)) +
    geom_line()


# ## Add measures of variation and summaries to your plots
# 
geom_dotplot()
geom_errorbar()

# ## Faceting
# 
# **`ggplot2`** has a special technique called *faceting* that allows the user to split one
# plot into multiple plots based on a factor included in the dataset. We will use it to
# make a time series plot for each species:


ggplot(data = yearly_counts,
       mapping = aes(x = year,
                     y = n)) +
    geom_line() +
    facet_wrap(~ species_id)


# Now we would like to split the line in each plot by the sex of each individual
# measured. To do that we need to make counts in the data frame grouped by `year`,
# `species_id`, and `sex`:

yearly_sex_counts <- surveys_complete %>%
                      count(year,
                            species_id,
                            sex)


# We can now make the faceted plot by splitting further by sex using `color` (within a single plot):


 ggplot(data = yearly_sex_counts,
        mapping = aes(x = year,
                      y = n, 
                      color = sex)) +
     geom_line() +
     facet_wrap(~ species_id)



# The `facet_wrap` geometry extracts plots into an arbitrary number of dimensions
# to allow them to cleanly fit on one page. On the other hand, the `facet_grid`
# geometry allows you to explicitly specify how you want your plots to be
# arranged via formula notation (`rows ~ columns`; a `.` can be used as
# a placeholder that indicates only one row or column).
# 
# Let's modify the previous plot to compare how the weights of males and females
# have changed through time:

  
# One column, facet by rows
yearly_sex_weight <- surveys_complete %>%
    group_by(year, sex, species_id) %>%
    summarize(avg_weight = mean(weight))
ggplot(data = yearly_sex_weight, 
       mapping = aes(x = year, 
                     y = avg_weight,
                     color = species_id)) +
    geom_line() +
    facet_grid(sex ~ .)


# One row, facet by column
ggplot(data = yearly_sex_weight, 
       mapping = aes(x = year, 
                     y = avg_weight,
                     color = species_id)) +
    geom_line() +
    facet_grid(. ~ sex)

# 
# ## Customizing the appearance for accessibility and clarity
# 
# Usually plots with white background look more readable when printed.  We can set
# the background to white using the function `theme_bw()`. Additionally, you can remove
# the grid:


 ggplot(data = yearly_sex_counts,
        mapping = aes(x = year,
                      y = n, 
                      color = sex)) +
     geom_line() +
     facet_wrap(~ species_id) +
     theme_bw() +
     theme(panel.grid = element_blank())


# 
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

n <- ggplot(data = yearly_sex_counts,
            mapping = aes(x = year,
                          y = n, 
                          color = sex)) +
     geom_line() +
     facet_wrap(~ species_id) +
     theme_bw() +
     theme(panel.grid = element_blank())

n + scale_fill_brewer(palette = "Blues")

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

n + scale_fill_grey(start = 0.2, end = 0.8, na.value = "red")


# Using shapes or line types instead of colors to distinguish among values can also make figures
# more accessible or easier to read in black-and-white.  Let's go back to our weight and length 
# plot.  Let's try to distinguish among plot types.


# We'll save the main plot as an object so we don't have to retype it to test each aes().
points_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

# Let's first test using default colors.
points_plot +
    geom_point(alpha = 0.1, color = plot_type)
# And then with RColorBrewer for a colorblind accessible palette.
points_plot +
    geom_point(alpha = 0.1, color = plot_type)+
  scale_color_brewer(palette = "Dark2")

#Let's check the automated shapes.
points_plot +
    geom_point(alpha = 0.1, shape = plot_type)
  
# We can now distinguish among the plot types regardless of color printing or color-related visual impairments, making the plot easier for all readers.  This principle is called [**universal design**](https://en.wikipedia.org/wiki/Universal_design).
# ?pch will show you all shapes as does the ggplot2 cheatsheet.
# Additional information on making visualizations accessible can be found at <https://a11yproject.com/checklist#color-contrast>.
# 

# > ### Challenge
# > 
# > With all of this information in hand, please take another five minutes to
# > alter more aesthetics of one of the graphs. Use the RStudio [**`ggplot2`** cheat sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
# > for inspiration. Here are some ideas:
# >
# > * Change the color of a continuous (numeric) variable.
# > * Manually choose point shapes.


# ## Changing the axis and axis label font sizes and angle
# Now, let's change names of axes to something more informative than 'year'
# and 'n' and add a title to the figure:


ggplot(data = yearly_sex_counts,
       mapping = aes(x = year,
                     y = n,
                     color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
         x = "Year of observation",
         y = "Number of individuals") +
    theme_bw()


# The axes have more informative names, but their readability can be improved by
# increasing the font size:

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
        x = "Year of observation",
        y = "Number of individuals") +
    theme_bw() +
    theme(text=element_text(size = 16))


# Note that it is also possible to change the fonts of your plots. If you are on
# Windows, you may have to install
# the [**`extrafont`** package](https://github.com/wch/extrafont), and follow the
# instructions included in the README for this package.

# > ### Challenge
# > 
# > After our manipulations, you may notice that the values on the x-axis
# > are still not properly readable. Let's change the orientation of the labels
# > and adjust them vertically and horizontally so they don't overlap.
# > * Use help for element_text to find the argument to adjust the text angle.
# > * You can use a 90-degree angle, or experiment to find the appropriate angle.


ggplot(data = yearly_sex_counts, 
       mapping = aes(x = year, 
                     y = n,
                     color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
        x = "Year of observation",
        y = "Number of individuals") +
    theme_bw() +
    theme(axis.text.x = element_text(colour = "grey20",
                                     size = 12,
                                     angle = 90,
                                     hjust = 0.5, 
                                     vjust = 0.5),
          axis.text.y = element_text(colour = "grey20",
                                     size = 12),
          text = element_text(size = 16))


# 
# ## Add annotations and customize legends for clarity
# 
# * legend.title
# * legend.text
# * geom_text #adding labels to points
# * annotate(geom = "text", )
# * add sample size to each facet
# 


# ## Saving your theme customizations
# If you like the changes you created better than the default theme, you can save them as
# an object to be able to easily apply them to other plots you may create:
# 

grey_theme <- theme(axis.text.x = element_text(colour = "grey20",
                                               size = 12,
                                               angle = 90, 
                                               hjust = 0.5,
                                               vjust = 0.5),
                    axis.text.y = element_text(colour = "grey20", 
                                               size = 12),
                    text = element_text(size = 16))

ggplot(surveys_complete,
       mapping = aes(x = species_id,
                             y = hindfoot_length)) +
    geom_boxplot() +
    grey_theme
#Note it doesn't require the () here because grey_theme is an object, not a function.

# > ### Challenge
# > 
# > Save a theme (the changes you've made so far or add additional ones)
# > Then apply them to a different graph.



# ## Arranging and exporting plots
# 
# Faceting is a great tool for splitting one plot into multiple plots, but sometimes you may want to produce a single figure that contains multiple plots using different variables or even different data frames. The **`gridExtra`** package allows us to combine separate ggplots into a single figure using `grid.arrange()`:

install.packages("gridExtra")
library(gridExtra)

spp_weight_boxplot <- ggplot(data = surveys_complete, 
                             mapping = aes(x = species_id, 
                                           y = weight)) +
  geom_boxplot() +
  xlab("Species") +
  ylab("Weight (g)") +
  scale_y_log10()

spp_count_plot <- ggplot(data = yearly_counts, 
                         mapping = aes(x = year,
                                       y = n, 
                                       color = species_id)) +
  geom_line() + 
  xlab("Year") + 
  ylab("Abundance")

grid.arrange(spp_weight_boxplot,
             spp_count_plot,
             ncol = 2, 
             widths = c(4, 6))



# In addition to the `ncol` and `nrow` arguments, used to make simple arrangements, there are tools for [constructing more complex layouts](https://cran.r-project.org/web/packages/gridExtra/vignettes/arrangeGrob.html). 
# 
# After creating your plot, you can save it to a file in your favorite format. The Export tab in the **Plot** pane in RStudio will save your plots at low resolution, which will not be accepted by many journals and will not scale well for posters. 
# 
# Instead, use the `ggsave()` function, which allows you easily change the dimension and resolution of your plot by adjusting the appropriate arguments (`width`, `height` and `dpi`). 
# 
# Make sure you have the `fig_output/` folder in your working directory.


my_plot <- ggplot(data = yearly_sex_counts, 
                  mapping = aes(x = year,
                                y = n,
                                color = sex)) +
    geom_line() +
    facet_wrap(~ species_id) +
    labs(title = "Observed species in time",
        x = "Year of observation",
        y = "Number of individuals") +
    theme_bw() +
    theme(axis.text.x = element_text(colour = "grey20",
                                     size = 12,
                                     angle = 90,
                                     hjust = 0.5,
                                     vjust = 0.5),
          axis.text.y = element_text(colour = "grey20",
                                     size = 12),
          text=element_text(size = 16))
ggsave("fig_output/yearly_sex_counts.png",
       my_plot,
       width = 15,
       height = 10)

# This also works for grid.arrange() plots.
# Note that specifying the extension changes the file type saved.
# check ?ggsave to see the other extensions you can use listed under the device argument.
combo_plot <- grid.arrange(spp_weight_boxplot,
                           spp_count_plot, 
                           ncol = 2, 
                           widths = c(4, 6))

# Note that you don't need dpi for vector outputs like pdf, svg, or eps.
ggsave("fig_output/combo_plot_abun_weight.pdf",
       combo_plot, 
       width = 10)


# Note: The parameters `width` and `height` also determine the font size in the saved plot.



### Final plotting challenge:
##  With all of this information in hand, please take another five
##  minutes to either improve one of the plots generated in this
##  exercise or create a beautiful graph of your own. Use the RStudio
##  ggplot2 cheat sheet for inspiration:
##  https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf

