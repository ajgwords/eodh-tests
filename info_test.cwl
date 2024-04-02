class: CommandLineTool # set the class type

requirements:
    DockerRequirement:
        dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdal_translate

arguments:

inputs:
    geotiff: 
        type: File
    bbox: 
        type: string
    epsg:
        type: string
        default: "EPSG:4326"
outputs:

cwlVersion: v1.v1.2
