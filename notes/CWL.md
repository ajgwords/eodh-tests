https://www.commonwl.org/v1.1/CommandLineTool.html#CommandLineTool

A parameter is a named symbolic input or output of process, with an associated datatype or schema. During execution, values are assigned to parameters to make the input object or output object used for concrete process invocation.


A CommandLineTool is a process characterized by the execution of a standalone, non-interactive program which is invoked on some input, produces output, and then terminates.


A workflow is a process characterized by multiple subprocess steps, where step outputs are connected to the inputs of downstream steps to form a directed acylic graph, and independent steps may run concurrently.

A process requirement modifies the semantics or runtime environment of a process. If an implementation cannot satisfy all requirements, or a requirement is listed which is not recognized by the implementation, it is a fatal error and the implementation must not attempt to run the process, unless overridden at user option. Requirements specified in a parent Workflow are inherited by step processes if they are valid for that step. If the substep is a CommandLineTool only the InlineJavascriptRequirement, SchemaDefRequirement, DockerRequirement, SoftwareRequirement, InitialWorkDirRequirement, EnvVarRequirement, ShellCommandRequirement, ResourceRequirement are valid. Requirements override hints.


A hint is similar to a requirement; however, it is not an error if an implementation cannot satisfy all hints. The implementation may report a warning if a hint cannot be satisfied.


Parameter references are denoted by the syntax $(...) 


An expression is a fragment of Javascript/ECMAScript 5.1 code evaluated by the workflow platform to affect the inputs, outputs, or behavior of a process. Expressions are distinct from regular processes in that they are intended to modify the behavior of the workflow itself rather than perform the primary work of the workflow. Expressions in CWL are an optional feature and are not required to be implemented by all consumers of CWL documents. They should be used sparingly, when there is no other way to achieve the desired outcome. Excessive use of expressions may be a signal that other refactoring of the tools or workflows would benefit the author, runtime, and users of the CWL document in question. To declare the use of expressions, the document must include the process requirement InlineJavascriptRequirement. Expressions may be used in any field permitting the pseudo-type Expression, as specified by this document.

The generic execution sequence of a CWL process (including workflows and command line line tools) is as follows.

* Load input object.
* Load, process and validate a CWL document, yielding one or more process objects. The $namespaces present in the CWL document are also used when validating and processing the input object.
* If there are multiple process objects (due to $graph) and which process object to start with is not specified in the input object (via a cwl:tool entry) or by any other means (like a URL fragment) then choose the process with the id of "#main" or "main".
* Validate the input object against the inputs schema for the process.
* Validate process requirements are met.
* Perform any further setup required by the specific process type.
* Execute the process.
* Capture results of process execution into the output object.
* Validate the output object against the outputs schema for the process.
* Report the output object to the process caller.


By convention, a CWL document may begin with #!/usr/bin/env cwl-runner and be marked as executable (the POSIX "+x" permission bits) to enable it to be executed directly. A workflow platform may support this mode of operation; if so, it must provide cwl-runner as an alias for the platform's CWL implementation.



https://docs.dockstore.org/en/develop/getting-started/getting-started-with-cwl.html

It is recommended that you have the following minimum fields:

```
doc: <description>
id: <id>
label: <label>

cwlVersion: v1.1

dct:creator:
  foaf:name: <name>```


