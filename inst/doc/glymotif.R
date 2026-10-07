## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(glyrepr)
library(glymotif)

## -----------------------------------------------------------------------------
glycans <- c(
  "Neu5Ac(a2-3)Gal(b1-3)[Fuc(a1-6)]GlcNAc(b1-3)Gal(b1-3)GalNAc(b1-",
  "Neu5Ac(a2-?)Gal(b1-3)[Fuc(a1-6)]GlcNAc(b1-",
  "Man(b1-4)GlcNAc(b1-4)[Fuc(a1-3)]GlcNAc(b1-",
  "Gal(b1-3)GalNAc(b1-",
  "Neu5Ac9Ac(a2-3)Gal(b1-4)GlcNAc(b1-"
)
motif <- "Neu5Ac(a2-3)Gal(b1-3)[Fuc(a1-6)]GlcNAc(b1-"
have_motif(glycans, motif)

## -----------------------------------------------------------------------------
motifs <- c(
  "Neu5Ac(a2-3)Gal(b1-3)[Fuc(a1-6)]GlcNAc(b1-",
  "Fuc(a1-",
  "Gal(b1-3)GalNAc(b1-"
)

## -----------------------------------------------------------------------------
have_motif(glycans, motif)

## -----------------------------------------------------------------------------
unname(have_motifs(glycans, motifs))  # Removing names for cleaner display

## -----------------------------------------------------------------------------
have_motif(glycans, "Type 2 LN2")

## -----------------------------------------------------------------------------
# Ambiguous linkages won't match specific ones
have_motif("Gal(??-?)GalNAc(??-", "Gal(a1-6)GalNAc(a1-")

# Generic monosaccharides won't match specific ones
have_motif("Hex(a1-6)HexNAc(a1-", "Gal(a1-6)GalNAc(a1-")

## -----------------------------------------------------------------------------
# get_structure_level() expects a glycan structure vector
get_structure_level(as_glycan_structure(c("Gal(??-?)GalNAc(??-", "Gal(a1-6)GalNAc(a1-")))

## -----------------------------------------------------------------------------
have_motif("Gal(??-?)GalNAc(??-", "Gal(a1-6)GalNAc(a1-", ignore_linkages = TRUE)

## -----------------------------------------------------------------------------
motif <- glyparse::auto_parse("Gal(a1-6)GalNAc(a1-")  # First, create a `glycan_structure()`
motif <- glyrepr::convert_to_generic(motif)  # Then, convert to generic
have_motif("Hex(a1-6)HexNAc(a1-", motif)

## -----------------------------------------------------------------------------
res <- have_motifs(glycans, db_motifs())
colnames(res)[1:5]

## -----------------------------------------------------------------------------
try(have_motifs(glycans, db_motifs(), alignments = "substructure"))

## -----------------------------------------------------------------------------
db_motif_info()

## -----------------------------------------------------------------------------
dplyr::distinct(db_motif_info(), source_id, source)

## -----------------------------------------------------------------------------
extract_motif("Gal(b1-3)[GlcNAc(b1-6)]GalNAc(a1-")

## -----------------------------------------------------------------------------
extract_motif(c(
  "Gal(b1-3)[GlcNAc(b1-6)]GalNAc(a1-",
  "Gal(b1-3)GalNAc(a1-"
))

## -----------------------------------------------------------------------------
extract_motif("Glc(a1-2)Glc(a1-2)Glc(a1-2)Glc(a1-")

## -----------------------------------------------------------------------------
extract_motif("Glc(a1-2)Glc(a1-2)Glc(a1-2)Glc(a1-", max_size = 4)

## -----------------------------------------------------------------------------
glycans <- c(
  "Neu5Ac(a2-3)Gal(b1-4)GlcNAc(b1-2)Man(a1-3)[Gal(b1-4)GlcNAc(b1-2)Man(a1-6)]Man(b1-4)GlcNAc(a1-4)GlcNAc(b1-",
  "Neu5Ac(a2-3)Gal(b1-4)GlcNAc(b1-2)Man(a1-3)[Neu5Ac(a2-6)Gal(b1-4)GlcNAc(b1-2)Man(a1-6)]Man(b1-4)GlcNAc(a1-4)GlcNAc(b1-",
  "Gal(b1-4)GlcNAc(b1-2)Man(a1-3)[GlcNAc(b1-2)Man(a1-6)]Man(b1-4)GlcNAc(a1-4)GlcNAc(b1-"
)

extract_branch_motif(glycans)

## -----------------------------------------------------------------------------
count_motifs(glycans, branch_motifs())

