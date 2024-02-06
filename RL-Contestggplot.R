library(tidyverse); library(tinytex); library(conflicted); library(palmerpenguins); library(ggthemes)

#Plot1
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g )) +
  geom_hex(bins=16) +
  scale_fill_distiller(palette="Blues") +
labs(
  title = "Rapport longueur du Bec X Poids",
  subtitle = "Pour les manchots Adélie, Chinstrap et Papou",
  x = "Longueur du bec (mm)", y = "Poids (g)") +
  theme_linedraw()

#Plot 2
ggplot(data = penguins,
       mapping = aes(x = island, y = body_mass_g )) +
  geom_violin(aes(fill=species)) +
  labs(
    title = "Rapport entre l'Ile et le Poids",
    subtitle = "Pour les manchots Adélie, Chinstrap et Papou",
    x = "Île", y = "Poids (g)", fill = "Species") +
  theme_minimal() +
  scale_color_colorblind()

