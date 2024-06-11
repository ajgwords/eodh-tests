class: Workflow
label: Sentinel-2 clipping and stacking
doc:  This workflow creates a stacked image
id: main

requirements:
- class: ScatterFeatureRequirement

inputs:

  geotiff:
    doc: list of geotifs
    type: File[]

  bbox: 
    doc: area of interest as a bounding box
    type: string

  epsg:
    doc: EPSG code 
    type: string
    default: "EPSG:27700"

outputs:
  rgb:
    outputSource:
    - node_concatenate/composite
    type: File

steps:
  node_vrt:
    run: gdal-vrt.cwl
    in:
      geotiff: geotiff

    out:
    - vrt_tif

    scatter: geotiff
    scatterMethod: dotproduct    

  node_translate:

    run: gdal-translate.cwl

    in:

      geotiff:
        source: node_vrt/vrt_tif  
      bbox: bbox
      epsg: epsg

    out:
    - clipped_tif

    scatter: geotiff
    scatterMethod: dotproduct

  node_concatenate:

    run: concatenate2.cwl

    in: 
      tifs:
        source: node_translate/clipped_tif

    out:
    - composite


cwlVersion: v1.0
