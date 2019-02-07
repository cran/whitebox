## ----message=FALSE, warning=FALSE----------------------------------------
library(whitebox)

## ------------------------------------------------------------------------
print(wbt_help())

## ------------------------------------------------------------------------
print(wbt_license())

## ------------------------------------------------------------------------
print(wbt_version())

## ----eval=FALSE, message=FALSE-------------------------------------------
#  print(wbt_toolbox())

## ----eval=FALSE, message=FALSE-------------------------------------------
#  print(wbt_list_tools())

## ----eval=FALSE, message=FALSE-------------------------------------------
#  print(wbt_list_tools("lidar"))

## ------------------------------------------------------------------------
print(wbt_tool_help("lidar_info"))

## ------------------------------------------------------------------------
print(wbt_tool_parameters("slope"))

## ------------------------------------------------------------------------
print(wbt_view_code("breach_depressions"))

## ----eval=FALSE----------------------------------------------------------
#  library(whitebox)
#  
#  # Set input raster DEM file
#  dem <- system.file("extdata", "DEM.tif", package="whitebox")
#  
#  # Run tools
#  feature_preserving_denoise(dem, "./smoothed.tif", filter=9, verbose_mode = TRUE)
#  breach_depressions("./smoothed.tif", "./breached.tif")
#  d_inf_flow_accumulation(dem, "./flow_accum.tif")

