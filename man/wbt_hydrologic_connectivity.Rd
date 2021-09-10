% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hydro_analysis.R
\name{wbt_hydrologic_connectivity}
\alias{wbt_hydrologic_connectivity}
\title{Hydrologic connectivity}
\usage{
wbt_hydrologic_connectivity(
  dem,
  output1,
  output2,
  exponent = 1,
  threshold = NULL,
  wd = NULL,
  verbose_mode = FALSE,
  compress_rasters = FALSE
)
}
\arguments{
\item{dem}{Name of the input DEM raster file; must be depressionless.}

\item{output1}{Name of the output downslope unsaturated length (DUL) file.}

\item{output2}{Name of the output upslope disconnected saturated area (UDSA) file.}

\item{exponent}{Optional exponent parameter; default is 1.0.}

\item{threshold}{Optional convergence threshold parameter, in grid cells; default is infinity.}

\item{wd}{Changes the working directory.}

\item{verbose_mode}{Sets verbose mode. If verbose mode is False, tools will not print output messages.}

\item{compress_rasters}{Sets the flag used by WhiteboxTools to determine whether to use compression for output rasters.}
}
\value{
Returns the tool text outputs.
}
\description{
This tool evaluates hydrologic connectivity within a DEM.
}