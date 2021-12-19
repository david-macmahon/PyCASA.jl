module CASA

using PyCall

const CASA_MOD_FUNCS = (
    :casaplotms => (:plotms,),
    :casatasks  => (:applycal, :bandpass, :clearcal, :concat, :gaincal,
                    :listcal, :listobs, :listvis, :tclean, :virtualconcat,
                    :vishead),
    :casatools  => (:table,),
    :casaviewer => (:imview,)
)

const CASA_NO_EXPORTS = (
    :table,
)

mutable struct Log
  casalog::PyObject
end

"""
`CASA.log` provides access to CASA's default `logsink` instance named
`casalog`.  See the CASA documentation for information on `logsink`.  `CASA.jl`
also provides a specialized version of `getproperty` for `CASA.log` that will
automatically proxy all "property" requests to the underlying `PyObject` that
wraps `casalog`.  This means that you can use, for example,
`CASA.log.logfile()` to call the `logfile` function on CASA's `casalog` object.
The one special case is `CASA.log.casalog` which will return the `PyObject`
itself, which can be useful for "tab completion" in the Julia REPL.
"""
const log = Log(py"None")

function Base.getproperty(o::Log, sym::Symbol)
  sym == :casalog ? invoke(getproperty, Tuple{Any,Symbol}, o, sym) :
                    getproperty(o.casalog, sym)
end

function __init__()
    py"""
    import scipy
    from casatasks import casalog
    """
    log.casalog = py"casalog"
end

const PyMods = Dict{String, PyObject}()

for (mod, funcs) in CASA_MOD_FUNCS
    for func in funcs
        @eval function $func(args...; kwargs...)
                m = get!(PyMods, $(string(mod, ".", func)), pyimport($(string(mod, ".", func))))
                m.$func(args...; kwargs...)
        end
        if !(func in CASA_NO_EXPORTS)
            @eval export $func
        end
    end
end

end
