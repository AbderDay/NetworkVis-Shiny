NetworkVis Shiny App

Use this app to visualize networks. Inputs must be square matrices in CSV format, 
with the first row and first column containing element labels. All other values must be numerical.

Two example datasets are provided under the "example_inputs/" directory.

The app is also hosted online at https://abderday.shinyapps.io/final_project/

Directory:
	app.R					- Shiny R script used to deploy the app
	example_inputs/
		/binary_example.csv		- Binary network matrix, from a sample yeast protein-protein interaction dataset
		/correlation_example.csv	- Simulated gene co-expression data	



Abderrahman Day
Updated 05/02/2022
