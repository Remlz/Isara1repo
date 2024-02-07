library(tidyverse); library(tinytex); library(conflicted);library(palmerpenguins); library(ggthemes); library(gridExtra)
#Plot1 : Manchots, rapport entre la longueur du bec et le poids
plot1 = ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g )) +
  geom_hex(bins=1) +
  scale_fill_distiller(palette="Blues") +
labs(
  title = "Rapport longueur du Bec X Poids",
  subtitle = "Pour les manchots Adélie, Chinstrap et Papou",
  x = "Longueur du bec (mm)", y = "Poids (g)") +
  theme_linedraw()

#Plot 2 : Manchots, rapport entre l'île et le poids
plot2 = ggplot(data = penguins,
       mapping = aes(x = island, y = body_mass_g )) +
  geom_violin(aes(fill=species)) +
  labs(
    title = "Rapport entre l'Ile et le Poids",
    subtitle = "Pour les manchots Adélie, Chinstrap et Papou",
    x = "Île", y = "Poids (g)", fill = "Species") +
  theme_minimal() +
  scale_color_colorblind()

grid.arrange(plot1, plot2, ncol=2)
