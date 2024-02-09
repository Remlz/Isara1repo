##Application sur les manchots

library(shiny); library(palmerpenguins); library(ggplot2); library(ggthemes)


#On définit l'interface utilisateur
ui <- fluidPage(
    #Titre de l'application
    titlePanel("Palmerpenguins"),

    #Panneau latéral
    sidebarLayout(
        sidebarPanel(
          #Case à cocher
           checkboxInput(inputId = "LM" , label = "Modèle Linéaire", value = FALSE),
           #Liste déroulante pour sélectionner le rapport à choisir
           selectInput(inputId = "choix", label = "Sélectionnez les données à visualiser: ",
                       selected = 3,
                       choices = c("Longueur X largeur du bec",
                                   "Longueur des nageoires X Poids",
                                   "Longueur du Bec X Poids")),
           tags$br(), #saut de ligne
           #Cursus pour choisir le spectre des données observées
           sliderInput("valzoom",
                        "Zoom",
                        min = 60,
                        max = 100,
                        value = 30)
        ),

        mainPanel(
           plotOutput("distPlot")
        )
    )
)

#On définit le server
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # switch() permet de sélectionner la valeur correcte selon les options,
            # remplace if/elseif/else
    #On détermine le X ainsi que la légende à utiliser
    x_var <- switch(input$choix,
                    "Longueur X largeur du bec" = "bill_length_mm",
                    "Longueur des nageoires X Poids" = "flipper_length_mm",
                    "Longueur du Bec X Poids" = "bill_length_mm")
    x_name <- switch(input$choix,
                     "Longueur X largeur du bec" = "Longueur du bec (mm)",
                     "Longueur des nageoires X Poids" = "Longueur des ailes (mm)",
                     "Longueur du Bec X Poids" = "Longueur du bec (mm)")
    #On détermine le Y ainsi que la légende à utiliser
    y_var <- switch(input$choix,
                    "Longueur X largeur du bec" = "bill_depth_mm",
                    "Longueur des nageoires X Poids" = "body_mass_g",
                    "Longueur du Bec X Poids" = "body_mass_g")
    y_name <- switch(input$choix,
                     "Longueur X largeur du bec" = "Largeur du bec (mm)",
                     "Longueur des nageoires X Poids" = "Poids",
                     "Longueur du Bec X Poids" = "Poids")
    
    plot <- ggplot(data = penguins, mapping = aes(!!sym(x_var),
    #sym() convertir une chaîne de caractères en un symbole
    #!! pour regarder l'expression dans symm(), ici les données de penguins
      y = !!sym(y_var))) + 
      #On place la légende en dessous du graphique
      theme(legend.position = "bottom") +
      #On définit l'aspect du nuage de point
      geom_point(aes(color = species, shape = species)) +
      #Légende
      labs(
        title = input$choix,
        subtitle = "Pour les manchots Adélie, Chinstrap et Papou",
        x = x_name, y = y_name,
        color = "Species", shape = "Species"
      ) +
      #On rend le graphique visible pour tous, mode daltonien
      scale_color_colorblind()
    
###Ne fonctionne toujours pas ...    
    #J'applique le zoom
    
    #Try 1
      #plot <- plot + coord_cartesian(xlim = c(20, input$valzoom), ylim= c(10, input$valzoom/2))
    
    #Try 2
    
    #On a besoin de définir un point central pour dézommer correctement
    x_centre <- mean(penguins[x_var])
    y_centre <- mean(penguins[y_var])
    #On gère le dézoom
    xdez <- c(x_centre - input$valzoom/2, x_centre + input$valzoom/2)
    ydez <- c(y_centre - input$valzoom/2, y_centre + input$valzoom/2)
    #Maintenant on peut dézoomer correctement
    plot <- plot + coord_cartesian(xlim = xdez, ylim = ydez)

    #On ajoute ou retire le linear model selon si la case est cochée ou non
    if (input$LM) {
      plot <- plot + geom_smooth(aes(color = species))
    }
    
    print(plot)
  })
}

#Run the application 
shinyApp(ui = ui, server = server)