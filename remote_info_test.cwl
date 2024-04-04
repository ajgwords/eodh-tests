# Replicates the following command
# gdalinfo /vsicurl/https://dap.ceda.ac.uk/neodc/sentinel_ard/
#   data/sentinel_2/2023/11/19/S2B_20231119_latn509lone0006_T30UYB_ORB094_
#   20231119115015_utm30n_osgb_vmsk_sharp_rad_srefdem_stdsref_thumbnail.jpg

# Works??

cwlVersion: v1.2
class: CommandLineTool 

requirements:
    DockerRequirement: # Docker required to run gdal tools. Can also use --podman flag if installed
        dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

baseCommand: gdalinfo

#arguments: # gdal_translate uses -projwin ulx uly lrx lry to set the area of interest.
#- -projwin 
#- valueFrom: ${ return inputs.bbox.split(",")[0]; }
#- valueFrom: ${ return inputs.bbox.split(",")[1]; }
#- valueFrom: ${ return inputs.bbox.split(",")[2]; }
#- valueFrom: ${ return inputs.bbox.split(",")[3]; }
#- valueFrom: ${ return inputs.geotiff.basename.replace(".tif", "") + "_clipped.tif"; }
#  position: 8 # still need to work out what the position statement means

inputs:
    infoimg: 
        type: string
        inputBinding:
            position: 1


outputs: []


# run with the command
# cwltool --podman path/to/remote_info_test.cwl path/to/params.yml
# from the directory containing the sat.tif file
