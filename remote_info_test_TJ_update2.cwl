# Replicates the following command
# gdalinfo /vsicurl/https://dap.ceda.ac.uk/neodc/sentinel_ard/
#   data/sentinel_2/2023/11/19/S2B_20231119_latn509lone0006_T30UYB_ORB094_
#   20231119115015_utm30n_osgb_vmsk_sharp_rad_srefdem_stdsref_thumbnail.jpg
# Works
cwlVersion: v1.2
$namespaces:
  s: https://schema.org/
  s:softwareVersion: 0.1.2
  schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  # Workflow entrypoint
  - class: Workflow
    id: gdalinfo_workflow
    label: run gdalinfo
    doc: run gdalinfo on given file
        
    inputs:
      infoimg:
        label: the image to be used
        doc: a link to the image to be assessed
        type: File
    outputs:
      - id: results
        type: Directory
        outputSource:
          - step_gdalinfo/results
    steps:
      step_gdalinfo:
        run: "#gdalinfo"
        in:
          infoimg: infoimg
        out:
          - results
  - class: CommandLineTool 
    id: gdalinfo
    requirements:
#      ResourceRequirement:
#        coresMax: 1
#        ramMax: 512
      DockerRequirement: # Docker required to run gdal tools. Can also use --podman flag if installed
        dockerPull: ghcr.io/osgeo/gdal:alpine-small-3.8.4
    baseCommand: gdalinfo
    inputs:
        infoimg: 
            type: File
            inputBinding:
                position: 1
    outputs:
      results:
        type: Directory
        outputBinding:
          glob: .
    # run with the command
    # cwltool --podman --parallel remote_info_test_TJ_update.cwl#gdalinfo_workflow