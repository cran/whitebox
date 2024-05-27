## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = whitebox::check_whitebox_binary() & 
          requireNamespace("terra", quietly = TRUE)
)

## -----------------------------------------------------------------------------
library(whitebox)

## -----------------------------------------------------------------------------
wbt("slope")

## -----------------------------------------------------------------------------
# get file path of sample DEM
dem <- sample_dem_data()

wbt("slope", dem = dem, output = file.path(tempdir(), "slope.tif"))

## -----------------------------------------------------------------------------
wbt("slope", goof = dem, output = file.path(tempdir(), "slope.tif"))

## -----------------------------------------------------------------------------
str(wbt("slope", dem = dem, output = file.path(tempdir(), "slope.tif")), max.level = 1)

## -----------------------------------------------------------------------------
# on error there is a try-error object in $result
x <- wbt("slope")
inherits(x$result, 'try-error')
message(x$result[1])

## -----------------------------------------------------------------------------
if (requireNamespace("raster")) {
  rdem <- raster::raster(dem)

  # raster input; raster output
  r1 <- wbt("slope", dem = rdem, output = file.path(tempdir(), "slope.tif"))
  r1
  class(r1$result$output)
}

## -----------------------------------------------------------------------------
tdem <- terra::rast(dem)

## terra input; terra output
t1 <- wbt("slope", dem = tdem, output =  file.path(tempdir(), "slope.tif"))
t1
class(t1$result$output)

## -----------------------------------------------------------------------------
library(terra)
shp <- system.file("ex/lux.shp", package = "terra")
x <- wbt_source(shp)
x

## -----------------------------------------------------------------------------
# load the data
x2 <- query(x)

# remove area column
x2$AREA <- NULL

# create a GeoPackage
terra::writeVector(x2, filename = file.path(tempdir(), "lux.gpkg"), overwrite = TRUE)

# now the source is a temporary .shp
x3 <- wbt_source(file.path(tempdir(), "lux.gpkg"))

wbt("polygon_area", input = x3)

## -----------------------------------------------------------------------------
x <- wbt("slope", dem = dem, output = file.path(tempdir(), "slope.tif"))
x2 <- wbt(x, tool_name = "slope", output = file.path(tempdir(), "curvature.tif"))

## -----------------------------------------------------------------------------
x2

## -----------------------------------------------------------------------------
str(wbt_result(x2), max.level = 1)

## -----------------------------------------------------------------------------
str(x2$history, max.level = 1)

## -----------------------------------------------------------------------------
x <- wbt("slope")
wbt(x, "slope", output = file.path(tempdir(), "foo.tif"))

## -----------------------------------------------------------------------------
dem <- sample_dem_data()

## equivalent to:
# dem <- system.file("extdata/DEM.tif", package = "whitebox")

## -----------------------------------------------------------------------------
araster <- terra::rast(dem)
wbt("slope", dem = araster, output = file.path(tempdir(), "foo.tif"))

## -----------------------------------------------------------------------------
wbt("slope", dem = terra::rast(dem), crs = "EPSG:26918", output = file.path(tempdir(), "foo.tif"))

## -----------------------------------------------------------------------------
r1 <- terra::rast(dem) # default: EPSG:26918
r2 <- terra::deepcopy(r1)
crs(r2) <- "EPSG:26917" # something else/wrong
wbt("add", 
    input1 = r1, 
    input2 = r2, 
    output = file.path(tempdir(), "foo.tif")
   )

## -----------------------------------------------------------------------------
wbt("add", 
    input1 = r1,
    input2 = r2, 
    crs = "EPSG:26918",
    output = file.path(tempdir(), "foo.tif")
   )

## ----echo=FALSE---------------------------------------------------------------
# cleanup temp files
unlink(list.files(".", pattern = "file.*tif$", full.names = TRUE))
unlink(list.files(tempdir(), pattern = "file.*tif$", full.names = TRUE))

