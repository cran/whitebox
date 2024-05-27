## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  eval = whitebox::check_whitebox_binary(),
  echo = TRUE,
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 6 
)

## ----include=FALSE, echo=FALSE, eval=TRUE-------------------------------------
# setup so inline stats on version/tools show up
library(whitebox)
data("wbttoolparameters", package="whitebox")

## ----setup, include=FALSE-----------------------------------------------------
# # sample code to check and install whitebox to a custom path
# if (!whitebox::check_whitebox_binary()) {
#   wd <- tempdir()
#   whitebox::install_whitebox(wd)
#   whitebox::wbt_init(wd = file.path(wd, "WBT", basename(whitebox::wbt_default_path())))
# }

# system and package dependencies must be met to build the vignette
stopifnot(requireNamespace("terra"))

## -----------------------------------------------------------------------------
library(whitebox)

## -----------------------------------------------------------------------------
wbt_exe_path(shell_quote = FALSE)

## -----------------------------------------------------------------------------
library(terra)
library(whitebox)

# DEMO: calculate slope with WhiteboxTools and raster

# Typically the input/output paths are stored as variables

# sample DEM input GeoTIFF
input <- sample_dem_data()

# output file (to be created)
output <- file.path(tempdir(), "slope.tif")

## -----------------------------------------------------------------------------
wbt_slope(input, output, units = 'radians')

## -----------------------------------------------------------------------------
if (file.exists(output)) {
  # create a SpatRaster from file output path
  outputras <- terra::rast(output)
}

## -----------------------------------------------------------------------------
if (file.exists(input) && file.exists(output) && !is.null(outputras)) {
  # par(mfrow = c(2, 1), mar = c(1, 1, 1, 1))
  
  # inspect the output graphically
  plot(
    outputras,
    main = "whitebox::wbt_slope() [radians]",
    axes = FALSE
  )
  
  # calculate equivalent using raster::terrain() on input
  plot(
    terra::terrain(terra::rast(input)),
    main = "terra::terrain() [radians]",
    axes = FALSE
  )
}

## -----------------------------------------------------------------------------
# the SpatRaster retains a reference to the input file name
terra::sources(outputras)

## -----------------------------------------------------------------------------
# inspect where wbt_init() will be checking
wbt_exe_path(shell_quote = FALSE)

# TRUE when file is found at one of the user specified paths or package default
# FALSE when whitebox_tools does not exist at path
wbt_init()

## ----eval=FALSE---------------------------------------------------------------
#  # set path manually to whitebox_tools executable, for instance:
#  wbt_init(exe_path = '/home/andrew/workspace/whitebox-tools/target/release/whitebox_tools')

## -----------------------------------------------------------------------------
# force output when run non-interactively (knitr)
wbt_verbose(TRUE)

## -----------------------------------------------------------------------------
# sample DEM file path in package extdata folder
input <- sample_dem_data()

# output file name
output <- file.path(tempdir(), "output.tif")

# run breach_depressions tool
wbt_breach_depressions(dem = input, output = output)

## -----------------------------------------------------------------------------
# sample DEM file path in package extdata folder
input <- sample_dem_data()

# output file name
output <- file.path(tempdir(), "output.tif")

# run breach_depressions tool
wbt_run_tool(tool_name = "BreachDepressions", args = paste0("--dem=", input, " --output=", output))

## -----------------------------------------------------------------------------
library(terra)

# sample DEM file path in package extdata folder
input <- sample_dem_data()

# output file name
output <- file.path(tempdir(), "output.tif")

## -----------------------------------------------------------------------------
# run breach_depressions tool
wbt_breach_depressions(dem = input, output = output)

## -----------------------------------------------------------------------------
# create raster object from input file
input <- rast(input)

if (file.exists(output)) {
  # create raster object from output file
  output <- rast(output)
  
  # par(mar = c(2, 1, 2, 1))
  # inspect input v.s. output
  plot(input, axes = FALSE, main = "DEM")
  plot(output, axes = FALSE, main = "DEM (Breached Depressions)")
  
  # inspect numeric difference (output - input) 
  plot(output - input, axes = FALSE,  main = "Difference ([Breached Depressions] - [DEM])")
}

## -----------------------------------------------------------------------------
library(whitebox)
library(terra)

## Sample DEM from whitebox package
toy_file <- sample_dem_data()
toy_dem <- rast(x = toy_file)

## Generate wd as a temporary directory. 
## Replace with your own path, or "." for current directory
wd <- tempdir()

## Write toy_dem to working directory
writeRaster(
  x = toy_dem, filename = file.path(wd, "toy_dem.tif"),
  overwrite = TRUE
)

## -----------------------------------------------------------------------------
## Breach depressions to ensure continuous flow
wbt_breach_depressions(
  dem = file.path(wd, "toy_dem.tif"),
  output = file.path(wd, "toy_dem_breached.tif")
)

## -----------------------------------------------------------------------------
## Generate d8 flow pointer (note: other flow directions are available)
wbt_d8_pointer(
  dem = file.path(wd, "toy_dem_breached.tif"),
  output = file.path(wd, "toy_dem_breached_d8.tif")
)

## -----------------------------------------------------------------------------
## Generate d8 flow accumulation in units of cells (note: other flow directions are available)
wbt_d8_flow_accumulation(
  input = file.path(wd, "toy_dem_breached.tif"),
  output = file.path(wd, "toy_dem_breached_accum.tif"),
  out_type = "cells"
)

## ----echo = FALSE-------------------------------------------------------------
wbt_list_tools(keyword = "flow pointer")

## -----------------------------------------------------------------------------
## Generate streams with a stream initiation threshold of 100 cells
wbt_extract_streams(
  flow_accum = file.path(wd, "toy_dem_breached_accum.tif"),
  output = file.path(wd, "toy_dem_streams.tif"),
  threshold = 100
)


## -----------------------------------------------------------------------------
wbt_tributary_identifier(
  d8_pntr = file.path(wd, "toy_dem_breached_d8.tif"),
  streams = file.path(wd, "toy_dem_streams.tif"),
  output = file.path(wd, "toy_dem_tributaries.tif")
)

## -----------------------------------------------------------------------------
if (file.exists(file.path(wd, "toy_dem_streams.tif"))) {
  par(mfrow = c(2, 1), mar = c(3, 1, 2, 1))
  
  plot(
    rast(file.path(wd, "toy_dem_streams.tif")),
    main = "Streams",
    col = "black"
  )
  
  plot(
    rast(file.path(wd, "toy_dem_tributaries.tif")),
    main = "TributaryIdentifier"
  )
}

## -----------------------------------------------------------------------------
wbt_help()

## -----------------------------------------------------------------------------
wbt_license()

## -----------------------------------------------------------------------------
wbt_version()

## ----eval=FALSE---------------------------------------------------------------
#  wbt_list_tools()

## -----------------------------------------------------------------------------
wbt_list_tools(keywords = "flowaccumulation")

## -----------------------------------------------------------------------------
wbt_tool_help("tributaryidentifier")

## -----------------------------------------------------------------------------
wbt_toolbox(tool_name = "aspect")

## -----------------------------------------------------------------------------
wbt_toolbox()

## -----------------------------------------------------------------------------
wbt_tool_parameters("slope")

## -----------------------------------------------------------------------------
wbt_view_code("breach_depressions")

## ----echo=FALSE---------------------------------------------------------------
# cleanup temp files
wd <- tempdir()
unlink(file.path(wd, "slope.tif"))
unlink(file.path(wd, "output.tif"))
unlink(list.files(wd, "^toy_dem.*tif*$", full.names = TRUE))

