class: CommandLineTool

cwlVersion: v1.0
doc:  This runs GDAL Translate to create a virtual image of a single band.

requirements: 
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: ghcr.io/osgeo/gdal:ubuntu-small-latest

baseCommand: gdal_translate
#  gdal_translate -b 7 -of VRT /vsicurl/https://dap.ceda.ac.uk/neodc/sentinel_ard/data/sentinel_2/
# 2023/11/15/S2B_20231115_latn527lonw0007_T30UXD_ORB037_20231115121328_utm30n_osgb_vmsk_sharp_rad_srefdem_stdsref.tif local_path.vrt
arguments:
- -b "B08" 
- -of "VRT"
- valueFrom: ${ return inputs.geotiff.basename.replace(".tif", "") + "_clipped.tif"; }
  position: 8

inputs:
  geotiff: 
    type: File
    inputBinding:
      position: 7


outputs:
  vrt_tif:
    outputBinding:
      glob: '*_vrt.tif'
    type: File

