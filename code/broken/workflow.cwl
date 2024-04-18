#!/usr/bin/env cwl-runner
class: Workflow 

cwlVersion: v1.1

doc:
  Clip a large satellite image and calculate an index
label: NDVI_runner
id: main

requirements:
- class: ScatterFeatureRequirement

inputs:

  intifs:
    doc: list of geotifs
    type: File[]

  aoi: 
    doc: area of interest as a gpkg
    type: File


outputs:
  output:
    type: File
    outputSource: calcs/outndvi
    doc: output NDVI layer

steps:

  node_clip:

    run: clip.cwl

    in:
      intif: intifs  
      aoi: aoi

    out: