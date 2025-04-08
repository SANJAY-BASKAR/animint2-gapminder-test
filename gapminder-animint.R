# Install packages if not already installed
if (!requireNamespace("devtools")) install.packages("devtools")
if (!requireNamespace("gapminder")) install.packages("gapminder")
if (!requireNamespace("animint2")) devtools::install_github("tdhock/animint2")

library(ggplot2)
library(gapminder)
library(animint2)

# Create the interactive plots
gap.plot <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, clickSelects = country)) +
  geom_text(aes(label = country, showSelected = country), hjust = 0.5, vjust = -0.5) +
  scale_x_log10() +
  theme_minimal()

time.plot <- ggplot(gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(aes(color = continent, showSelected = country)) +
  geom_tallrect(aes(xmin = year - 2.5, xmax = year + 2.5, clickSelects = year)) +
  theme_minimal()

viz.list <- list(
  scatter = gap.plot,
  time = time.plot,
  time = list(variable = "year", ms = 1000)
)

# Create the HTML output
animint2dir(viz.list, "viz-output")
