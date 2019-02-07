# whiteboxR

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/giswqs/whitebox-r-binder/master?urlpath=rstudio)
[![Binder](https://binder.pangeo.io/badge.svg)](https://binder.pangeo.io/v2/gh/giswqs/whitebox-r-binder/master?urlpath=rstudio)
[![Build Status](https://travis-ci.org/giswqs/whiteboxR.svg?branch=master)](https://travis-ci.org/giswqs/whiteboxR)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/giswqs/whiteboxR?branch=master&svg=true)](https://ci.appveyor.com/project/giswqs/whiteboxR)
[![docs](https://img.shields.io/badge/docs-passing-brightgreen.svg)](https://giswqs.github.io/whiteboxR)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Donate](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-yellowgreen.svg)](https://www.buymeacoffee.com/giswqs)


**WhiteboxTools** R Frontend.

This repository is related to the **whitebox** R package for geospatial analysis, which is an R frontend of a stand-alone executable command-line program called **[WhiteboxTools](https://github.com/jblindsay/whitebox-tools)**. 

* Authors: Dr. John Lindsay (<http://www.uoguelph.ca/~hydrogeo/index.html>)
* Contributors: Dr. Qiusheng Wu (<https://wetlands.io>)
* GitHub repo: <https://github.com/giswqs/whiteboxR>
* WhiteboxTools: <https://github.com/jblindsay/whitebox-tools>
* User Manual: <https://jblindsay.github.io/wbt_book>
* Free software: [MIT license](https://opensource.org/licenses/MIT)


**Contents**

1. [Description](#description)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Available Tools](#available-tools)
5. [Contributing](#contributing)
6. [License](#license)
7. [Reporting Bugs](#reporting-bugs)

## Description

The **whitebox** R package is built on **WhiteboxTools**, an advanced geospatial data analysis platform developed by Prof. John Lindsay ([webpage](http://www.uoguelph.ca/~hydrogeo/index.html); [jblindsay](https://github.com/jblindsay)) at the University of Guelph's [Geomorphometry and Hydrogeomatics Research Group](http://www.uoguelph.ca/~hydrogeo/index.html). *WhiteboxTools* can be used to perform common geographical information systems (GIS) analysis operations, such as cost-distance analysis, distance buffering, and raster reclassification. Remote sensing and image processing tasks include image enhancement (e.g. panchromatic sharpening, contrast adjustments), image mosaicing, numerous filtering operations, simple classification (k-means), and common image transformations. *WhiteboxTools* also contains advanced tooling for spatial hydrological analysis (e.g. flow-accumulation, watershed delineation, stream network analysis, sink removal), terrain analysis (e.g. common terrain indices such as slope, curvatures, wetness index, hillshading; hypsometric analysis; multi-scale topographic position analysis), and LiDAR data processing. LiDAR point clouds can be interrogated (LidarInfo, LidarHistogram), segmented, tiled and joined, analyized for outliers, interpolated to rasters (DEMs, intensity images), and ground-points can be classified or filtered. *WhiteboxTools* is not a cartographic or spatial data visualization package; instead it is meant to serve as an analytical backend for other data visualization software, mainly GIS. Suggested citation: Lindsay, J. B. (2016). Whitebox GAT: A case study in geomorphometric analysis. _Computers & Geosciences_, 95, 75-84. doi:[10.1016/j.cageo.2016.07.003](http://dx.doi.org/10.1016/j.cageo.2016.07.003).

## Installation

There are three ways to install the **whitebox** R package.

### 1. CRAN

**whitebox** will be available on CRAN soon. Once it is available on CRAN, you can install it with:

```R
install.packages("whitebox")
```

### 2. R-Forge

**whitebox** is now available on [R-Forge](https://r-forge.r-project.org/R/?group_id=2337), so you can install it with:

```R
install.packages("whitebox", repos="http://R-Forge.R-project.org")
```

### 3. GitHub

You can alternatively install the development version of **whitebox** from [GitHub](https://github.com/giswqs/whiteboxR) as follows:

```R
if (!require(devtools)) install.packages('devtools')
devtools::install_github("giswqs/whiteboxR")
```

You’ll also need to make sure your machine is able to build packages from source. See [Package Development Prerequisites](http://www.rstudio.com/ide/docs/packages/prerequisites) for the tools needed for your operating system.

## Usage

A complete list of functions available in the **whitebox** R package can be found [HERE](https://giswqs.github.io/whiteboxR/reference/index.html). Check out this [demo](https://giswqs.github.io/whiteboxR/articles/demo.html) for examples.

**About WhiteboxTools?**

```R
library(whitebox)

# Prints the whitebox-tools help...a listing of available commands
print(wbt_help())

# Prints the whitebox-tools license
print(wbt_license())

# Prints the whitebox-tools version
print(wbt_version())

# Prints the toolbox for a specific tool.
print(wbt_toolbox())

# List all available tools in whitebox-tools
print(wbt_list_tools())

# Lists tools with 'lidar' in tool name or description.
print(wbt_list_tools("lidar"))

# Prints the help for a specific tool.
print(wbt_tool_help("lidar_info"))

# Retrieves the tool parameter descriptions for a specific tool.
print(wbt_tool_parameters("slope"))

# View the source code for a specific tool on the source code repository.
print(wbt_view_code("breach_depressions"))
```

**How to run tools?**


Tool names in the whitebox R package can be called using the snake_case (e.g. lidar_info). See below for an example. If you are interested in using the WhiteboxTools command-line program, check [WhiteboxTools Usage](https://github.com/jblindsay/whitebox-tools#3-usage).

```R
library(whitebox)

# Set input raster DEM file
dem <- system.file("extdata", "DEM.tif", package="whitebox")

# Run tools
feature_preserving_denoise(dem, "./smoothed.tif", filter=9)
breach_depressions("./smoothed.tif", "./breached.tif")
d_inf_flow_accumulation(dem, "./flow_accum.tif", verbose_mode = FALSE)
```


## Available Tools

The **[WhiteboxTools](https://github.com/jblindsay/whitebox-tools)** library currently contains more than 396 tools, which are each grouped based on their main function into one of the following categories: Data Tools, GIS Analysis, Hydrological Analysis, Image Analysis, LiDAR Analysis, Mathematical and Statistical Analysis, Stream Network Analysis, and Terrain Analysis. The following is a complete listing of available tools, with brief tool descriptions.

**Data Tools**

- ***AddPointCoordinatesToTable***: Modifies the attribute table of a point vector by adding fields containing each point's X and Y coordinates.
- ***ConvertNodataToZero***: Converts nodata values in a raster to zero.
- ***ConvertRasterFormat***: Converts raster data from one format to another.
- ***ExportTableToCsv***: Exports an attribute table to a CSV text file.
- ***JoinTables***: Merge a vector's attribute table with another table based on a common field.
- ***LinesToPolygons***: Converts vector polylines to polygons.
- ***MergeTableWithCsv***: Merge a vector's attribute table with a table contained within a CSV text file.
- ***MergeVectors***: Combines two or more input vectors of the same ShapeType creating a single, new output vector.
- ***MultiPartToSinglePart***: Converts a vector file containing multi-part features into a vector containing only single-part features.
- ***NewRasterFromBase***: Creates a new raster using a base image.
- ***PolygonsToLines***: Converts vector polygons into polylines.
- ***PrintGeoTiffTags***: Prints the tags within a GeoTIFF.
- ***RasterToVectorLines***: Converts a raster lines features into vector of the POLYLINE shapetype.
- ***RasterToVectorPoints***: Converts a raster dataset to a vector of the POINT shapetype.
- ***ReinitializeAttributeTable***: initializes a vector's attribute table deleting all fields but the feature ID (FID).
- ***RemovePolygonHoles***: Removes holes within the features of a vector polygon file.
- ***SetNodataValue***: Assign a specified value in an input image to the NoData value.
- ***SinglePartToMultiPart***: Converts a vector file containing multi-part features into a vector containing only single-part features.
- ***VectorLinesToRaster***: Converts a vector containing polylines into a raster.
- ***VectorPointsToRaster***: Converts a vector containing points into a raster.
- ***VectorPolygonsToRaster***: Converts a vector containing polygons into a raster.

**Geomorphometric Analysis**

- ***Aspect***: Calculates an aspect raster from an input DEM.
- ***DevFromMeanElev***: Calculates deviation from mean elevation.
- ***DiffFromMeanElev***: Calculates difference from mean elevation (equivalent to a high-pass filter).
- ***DirectionalRelief***: Calculates relief for cells in an input DEM for a specified direction.
- ***DrainagePreservingSmoothing***: Reduces short-scale variation in an input DEM while preserving breaks-in-slope and small drainage features using a modified Sun et al. (2007) algorithm.
- ***DownslopeIndex***: Calculates the Hjerdt et al. (2004) downslope index.
- ***ElevAbovePit***: Calculate the elevation of each grid cell above the nearest downstream pit cell or grid edge cell.
- ***ElevPercentile***: Calculates the elevation percentile raster from a DEM.
- ***ElevRelativeToMinMax***: Calculates the elevation of a location relative to the minimum and maximum elevations in a DEM.
- ***ElevRelativeToWatershedMinMax***: Calculates the elevation of a location relative to the minimum and maximum elevations in a watershed.
- ***FeaturePreservingDenoise***: Reduces short-scale variation in an input DEM using a modified Sun et al. (2007) algorithm.
- ***FetchAnalysis***: Performs an analysis of fetch or upwind distance to an obstacle.
- ***FillMissingData***: Fills nodata holes in a DEM.
- ***FindRidges***: Identifies potential ridge and peak grid cells.
- ***Hillshade***: Calculates a hillshade raster from an input DEM.
- ***HorizonAngle***: Calculates horizon angle (maximum upwind slope) for each grid cell in an input DEM.
- ***HypsometricAnalysis***: Calculates a hypsometric curve for one or more DEMs.
- ***MaxAnisotropyDev***: Calculates the maximum anisotropy (directionality) in elevation deviation over a range of spatial scales.
- ***MaxAnisotropyDevSignature***: Calculates the anisotropy in deviation from mean for points over a range of spatial scales.
- ***MaxBranchLength***: Lindsay and Seibert's (2013) branch length index is used to map drainage divides or ridge lines.
- ***MaxDifferenceFromMean***: Calculates the maximum difference from mean elevation over a range of spatial scales.
- ***MaxDownslopeElevChange***: Calculates the maximum downslope change in elevation between a grid cell and its eight downslope neighbors.
- ***MaxElevationDeviation***: Calculates the maximum elevation deviation over a range of spatial scales.
- ***MaxElevDevSignature***: Calculates the maximum elevation deviation over a range of spatial scales and for a set of points.
- ***MinDownslopeElevChange***: Calculates the minimum downslope change in elevation between a grid cell and its eight downslope neighbors.
- ***MultiscaleRoughness***: Calculates surface roughness over a range of spatial scales.
- ***MultiscaleRoughnessSignature***: Calculates the surface roughness for points over a range of spatial scales.
- ***MultiscaleTopographicPositionImage***: Creates a multiscale topographic position image from three DEVmax rasters of differing spatial scale ranges.
- ***NumDownslopeNeighbours***: Calculates the number of downslope neighbours to each grid cell in a DEM.
- ***NumUpslopeNeighbours***: Calculates the number of upslope neighbours to each grid cell in a DEM.
- ***PennockLandformClass***: Classifies hillslope zones based on slope, profile curvature, and plan curvature.
- ***PercentElevRange***: Calculates percent of elevation range from a DEM.
- ***PlanCurvature***: Calculates a plan (contour) curvature raster from an input DEM.
- ***ProfileCurvature***: Calculates a profile curvature raster from an input DEM.
- ***Profile***: Plots profiles from digital surface models.
- ***RelativeAspect***: Calculates relative aspect (relative to a user-specified direction) from an input DEM.
- ***RelativeStreamPowerIndex***: Calculates the relative stream power index.
- ***RelativeTopographicPosition***: Calculates the relative topographic position index from a DEM.
- ***RuggednessIndex***: Calculates the Riley et al.'s (1999) terrain ruggedness index from an input DEM.
- ***RemoveOffTerrainObjects***: Removes off-terrain objects from a raster digital elevation model (DEM).
- ***SedimentTransportIndex***: Calculates the sediment transport index.
- ***Slope***: Calculates a slope raster from an input DEM.
- ***SlopeVsElevationPlot***: Creates a slope vs. elevation plot for one or more DEMs.
- ***StandardDeviationOfSlope***: Calculates the standard deviation of slope from an input DEM.
- ***TangentialCurvature***: Calculates a tangential curvature raster from an input DEM.
- ***TotalCurvature***: Calculates a total curvature raster from an input DEM.
- ***Viewshed***: Identifies the viewshed for a point or set of points.
- ***VisibilityIndex***: Estimates the relative visibility of sites in a DEM.
- ***WetnessIndex***: Calculates the topographic wetness index, Ln(A / tan(slope)).

**GIS Analysis**

- ***AggregateRaster***: Aggregates a raster to a lower resolution.
- ***AverageOverlay***: Calculates the average for each grid cell from a group of raster images.
- ***BlockMaximumGridding***: Creates a raster grid based on a set of vector points and assigns grid values using a block maximum scheme.
- ***BlockMinimumGridding***: Creates a raster grid based on a set of vector points and assigns grid values using a block minimum scheme.
- ***BufferRaster***: Maps a distance-based buffer around each non-background (non-zero/non-nodata) grid cell in an input image.
- ***Centroid***: Calculates the centroid, or average location, of raster polygon objects.
- ***CentroidVector***: Identifes the centroid point of a vector polyline or polygon feature or a group of vector points.
- ***Clip***: Extract all the features, or parts of features, that overlap with the features of the clip vector.
- ***ClipRasterToPolygon***: Clips a raster to a vector polygon.
- ***Clump***: Groups cells that form physically discrete areas, assigning them unique identifiers.
- ***CompactnessRatio***: Calculates the compactness ratio (A/P), a measure of shape complexity, for vector polygons.
- ***ConstructVectorTin***: This tool creates a vector triangular irregular network (TIN) for a set of vector points.
- ***CountIf***: Counts the number of occurrences of a specified value in a cell-stack of rasters.
- ***CostAllocation***: Identifies the source cell to which each grid cell is connected by a least-cost pathway in a cost-distance analysis.
- ***CostDistance***: Performs cost-distance accumulation on a cost surface and a group of source cells.
- ***CostPathway***: Performs cost-distance pathway analysis using a series of destination grid cells.
- ***CreateHexagonalVectorGrid***: Creates an hexagonal vector grid.
- ***CreatePlane***: Creates a raster image based on the equation for a simple plane.
- ***CreateRectangularVectorGrid***: Creates a rectangular vector grid.
- ***Dissolve***: Removes the interior, or shared, boundaries within a vector polygon coverage.
- ***EdgeProportion***: Calculate the proportion of cells in a raster polygon that are edge cells.
- ***EliminateCoincidentPoints***: Removes any coincident, or nearly coincident, points from a vector points file.
- ***ElongationRatio***: Calculates the elongation ratio for vector polygons.
- ***Erase***: Removes all the features, or parts of features, that overlap with the features of the erase vector polygon.
- ***ErasePolygonFromRaster***: Erases (cuts out) a vector polygon from a raster.
- ***EuclideanAllocation***: Assigns grid cells in the output raster the value of the nearest target cell in the input image, measured by the Shih and Wu (2004) Euclidean distance transform. 
- ***EuclideanDistance***: Calculates the Shih and Wu (2004) Euclidean distance transform.
- ***ExtendVectorLines***: Extends vector lines by a specified distance.
- ***ExtractNodes***: Converts vector lines or polygons into vertex points.
- ***ExtractRasterValuesAtPoints***: Extracts the values of raster(s) at vector point locations.
- ***FindLowestOrHighestPoints***: Locates the lowest and/or highest valued cells in a raster.
- ***FindPatchOrClassEdgeCells***: Finds all cells located on the edge of patch or class features.
- ***HighestPosition***: Identifies the stack position of the maximum value within a raster stack on a cell-by-cell basis.
- ***HoleProportion***: Calculates the proportion of the total area of a polygon's holes relative to the area of the polygon's hull.
- ***IdwInterpolation***: Interpolates vector points into a raster surface using an inverse-distance weighted scheme.
- ***Intersect***: Identifies the parts of features in common between two input vector layers.
- ***LayerFootprint***: Creates a vector polygon footprint of the area covered by a raster grid or vector layer.
- ***LinearityIndex***: Calculates the linearity index for vector polygons.
- ***LineIntersections***: Identifies points where the features of two vector line layers intersect.
- ***LowestPosition***: Identifies the stack position of the minimum value within a raster stack on a cell-by-cell basis.
- ***MaxAbsoluteOverlay***: Evaluates the maximum absolute value for each grid cell from a stack of input rasters.
- ***MaxOverlay***: Evaluates the maximum value for each grid cell from a stack of input rasters.
- ***Medoid***: Calculates the medoid for a series of vector features contained in a shapefile.
- ***MinAbsoluteOverlay***: Evaluates the minimum absolute value for each grid cell from a stack of input rasters.
- ***MinimumBoundingBox***: Creates a vector minimum bounding rectangle around vector features.
- ***MinimumBoundingCircle***: Delineates the minimum bounding circle (i.e. smallest enclosing circle) for a group of vectors.
- ***MinimumBoundingEnvelope***: Creates a vector axis-aligned minimum bounding rectangle (envelope) around vector features.
- ***MinimumConvexHull***: Creates a vector convex polygon around vector features.
- ***MinOverlay***: Evaluates the minimum value for each grid cell from a stack of input rasters.
- ***NearestNeighbourGridding***: Creates a raster grid based on a set of vector points and assigns grid values using the nearest neighbour.
- ***PatchOrientation***: Calculates the orientation of vector polygons.
- ***PercentEqualTo***: Calculates the percentage of a raster stack that have cell values equal to an input on a cell-by-cell basis.
- ***PercentGreaterThan***: Calculates the percentage of a raster stack that have cell values greater than an input on a cell-by-cell basis.
- ***PercentLessThan***: Calculates the percentage of a raster stack that have cell values less than an input on a cell-by-cell basis.
- ***PerimeterAreaRatio***: Calculates the perimeter-area ratio of vector polygons.
- ***PickFromList***: Outputs the value from a raster stack specified by a position raster.
- ***PolygonArea***: Calculates the area of vector polygons.
- ***PolygonLongAxis***: This tool can be used to map the long axis of polygon features.
- ***PolygonPerimeter***: Calculates the perimeter of vector polygons.
- ***PolygonShortAxis***: This tool can be used to map the short axis of polygon features.
- ***Polygonize***: Creates a polygon layer from two or more intersecting line features contained in one or more input vector line files.
- ***RadiusOfGyration***: Calculates the distance of cells from their polygon's centroid.
- ***RasterCellAssignment***: Assign row or column number to cells.
- ***Reclass***: Reclassifies the values in a raster image.
- ***ReclassEqualInterval***: Reclassifies the values in a raster image based on equal-ranges.
- ***ReclassFromFile***: Reclassifies the values in a raster image using reclass ranges in a text file.
- ***RelatedCircumscribingCircle***: Calculates the related circumscribing circle of vector polygons.
- ***ShapeComplexityIndex***: Calculates overall polygon shape complexity or irregularity.
- ***SmoothVectors***: Smooths a vector coverage of either a POLYLINE or POLYGON base ShapeType.
- ***SplitWithLines***: Splits the lines or polygons in one layer using the lines in another layer
- ***SumOverlay***: Calculates the sum for each grid cell from a group of raster images.
- ***SymmetricalDifference***: Outputs the features that occur in one of the two vector inputs but not both, i.e. no overlapping features.
- ***TINGridding***: Creates a raster grid based on a triangular irregular network (TIN) fitted to vector points.
- ***Union***: Splits vector layers at their overlaps, creating a layer containing all the portions from both input and overlay layers.
- ***VectorHexBinning***: Hex-bins a set of vector points.
- ***VoronoiDiagram***: s tool creates a vector Voronoi diagram for a set of vector points.
- ***WeightedOverlay***: Performs a weighted sum on multiple input rasters after converting each image to a common scale. The tool performs a multi-criteria evaluation (MCE).
- ***WeightedSum***: Performs a weighted-sum overlay on multiple input raster images.

**Hydrological Analysis**

- ***AverageFlowpathSlope***: measures the average length of all upslope flowpaths draining each grid cell.
- ***AverageUpslopeFlowpathLength***: Measures the average length of all upslope flowpaths draining each grid cell.
- ***Basins***: Identifies drainage basins that drain to the DEM edge.
- ***BreachDepressions***: Breaches all of the depressions in a DEM using Lindsay's (2016) algorithm. This should be preferred over depression filling in most cases.
- ***BreachSingleCellPits***: Removes single-cell pits from an input DEM by breaching.
- ***D8FlowAccumulation***: Calculates a D8 flow accumulation raster from an input DEM.
- ***D8MassFlux***: Performs a D8 mass flux calculation.
- ***D8Pointer***: Calculates a D8 flow pointer raster from an input DEM.
- ***DepthInSink***: Measures the depth of sinks (depressions) in a DEM.
- ***DInfFlowAccumulation***: Calculates a D-infinity flow accumulation raster from an input DEM.
- ***DInfMassFlux***: Performs a D-infinity mass flux calculation.
- ***DInfPointer***: Calculates a D-infinity flow pointer (flow direction) raster from an input DEM.
- ***DownslopeDistanceToStream***: Measures distance to the nearest downslope stream cell.
- ***DownslopeFlowpathLength***: Calculates the downslope flowpath length from each cell to basin outlet.
- ***ElevationAboveStream***: Calculates the elevation of cells above the nearest downslope stream cell.
- ***ElevationAboveStreamEuclidean***: Calculates the elevation of cells above the nearest (Euclidean distance) stream cell.
- ***FD8FlowAccumulation***: Calculates a FD8 flow accumulation raster from an input DEM.
- ***FD8Pointer***: Calculates an FD8 flow pointer raster from an input DEM.
- ***FillBurn***: Burns streams into a DEM using the FillBurn (Saunders, 1999) method.
- ***FillDepressions***: Fills all of the depressions in a DEM. Depression breaching should be preferred in most cases.
- ***FillSingleCellPits***: Raises pit cells to the elevation of their lowest neighbour.
- ***FindNoFlowCells***: Finds grid cells with no downslope neighbours.
- ***FindParallelFlow***: Finds areas of parallel flow in D8 flow direction rasters.
- ***FlattenLakes***: Flattens lake polygons in a raster DEM.
- ***FloodOrder***: Assigns each DEM grid cell its order in the sequence of inundations that are encountered during a search starting from the edges, moving inward at increasing elevations.
- ***FlowAccumulationFullWorkflow***: Resolves all of the depressions in a DEM, outputting a breached DEM, an aspect-aligned non-divergent flow pointer, a flow accumulation raster.
- ***FlowLengthDiff***: Calculates the local maximum absolute difference in downslope flowpath length, useful in mapping drainage divides and ridges.
- ***Hillslopes***: Identifies the individual hillslopes draining to each link in a stream network.
- ***ImpoundmentIndex***: Calculates the impoundment size resulting from damming a DEM.
- ***Isobasins***: Divides a landscape into nearly equal sized drainage basins (i.e. watersheds).
- ***JensonSnapPourPoints***: Moves outlet points used to specify points of interest in a watershedding operation to the nearest stream cell.
- ***MaxUpslopeFlowpathLength***: Measures the maximum length of all upslope flowpaths draining each grid cell.
- ***LongestFlowpath***: Delineates the longest flowpaths for a group of subbasins or watersheds. 
- ***NumInflowingNeighbours***: Computes the number of inflowing neighbours to each cell in an input DEM based on the D8 algorithm.
- ***RaiseWalls***: Raises walls in a DEM along a line or around a polygon, e.g. a watershed.
- ***Rho8Pointer***: Calculates a stochastic Rho8 flow pointer raster from an input DEM.
- ***Sink***: Identifies the depressions in a DEM, giving each feature a unique identifier.
- ***SnapPourPoints***: Moves outlet points used to specify points of interest in a watershedding operation to the cell with the highest flow accumulation in its neighbourhood.
- ***StochasticDepressionAnalysis***: Preforms a stochastic analysis of depressions within a DEM.
- ***StrahlerOrderBasins***: Identifies Strahler-order basins from an input stream network.
- ***Subbasins***: Identifies the catchments, or sub-basin, draining to each link in a stream network.
- ***TraceDownslopeFlowpaths***: Traces downslope flowpaths from one or more target sites (i.e. seed points).
- ***UnnestBasins***: Extract whole watersheds for a set of outlet points.
- ***Watershed***: Identifies the watershed, or drainage basin, draining to a set of target cells.

**Image Analysis**

- ***AdaptiveFilter***: Performs an adaptive filter on an image.
- ***BalanceContrastEnhancement***: Performs a balance contrast enhancement on a colour-composite image of multispectral data.
- ***BilateralFilter***: A bilateral filter is an edge-preserving smoothing filter introduced by Tomasi and Manduchi (1998).
- ***ChangeVectorAnalysis***: Performs a change vector analysis on a two-date multi-spectral dataset.
- ***Closing***: A closing is a mathematical morphology operating involving an erosion (min filter) of a dilation (max filter) set.
- ***ConservativeSmoothingFilter***: Performs a conservative smoothing filter on an image.
- ***CornerDetection***: Identifies corner patterns in boolean images using hit-and-miss pattern mattching.
- ***CorrectVignetting*** Corrects the darkening of images towards corners.
- ***CreateColourComposite***: Creates a colour-composite image from three bands of multispectral imagery.
- ***DirectDecorrelationStretch***: Performs a direct decorrelation stretch enhancement on a colour-composite image of multispectral data.
- ***DiffOfGaussianFilter***: Performs a Difference of Gaussian (DoG) filter on an image.
- ***DiversityFilter***: Assigns each cell in the output grid the number of different values in a moving window centred on each grid cell in the input raster.
- ***EdgePreservingMeanFilter***: Performs a simple edge-preserving mean filter on an input image.
- ***EmbossFilter***: Performs an emboss filter on an image, similar to a hillshade operation.
- ***FastAlmostGaussianFilter***: Performs a fast approximate Gaussian filter on an image.
- ***FlipImage***: Reflects an image in the vertical or horizontal axis.
- ***GammaCorrection***: Performs a sigmoidal contrast stretch on input images.
- ***GaussianContrastStretch***: Performs a Gaussian contrast stretch on input images.
- ***GaussianFilter***: Performs a Gaussian filter on an image.
- ***HighPassFilter***: Performs a high-pass filter on an input image.
- ***HighPassMedianFilter***: Performs a high-pass median filter on an input image.
- ***HistogramEqualization***: Performs a histogram equalization contrast enhancement on an image.
- ***HistogramMatching***: Alters the statistical distribution of a raster image matching it to a specified PDF.
- ***HistogramMatchingTwoImages***: This tool alters the cumulative distribution function of a raster image to that of another image.
- ***IhsToRgb***: Converts intensity, hue, and saturation (IHS) images into red, green, and blue (RGB) images.
- ***ImageStackProfile***: Plots an image stack profile (i.e. signature) for a set of points and multispectral images.
- ***IntegralImage***: Transforms an input image (summed area table) into its integral image equivalent.
- ***KMeansClustering***: Performs a k-means clustering operation on a multi-spectral dataset.
- ***KNearestMeanFilter***: A k-nearest mean filter is a type of edge-preserving smoothing filter.
- ***LaplacianFilter***: Performs a Laplacian filter on an image.
- ***LaplacianOfGaussianFilter***: Performs a Laplacian-of-Gaussian (LoG) filter on an image.
- ***LeeFilter***: Performs a Lee (Sigma) smoothing filter on an image.
- ***LineDetectionFilter***: Performs a line-detection filter on an image.
- ***LineThinning***: Performs line thinning a on Boolean raster image; intended to be used with the RemoveSpurs tool.
- ***MajorityFilter***: Assigns each cell in the output grid the most frequently occurring value (mode) in a moving window centred on each grid cell in the input raster.
- ***MaximumFilter***: Assigns each cell in the output grid the maximum value in a moving window centred on each grid cell in the input raster.
- ***MeanFilter***: Performs a mean filter (low-pass filter) on an input image.
- ***MedianFilter***: Performs a median filter on an input image.
- ***MinMaxContrastStretch***: Performs a min-max contrast stretch on an input greytone image.
- ***MinimumFilter***: Assigns each cell in the output grid the minimum value in a moving window centred on each grid cell in the input raster.
- ***ModifiedKMeansClustering***: Performs a modified k-means clustering operation on a multi-spectral dataset.
- ***Mosaic***: Mosaics two or more images together.
- ***MosaicWithFeathering***: Mosaics two images together using a feathering technique in overlapping areas to reduce edge-effects.
- ***OlympicFilter***: Performs an olympic smoothing filter on an image.
- ***Opening***: An opening is a mathematical morphology operating involving a dilation (max filter) of an erosion (min filter) set.
- ***NormalizedDifferenceVegetationIndex***: Calculates the normalized difference vegetation index (NDVI) from near-infrared and red imagery.
- ***PanchromaticSharpening***: Increases the spatial resolution of image data by combining multispectral bands with panchromatic data.
- ***PercentageContrastStretch***: Performs a percentage linear contrast stretch on input images.
- ***PercentileFilter***: Performs a percentile filter on an input image.
- ***PrewittFilter***: Performs a Prewitt edge-detection filter on an image.
- ***RangeFilter***: Assigns each cell in the output grid the range of values in a moving window centred on each grid cell in the input raster.
- ***RemoveSpurs***: Removes the spurs (pruning operation) from a Boolean line image.; intended to be used on the output of the LineThinning tool.
- ***Resample***: Resamples one or more input images into a destination image.
- ***RgbToIhs***: Converts red, green, and blue (RGB) images into intensity, hue, and saturation (IHS) images.
- ***RobertsCrossFilter***: Performs a Robert's cross edge-detection filter on an image.
- ***ScharrFilter***: Performs a Scharr edge-detection filter on an image.
- ***SigmoidalContrastStretch***: Performs a sigmoidal contrast stretch on input images.
- ***SobelFilter***: Performs a Sobel edge-detection filter on an image.
- ***SplitColourComposite***: This tool splits an RGB colour composite image into seperate multispectral images.
- ***StandardDeviationContrastStretch***: Performs a standard-deviation contrast stretch on input images.
- ***StandardDeviationFilter***: Assigns each cell in the output grid the standard deviation of values in a moving window centred on each grid cell in the input raster.
- ***ThickenRasterLine***: Thickens single-cell wide lines within a raster image.
- ***TophatTransform***: Performs either a white or black top-hat transform on an input image
- ***TotalFilter***: Performs a total filter on an input image.
- ***UnsharpMasking***: An image sharpening technique that enhances edges.
- ***UserDefinedWeightsFilter***: Performs a user-defined weights filter on an image.
- ***WriteFunctionMemoryInsertion***: Performs a write function memory insertion for single-band multi-date change detection.

**LiDAR Analysis**

- ***ClassifyOverlapPoints***: Classifies or filters LAS point in regions of overlapping flight lines.
- ***ClipLidarToPolygon***: Clips a LiDAR point cloud to a vector polygon or polygons.
- ***ErasePolygonFromLidar***: Erases (cuts out) a vector polygon or polygons from a LiDAR point cloud.
- ***FilterLidarScanAngles***: Removes points in a LAS file with scan angles greater than a threshold.
- ***FindFlightlineEdgePoints***: Identifies points along a flightline's edge in a LAS file.
- ***FlightlineOverlap***: Reads a LiDAR (LAS) point file and outputs a raster containing the number of overlapping flight lines in each grid cell.
- ***LasToAscii***: Converts one or more LAS files into ASCII text files.
- **LasToMultipointShapefile**: Converts one or more LAS files into MultipointZ vector Shapefiles.
- ***LasToShapefile***: Converts one or more LAS files into a vector Shapefile of POINT ShapeType.
- ***LidarBlockMaximum***: Creates a block-maximum raster from an input LAS file.
- ***LidarBlockMinimum***: Creates a block-minimum raster from an input LAS file.
- ***LidarClassifySubset***: Classifies the values in one LiDAR point cloud that correpond with points in a subset cloud.
- ***LidarColourize***: Adds the red-green-blue colour fields of a LiDAR (LAS) file based on an input image.
- ***LidarConstructVectorTIN***: Creates a vector triangular irregular network (TIN) fitted to LiDAR points.
- ***LidarElevationSlice***: Outputs all of the points within a LiDAR (LAS) point file that lie between a specified elevation range.
- ***LidarGroundPointFilter***: Identifies ground points within LiDAR dataset.
- ***LidarIdwInterpolation***: Interpolates LAS files using an inverse-distance weighted (IDW) scheme.
- ***LidarHexBinning***: Hex-bins a set of LiDAR points.
- ***LidarHillshade***: Calculates a hillshade value for points within a LAS file and stores these data in the RGB field.
- ***LidarHistogram***: Creates a histogram from LiDAR data.
- ***LidarInfo***: Prints information about a LiDAR (LAS) dataset, including header, point return frequency, and classification data and information about the variable length records (VLRs) and geokeys.
- ***LidarJoin***: Joins multiple LiDAR (LAS) files into a single LAS file.
- ***LidarKappaIndex***: Performs a kappa index of agreement (KIA) analysis on the classifications of two LAS files.
- ***LidarNearestNeighbourGridding***: Grids LAS files using nearest-neighbour scheme.
- ***LidarPointDensity***: Calculates the spatial pattern of point density for a LiDAR data set.
- ***LidarPointStats***: Creates several rasters summarizing the distribution of LAS point data.
- ***LidarRemoveDuplicates***: Removes duplicate points from a LiDAR data set.
- ***LidarRemoveOutliers***: Removes outliers (high and low points) in a LiDAR point cloud.
- ***LidarSegmentation***: Segments a LiDAR point cloud based on normal vectors.
- ***LidarSegmentationBasedFilter***: Identifies ground points within LiDAR point clouds using a segmentation based approach.
- ***LidarThin***: Thins a LiDAR point cloud, reducing point density.
- ***LidarThinHighDensity***: Thins points from high density areas within a LiDAR point cloud.
- ***LidarTile***: Tiles a LiDAR LAS file into multiple LAS files.
- ***LidarTileFootprint***: Creates a vector polygon of the convex hull of a LiDAR point cloud.
- ***LidarTinGridding***: Creates a raster grid based on a triangular irregular network (TIN) fitted to LiDAR points.
- ***LidarTophatTransform***: Performs a white top-hat transform on a Lidar dataset; as an estimate of height above ground, this is useful for modelling the vegetation canopy.
- ***NormalVectors***: Calculates normal vectors for points within a LAS file and stores these data (XYZ vector components) in the RGB field.
- ***SelectTilesByPolygon***: Copies LiDAR tiles overlapping with a polygon into an output directory.

**Mathematical and Statistical Analysis**

- ***AbsoluteValue***: Calculates the absolute value of every cell in a raster.
- ***Add***: Performs an addition operation on two rasters or a raster and a constant value.
- ***And***: Performs a logical AND operator on two Boolean raster images.
- ***Anova***: Performs an analysis of variance (ANOVA) test on a raster dataset.
- ***ArcCos***: Returns the inverse cosine (arccos) of each values in a raster.
- ***ArcSin***: Returns the inverse sine (arcsin) of each values in a raster.
- ***ArcTan***: Returns the inverse tangent (arctan) of each values in a raster.
- ***Atan2***: Returns the 2-argument inverse tangent (atan2).
- ***AttributeCorrelation***: Performs a correlation analysis on attribute fields from a vector database.
- ***AttributeHistogram***: Creates a histogram for the field values of a vector's attribute table.
- ***AttributeScattergram***: Creates a scattergram for two field values of a vector's attribute table.
- ***Ceil***: Returns the smallest (closest to negative infinity) value that is greater than or equal to the values in a raster.
- ***Cos***: Returns the cosine (cos) of each values in a raster.
- ***Cosh***: Returns the hyperbolic cosine (cosh) of each values in a raster.
- ***CrispnessIndex***: Calculates the Crispness Index, which is used to quantify how crisp (or conversely how fuzzy) a probability image is.
- ***CrossTabulation***: Performs a cross-tabulation on two categorical images.
- ***CumulativeDistribution***: Converts a raster image to its cumulative distribution function.
- ***Decrement***: Decreases the values of each grid cell in an input raster by 1.0.
- ***Divide***: Performs a division operation on two rasters or a raster and a constant value.
- ***EqualTo***: Performs a equal-to comparison operation on two rasters or a raster and a constant value.
- ***Exp***: Returns the exponential (base e) of values in a raster.
- ***Exp2***: Returns the exponential (base 2) of values in a raster.
- ***ExtractRasterStatistics***: Extracts descriptive statistics for a group of patches in a raster.
- ***Floor***: Returns the largest (closest to positive infinity) value that is greater than or equal to the values in a raster.
- ***GreaterThan***: Performs a greater-than comparison operation on two rasters or a raster and a constant value.
- ***ImageAutocorrelation***: Performs Moran's I analysis on two or more input images.
- ***ImageCorrelation***: Performs image correlation on two or more input images.
- ***ImageRegression***: Performs image regression analysis on two input images.
- ***Increment***: Increases the values of each grid cell in an input raster by 1.0.
- ***InPlaceAdd***: Performs an in-place addition operation (input1 += input2).
- ***InPlaceDivide***: Performs an in-place division operation (input1 /= input2).
- ***InPlaceMultiply***: Performs an in-place multiplication operation (input1 *= input2).
- ***InPlaceSubtract***: Performs an in-place subtraction operation (input1 -= input2).
- ***IntegerDivision***: Performs an integer division operation on two rasters or a raster and a constant value.
- ***IsNoData***: Identifies NoData valued pixels in an image.
- ***KappaIndex***: Performs a kappa index of agreement (KIA) analysis on two categorical raster files.
- ***KSTestForNormality***: Evaluates whether the values in a raster are normally distributed.
- ***LessThan***: Performs a less-than comparison operation on two rasters or a raster and a constant value.
- ***ListUniqueValues***: Lists the unique values contained in a field witin a vector's attribute table.
- ***Log10***: Returns the base-10 logarithm of values in a raster.
- ***Log2***: Returns the base-2 logarithm of values in a raster.
- ***Ln***: Returns the natural logarithm of values in a raster.
- ***Max***: Performs a MAX operation on two rasters or a raster and a constant value.
- ***Min***: Performs a MIN operation on two rasters or a raster and a constant value.
- ***Modulo***: Performs a modulo operation on two rasters or a raster and a constant value.
- ***Multiply***: Performs a multiplication operation on two rasters or a raster and a constant value.
- ***Negate***: Changes the sign of values in a raster or the 0-1 values of a Boolean raster.
- ***Not***: Performs a logical NOT operator on two Boolean raster images.
- ***NotEqualTo***: Performs a not-equal-to comparison operation on two rasters or a raster and a constant value.
- ***Or***: Performs a logical OR operator on two Boolean raster images.
- ***Power***: Raises the values in grid cells of one rasters, or a constant value, by values in another raster or constant value.
- ***PrincipalComponentAnalysis***: Performs a principal component analysis (PCA) on a multi-spectral dataset.
- ***Quantiles***: Transforms raster values into quantiles.
- ***RandomField***: Creates an image containing random values.
- ***RandomSample***: Creates an image containing randomly located sample grid cells with unique IDs.
- ***RasterHistogram***: Creates a histogram from raster values.
- ***RasterSummaryStats***: Measures a rasters average, standard deviation, num. non-nodata cells, and total.
- ***Reciprocal***: Returns the reciprocal (i.e. 1 / z) of values in a raster.
- ***RescaleValueRange***: Performs a min-max contrast stretch on an input greytone image.
- ***RootMeanSquareError***: Calculates the RMSE and other accuracy statistics.
- ***Round***: Rounds the values in an input raster to the nearest integer value.
- ***Sin***: Returns the sine (sin) of each values in a raster.
- ***Sinh***: Returns the hyperbolic sine (sinh) of each values in a raster.
- ***Square***: Squares the values in a raster.
- ***SquareRoot***: Returns the square root of the values in a raster.
- ***Subtract***: Performs a subtraction operation on two rasters or a raster and a constant value.
- ***Tan***: Returns the tangent (tan) of each values in a raster.
- ***Tanh***: Returns the hyperbolic tangent (tanh) of each values in a raster.
- ***ToDegrees***: Converts a raster from radians to degrees.
- ***ToRadians***: Converts a raster from degrees to radians.
- ***TrendSurface***: Estimates the trend surface of an input raster file.
- ***TrendSurfaceVectorPoints***: Estimates a trend surface from vector points.
- ***Truncate***: Truncates the values in a raster to the desired number of decimal places.
- ***TurningBandsSimulation***: Creates an image containing random values based on a turning-bands simulation.
- ***Xor***: Performs a logical XOR operator on two Boolean raster images.
- ***ZScores***: Standardizes the values in an input raster by converting to z-scores.

**Stream Network Analysis**

- ***DistanceToOutlet***: Calculates the distance of stream grid cells to the channel network outlet cell.
- ***ExtractStreams***: Extracts stream grid cells from a flow accumulation raster.
- ***ExtractValleys***: Identifies potential valley bottom grid cells based on local topolography alone.
- ***FarthestChannelHead***: Calculates the distance to the furthest upstream channel head for each stream cell.
- ***FindMainStem***: Finds the main stem, based on stream lengths, of each stream network.
- ***HackStreamOrder***: Assigns the Hack stream order to each link in a stream network.
- ***HortonStreamOrder***: Assigns the Horton stream order to each link in a stream network.
- ***LengthOfUpstreamChannels***: Calculates the total length of channels upstream.
- ***LongProfile***: Plots the stream longitudinal profiles for one or more rivers.
- ***LongProfileFromPoints***: Plots the longitudinal profiles from flow-paths initiating from a set of vector points.
- ***RasterizeStreams***: Rasterizes vector streams based on Lindsay (2016) method.
- ***RasterStreamsToVector***: Converts a raster stream file into a vector file.
- ***RemoveShortStreams***: Removes short first-order streams from a stream network.
- ***ShreveStreamMagnitude***: Assigns the Shreve stream magnitude to each link in a stream network.
- ***StrahlerStreamOrder***: Assigns the Strahler stream order to each link in a stream network.
- ***StreamLinkClass***: Identifies the exterior/interior links and nodes in a stream network.
- ***StreamLinkIdentifier***: Assigns a unique identifier to each link in a stream network.
- ***StreamLinkLength***: Estimates the length of each link (or tributary) in a stream network.
- ***StreamLinkSlope***: Estimates the average slope of each link (or tributary) in a stream network.
- ***StreamSlopeContinuous***: Estimates the slope of each grid cell in a stream network.
- ***TopologicalStreamOrder***: Assigns each link in a stream network its topological order.
- ***TributaryIdentifier***: Assigns a unique identifier to each tributary in a stream network.


## Contributing

If you would like to contribute to the project as a developer, follow these instructions to get started:

1. Fork the whiteboxR repository (<https://github.com/giswqs/whiteboxR>)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

Unless explicitly stated otherwise, any contribution intentionally submitted for inclusion in the work shall be licensed as the [MIT license](https://opensource.org/licenses/MIT) without any additional terms or conditions.

## License

The **WhiteboxR** package is distributed under the [MIT license](https://opensource.org/licenses/MIT), a permissive open-source (free software) license.


## Reporting Bugs

whiteboxR is distributed as is and without warranty of suitability for application. If you encounter flaws with the software (i.e. bugs) please report the issue. Providing a detailed description of the conditions under which the bug occurred will help to identify the bug. *Use the [Issues tracker](https://github.com/giswqs/whiteboxR/issues) on GitHub to report issues with the software and to request feature enchancements.* Please do not email Dr. Lindsay directly with bugs.