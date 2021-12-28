# PyCASA.jl - Julia wrappers for CASA tasks and tools

[CASA](https://casa.nrao.edu/), the *Common Astronomy Software Applications*,
is the primary data processing software for the Atacama Large
Millimeter/submillimeter Array
([ALMA](https://public.nrao.edu/telescopes/alma/)) and Karl G. Jansky Very
Large Array ([VLA](https://public.nrao.edu/venue/the-very-large-array/)), and
is often used also for other radio telescopes.

This package allows you to use CASA tasks and tools from
[Julia](https://julialang.org/).  It uses
[PyCall.jl](https://github.com/JuliaPy/PyCall.jl) to call into the CASA Python
packages via Python libraries (i.e. not a sub-process).

## Supported CASA tasks and tools

The supported CASA functionality is listed below.  Most of these CASA
classes/functions are exported from the `PyCASA` module using the same name as
in Python.  One exceptions is `casatools.table`, which is not exported because
`table` is too generic of a name.  Instead, `casatools.table` can be used as
`PyCASA.table`.

For details on these functions, please consult the [extensive CASA
documentaion](https://casadocs.readthedocs.io/en/stable/).

- From `casaplotms`:
  - `plotms`

- From `casatasks`:
  - `applycal`
  - `bandpass`
  - `clearcal`
  - `concat`
  - `flagdata`
  - `gaincal`
  - `listcal`
  - `listobs`
  - `listvis`
  - `tclean`
  - `virtualconcat`
  - `vishead`

- From `casatools`:
  - `table` (NOT exported, use as `PyCASA.table`)

- From `casaviewer`:
  - `imview`

## CASA Logging

`PyCASA.log` provides access to CASA's default `logsink` instance named
`casalog`.  See the CASA documentation for information on `logsink`.
`PyCASA.jl` also provides a specialized version of `getproperty` for
`PyCASA.log` that will automatically proxy all "property" requests to the
underlying `PyObject` that wraps `casalog`.  This means that you can use, for
example, `PyCASA.log.logfile()` to call the `logfile` function on CASA's
`casalog` object.  The one special case is `PyCASA.log.casalog` which will
return the `PyObject` itself (useful for "tab completion" in the Julia REPL).

CASA's logger really likes to create log files by default.  You can configure
CASA to send these logs to `/dev/null` by default.  Just run the following
command (one time only) in your shell:

```bash
$ echo 'logfile="/dev/null"' >> ~/.casa/config.py
```

This can be changed at runtime via:

```julia
julia> PyCASA.log.setlogfile("my_important_casa_info.log")
```

You can show CASA log messages on your terminal with:

```julia
julia> PyCASA.log.showconsole(true)
```

Pass `false` to stop showing log messages on your terminal.

## Installation details

When PyCASA.jl is installed, its `build.jl` script is run (also when running
`]build PyCASA` in the Julia REPL any time after installation).  This script
uses [Conda.jl](https://github.com/JuliaPy/Conda.jl) to install the requisite
CASA Python packages.

NB: Because the CASA packages are distributed on [PyPi](https://pypi.org), the
`build.jl` script will enable pip interoperability of the Conda.jl managed
conda environment.

If you encounter problems during the build step, you can check the `build.log`
file or run the build in verbose mode with `]build -v PyCASA`.

## Usage

Here is a quick example of how to use this package.  Please see the CASA
documentaion for more details.

```julia
julia> using PyCASA, PrettyPrint

julia> pprint(listobs("dataset.ms")) # More info goes to CASA log
{
  "IntegrationTime" : 34.9857120513916,
  "BeginTime" : 59520.714791667044,
  "EndTime" : 59520.71519659426,
  "field_0" : {
                "name" : "J2357-1125",
                "direction" : {
                                "refer" : "ICRS",
                                "m1" : {"unit" : "rad",
                                        "value" : -0.1994484698990142},
                                "m0" : {"unit" : "rad",
                                        "value" : -0.010821041362365301},
                                "type" : "direction",
                              },
                "code" : "",
              },
  "numrecords" : 61950,
  "nfields" : 1,
  "scan_0" : {
               "0" : {
                       "IntegrationTime" : 0.9995771214953437,
                       "BeginTime" : 59520.714791667044,
                       "SpwIds" : [0,],
                       "EndTime" : 59520.71519659426,
                       "StateId" : 0,
                       "FieldName" : "J2357-1125",
                       "nRow" : 61950,
                       "scanId" : 0,
                       "FieldId" : 0,
                     },
             },
  "timeref" : "UTC",
}
```
