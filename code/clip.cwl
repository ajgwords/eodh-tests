cwlVersion: v1.1

class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdalwarp

arguments:
- -cutline
- valueFrom: ${ return inputs.aoi; } 
- -crop_to_cutline
- valueFrom: ${ return inputs.intif; }
- valueFrom: ${ return inputs.intif.basename.replace(".tif", "") + "_clipped.tif"; }
#gdalwarp -cutline path/to/polygonfile.shp -crop_to_cutline sat.tif output.tif

inputs:
  intif:
    type: File
  aoi:
    type: File

outputs:
  clipped_tif:
    outputBinding:
      glob: '*.tif'
    type: File
