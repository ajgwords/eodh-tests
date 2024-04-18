cwlVersion: v1.1

class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: ghcr.io/osgeo/gdal:ubuntu-small-latest

baseCommand: gdal_calc.py

arguments: 
- -A 
- valueFrom: ${ return inputs.clipimg; }
- --A_band=3
- -B 
- valueFrom: ${ return inputs.clipimg; }
- --B_band=7 
- --type=Float32 
- --outfile=ndvi.tif 
- --calc="((B-A)/(B+A))"
#gdal_calc.py -A output.tif --A_band=1 -B output.tif --B_band=2 --type=Float32 --outfile=ndvi.tif --calc="((B-A)/(B+A))"

inputs:
  clipimg:
    type: File

outputs:
  ndvi_tif:
    outputBinding:
      glob: '*.tif'
    type: File