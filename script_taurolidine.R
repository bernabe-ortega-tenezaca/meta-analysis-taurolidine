# META-ANALYSIS: "Efficacy of Taurolidine in Preventing Catheter-Related Bloodstream Infections

# Install and load the 'meta' package
install.packages("meta") 

library(meta)

# Load data from CSV file
taurolidine_data <- read.csv("1 taurolidine.csv")

# View the data to verify 
View(taurolidine_data)
# Check the structure and data types
str(taurolidine_data)

# Perform the meta-analysis
# We use 'metabin' because CRBSI is a binary outcome
# EE = Events in Experimental group (Taurolidine)
# TE = Total in Experimental group (Taurolidine)
# EC = Events in Control group
# TC = Total in Control group
taurolidine_meta <- metabin(EE, TE, EC, TC,
                            sm="RR", 
                            studlab = paste(Author, Year),
                            data = taurolidine_data,
                            method = "inverse",
                            method.tau = "PM",
                            incr="TACC")

# Display the summary of the meta-analysis result 
summary(taurolidine_meta)

# Generate the Forest Plot
# A key visualization to display individual study results and the pooled effect
forest(taurolidine_meta,
       comb.random = TRUE, # Show the pooled effect from the random-effects model
       lab.e = "Taurolidine", # Label for the experimental group
       lab.c = "Control", # Label for the control group
       smlab = "CRBSI Risk Ratio", # Title for the summary measure
       common = FALSE, # Do not show the pooled effect from the fixed-effect model
       col.diamond = "forestgreen", # Color of the diamond for the pooled effect
       col.square = "darkgreen", # Color of the squares for individual studies
       addrow = FALSE, # Do not add extra blank rows
       label.right = "Favors Control", # Label for the right side of the plot
       label.left = "Favors Taurolidine", # Label for the left side of the plot
       bottom.lr = TRUE, # Place "favors" labels at the bottom
       ff.lr = "bold", # Bold format for "favors" labels
       colgap = "10mm", # Gap between columns
       pooled.events = TRUE, # Show the pooled number of events
       addrow.overall = TRUE, # Add a row for the overall result
       overall = TRUE, # Show the overall result (diamond)
       col.by = "black", # Color for grouping lines 
       xlim = c(0.01, 10), # X-axis limits for the Risk Ratio
       prediction = TRUE) # Add the prediction interval

# Generate the Funnel Plot to assess publication bias
funnel(taurolidine_meta,
       xlab = "Risk Ratio", # X-axis label
       backtransf = TRUE) # Display RR on the original scale (not log-scale)
