class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement: 
    dockerPull: docker.io/terradue/otb-7.2.0:latest

baseCommand: otbcli_ConcatenateImages
arguments: 
- -out
- composite.tif

inputs:

  tifs:
    type: File[]
    inputBinding:
      position: 5
      prefix: -il
      separate: true

outputs:

  composite:
    outputBinding:
      glob: '*.tif'
    type: File

stderr: stderr
stdout: stdout

cwlVersion: v1.0
