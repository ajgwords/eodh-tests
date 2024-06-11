# Replicates the following command
# gdalinfo /vsicurl/https://dap.ceda.ac.uk/neodc/sentinel_ard/
#   data/sentinel_2/2023/11/19/S2B_20231119_latn509lone0006_T30UYB_ORB094_
#   20231119115015_utm30n_osgb_vmsk_sharp_rad_srefdem_stdsref_thumbnail.jpg

# Works

cwlVersion: v1.2

$graph:
  - class: Workflow
    id: gdalinfo_workflow
    doc: run gdalinfo on given file
        
    inputs:
      infoimg: 
        type: File

    outputs: []

    steps:
      step_gdalinfo:
        run: "#gdalinfo"
        in:
          infoimg: infoimg
        out: []

  - class: CommandLineTool 
    id: gdalinfo

    requirements:
        DockerRequirement: # Docker required to run gdal tools. Can also use --podman flag if installed
            dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4

    baseCommand: gdalinfo

    inputs:
        infoimg: 
            type: File
            inputBinding:
                position: 1


    outputs: []


    # run with the command
    # cwltool --podman remote_info_test_TJ.cwl#gdalinfo params_info.ym
