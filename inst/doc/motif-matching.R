## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(glymotif)

## -----------------------------------------------------------------------------
glycan <- "Neu5Ac(a2-3)Gal(b1-3)[Fuc(a1-6)]GlcNAc(b1-3)Gal(b1-3)GalNAc(b1-"
motif <- "Neu5Ac(a2-3)Gal(b1-3)[Fuc(a1-6)]GlcNAc(b1-"

print(paste0("Does the glycan have the motif? ", have_motif(glycan, motif)))
print(paste0("How many occurrences of the motif are there in the glycan? ", count_motif(glycan, motif)))

## -----------------------------------------------------------------------------
stringr::str_detect(glycan, stringr::fixed(motif))

## -----------------------------------------------------------------------------
# You don't have to understand this.
have_motifs_simple <- function(glycan, motifs, ...) {
  unname(have_motifs(glycan, motifs, ...)[1, ])
}

count_motifs_simple <- function(glycan, motifs, ...) {
  unname(count_motifs(glycan, motifs, ...)[1, ])
}

## -----------------------------------------------------------------------------
glycan <- "Neu5Ac(??-?)Gal(??-?)[Fuc(??-?)]GlcNAc(??-?)Gal(??-?)GalNAc(b1-"
motifs <- c(
  "Gal(??-",
  "Fuc(??-?)GlcNAc(??-",
  glycan
)
count_motifs_simple(glycan, motifs)

## -----------------------------------------------------------------------------
motifs <- c("Fuc(??-?)GlcNAc(??-", "GlcNAc(??-?)Fuc(??-")
have_motifs_simple(glycan, motifs)

## -----------------------------------------------------------------------------
glycan <- "Man(??-?)[Man(??-?)]Man(??-?)GlcNAc(??-?)GlcNAc(??-"
motif <- "Man(??-?)[Man(??-?)]Man(??-"
count_motif(glycan, motif)

## -----------------------------------------------------------------------------
glycan <- "Man(a1-3)[Man(a1-6)]Man(b1-4)GlcNAc(b1-4)[Fuc(a1-6)]GlcNAc(b1-"
motifs <- c(
  "Fuc(a1-?)GlcNAc(b1-",  # Motif 1: anomer known, position flexible
  "Fuc(a1-6)GlcNAc(b1-",  # Motif 2: exact linkage match
  "Fuc(a1-3)GlcNAc(b1-"   # Motif 3: wrong position specification
)
have_motifs_simple(glycan, motifs)

## -----------------------------------------------------------------------------
have_motif("Gal(a1-", "Gal(a1-")
have_motif("Gal(a1-", "Hex(a1-")
have_motif("Hex(a1-", "Gal(a1-")
have_motif("Hex(a1-", "Hex(a1-")

## -----------------------------------------------------------------------------
glycans <- c("Neu5Ac9Ac(a2-", "Neu5Ac?Ac(a2-", "Neu5Ac(a2-")
motifs <- c("Neu5Ac9Ac(a2-", "Neu5Ac?Ac(a2-", "Neu5Ac(a2-")
mat <- have_motifs(glycans, motifs)
rownames(mat) <- paste0("glycan_", 1:3)
colnames(mat) <- paste0("motif_", 1:3)
mat

## -----------------------------------------------------------------------------
have_motif("Neu5Ac9Ac(a2-", "Neu5Ac(a2-", strict_sub = FALSE)

## -----------------------------------------------------------------------------
glycan <- "Gal(a1-3)Gal(a1-4)Gal(a1-6)Gal(a1-"
motifs <- c(
  "Gal(a1-3)Gal(a1-4)Gal(a1-6)Gal(a1-",  # motif 1: complete structure
  "Gal(a1-3)Gal(a1-4)Gal(a1-",           # motif 2: terminal branch
           "Gal(a1-4)Gal(a1-6)Gal(a1-",  # motif 3: reducing-end subtree
           "Gal(a1-4)Gal(a1-"            # motif 4: internal fragment
)
alignments <- c("substructure", "whole", "core", "terminal")
mat <- do.call(cbind, purrr::map(alignments, ~ have_motifs_simple(glycan, motifs, alignments = .x)))
colnames(mat) <- alignments
rownames(mat) <- paste0("motif_", 1:4)
mat

## -----------------------------------------------------------------------------
glycan <- "Gal(a1-3)GalNAc(b1-"
motifs <- c("Gal(a1-", "Gal(b1-")
have_motifs_simple(glycan, motifs)

## -----------------------------------------------------------------------------
glycan <- "Gal(a1-3)GalNAc(b1-"
motifs <- c("GalNAc(a1-", "GalNAc(b1-")
have_motifs_simple(glycan, motifs)

