% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/image_analysis.R
\name{prewitt_filter}
\alias{prewitt_filter}
\title{Prewitt filter}
\usage{
prewitt_filter(input, output, clip = 0, verbose_mode = FALSE)
}
\arguments{
\item{input}{Input raster file.}

\item{output}{Output raster file.}

\item{clip}{Optional amount to clip the distribution tails by, in percent.}

\item{verbose_mode}{Sets verbose mode. If verbose mode is False, tools will not print output messages.}
}
\value{
Returns the tool text outputs.
}
\description{
Performs a Prewitt edge-detection filter on an image.
}
