# Replicates the following command
# gdal_translate -projwin 546626 105501 565954 95132
#  -projwin_srs "EPSG:27700"
#  sat.tif sat_clipped.tif
# where sat.tif is downloaded from  https://dap.ceda.ac.uk/neodc/sentinel_ard/
#   data/sentinel_2/2023/11/19/S2B_20231119_latn509lone0006_T30UYB_
#   ORB094_20231119115015_utm30n_osgb_vmsk_sharp_rad_srefdem_stdsref.tif

# Works locally

cwlVersion: v1.1
class: CommandLineTool # set the class type

# make sure nodejs is installed via micromamba
requirements:
    InlineJavascriptRequirement: {} # JavaScript required to reformat args  
    DockerRequirement: # Docker required to run gdal tools. Can also use --podman flag if installed
        dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdal_translate

arguments: # gdal_translate uses -projwin ulx uly lrx lry to set the area of interest.
- -projwin 
- valueFrom: ${ return inputs.bbox.split(",")[0]; }
- valueFrom: ${ return inputs.bbox.split(",")[1]; }
- valueFrom: ${ return inputs.bbox.split(",")[2]; }
- valueFrom: ${ return inputs.bbox.split(",")[3]; }
- valueFrom: ${ return inputs.geotiff.basename.replace(".tif", "") + "_clipped.tif"; }
  position: 8 # still need to work out what the position statement means

inputs:
    geotiff: 
        type: File
        inputBinding:
            position: 7
    bbox: 
        type: string
    epsg:
        type: string
        default: "EPSG:27700"
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

# run with the command
# cwltool --podman path/to/clip_test.cwl path/to/params.yml
# from the directory containing the sat.tif file
