# CASA

Julia wrappers for some CASA tasks/tools.

This package works via PyCall.jl to call into a CASA Python packages that have
been installed into a Conda.jl environment.  Currently the CASA Python packages
must be installed by hand before this package will work.  In the future, the
package will get a `build.jl` script that will install the requisite Python
packages into the Conda.jl environment.

## Supported CASA tasks and tools

The CASA functionality is listed below.  Most the CASA classes/functions are
exported from the `CASA` module using the same name as in Python.  One
exceptions is `casatools.table`, which is not exported because `table` is too
generic of a name.  Instead, `casatools.table` can be used as `CASA.table`.

- From `casaplotms`:
  - `plotms`

- From `casatasks`:
  - `applycal`
  - `bandpass`
  - `clearcal`
  - `concat`
  - `gaincal`
  - `listcal`
  - `listobs`
  - `listvis`
  - `tclean`
  - `virtualconcat`
  - `vishead`

- From `casatools`:
  - `table` (NOT exported, use as `CASA.table`)

- From `casaviewer`:
  - `imview`

## CASA Logging

`CASA.log` provides access to CASA's default `logsink` instance named
`casalog`.  See the CASA documentation for information on `logsink`.  `CASA.jl`
also provides a specialized version of `getproperty` for `CASA.log` that will
automatically proxy all "property" requests to the underlying `PyObject` that
wraps `casalog`.  This means that you can use, for example,
`CASA.log.logfile()` to call the `logfile` function on CASA's `casalog` object.
The one special case is `CASA.log.casalog` which will return the `PyObject`
itself (useful for "tab completion" in the Julia REPL).

!!! tip

    CASA's logger like to create log files by default.  You can put
    `logfile="/dev/null"` in your `~/.casa/config.py` file to send the log
    messages to `/dev/null`.  This can be changed at runtime via
    `CASA.log.setlogfile("my_important_casa_info.log")`.

    You can also have CASA log messages printed to the console with
    `CASA.log.showconsole(true)`.

## Usage

Here is a quick example of how to use this package.  Please see the CASA
documentaion for more details.

```julia
julia> using CASA, PrettyPrint

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
