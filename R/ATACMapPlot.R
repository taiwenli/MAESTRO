#' Mapping summary plot for scATAC-seq analysis
#'
#' Summary plot of total reads, mappability, duplicate reads ratio, mitochondria reads ratio for scATAC-seq analysis.
#'
#' @docType methods
#' @name ATACMapPlot
#' @rdname ATACMapPlot
#'
#' @param filepath Path of the scATAC-seq mapping summary file generated by \code{MAESTRO}.
#' @param platform Denote platform of the scATAC-seq data, available options are "microfluidic",
#' "10x-genomics","sci-ATAC-seq". Default platform is "10x-genomics".
#' @param name Name for the output mapping summary plot.
#'
#' @author Chenfei Wang, Dongqing Sun
#'
#' @export

ATACMapPlot <- function(filepath, platform = "10x-genomics", name)
{
  if(platform == "microfluidic" || platform == "sci-ATAC-seq"){
     mapping_matrix <- read.table(filepath, header = TRUE, sep = "\t", row.names = 1)
     png(paste0(name,"_scATAC_mapping_summary.png"),width=6,height=6, res = 300, units = "in")
     par(mfrow=c(2,2))
     hist(log10(mapping_matrix[which(mapping_matrix[,1]>1000),2]), border=NA, col="blue",main="Total Fragments",xlim=c(3,5.5),xlab="log10(Total Fragments)",ylab="Frequency")
     hist(mapping_matrix[,2]/mapping_matrix[,1], border=NA, col="blue",main="Mapped Ratio",xlim=c(0,1),xlab="Mapped Ratio",ylab="Frequency")
     hist(mapping_matrix[,3]/mapping_matrix[,2], border=NA, col="blue",main="Duplicate Ratio",xlim=c(0,1),xlab="Duplicate Ratio",ylab="Frequency")
     hist(mapping_matrix[,4]/mapping_matrix[,2], border=NA, col="blue",main="Mitochondria Ratio",xlim=c(0,1),xlab="Mitochondria Ratio",ylab="Frequency")
     dev.off()}
  if(platform == "10x-genomics"){
     mapping_matrix <- read.csv(filepath)
     png(paste0(name,"_scATAC_mapping_summary.png"),width=6,height=6, res = 300, units = "in")
     par(mfrow=c(2,2))
     hist(log10(mapping_matrix[which(mapping_matrix[,2]>1000),2]), border=NA, col="blue",main="Total Fragments",xlim=c(3,5.5),xlab="log10(Total Fragments)",ylab="Frequency")
     hist(1-mapping_matrix[2:nrow(mapping_matrix),5]/mapping_matrix[2:nrow(mapping_matrix),2], border=NA, col="blue",main="Mapped Ratio",xlim=c(0,1),xlab="Mapped Ratio",ylab="Frequency")
     hist(mapping_matrix[2:nrow(mapping_matrix),3]/mapping_matrix[2:nrow(mapping_matrix),2], border=NA, col="blue",main="Duplicate Ratio",xlim=c(0,1),xlab="Duplicate Ratio",ylab="Frequency")
     hist(mapping_matrix[2:nrow(mapping_matrix),7]/mapping_matrix[2:nrow(mapping_matrix),2], border=NA, col="blue",main="Mitochondria Ratio",xlim=c(0,1),xlab="Mitochondria Ratio",ylab="Frequency")
     dev.off()}
}