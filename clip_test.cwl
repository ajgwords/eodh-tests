cwlVersion: v1.1
class: CommandLineTool # set the class type

requirements:
    InlineJavascriptRequirement: {} # JavaScript required to reformat args  
    DockerRequirement: # Docker required to run gdal tools
        dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdal_translate

arguments: # gdal_translate uses -projwin ulx uly lrx lry to set the area of interest.
- -projwin 
- valueFrom: ${ return inputs.bbox.split(",")[0]; }
- valueFrom: ${ return inputs.bbox.split(",")[3]; }
- valueFrom: ${ return inputs.bbox.split(",")[2]; }
- valueFrom: ${ return inputs.bbox.split(",")[1]; }
- valueFrom: ${ return inputs.geotiff.basename.replace(".tif", "") + "_clipped.tif"; }
  position: 8

inputs:
    geotiff: 
        type: File
        inputBinding:
            position: 7
    bbox: 
        type: string
    epsg:
        type: string
        default: "EPSG:4326"
        inputBinding:
            position: 6
            prefix: -projwin_srs
            separate: true
# the input names relate to the parameter names in the params.yml file

outputs:
    clipped_tif:
        outputBinding:
            glob: '*_clipped.tif'
        type: File

