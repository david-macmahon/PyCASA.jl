module CASA

# casaplotms
export plotms

# casatasks
export bandpass
export concat
export gaincal
export listobs
export listvis
export tclean
export virtualconcat
export vishead

# casatools
export casatable

# casaviewer
export imview

using PyCall

function __init__()
    py"""
    import scipy

    from casaplotms.plotms import plotms

    from casatasks.bandpass import bandpass
    from casatasks.concat import concat
    from casatasks.gaincal import gaincal
    from casatasks.listobs import listobs
    from casatasks.listvis import listvis
    from casatasks.tclean import tclean
    from casatasks.virtualconcat import virtualconcat
    from casatasks.vishead import vishead

    from casatools.table import table

    from casaviewer.imview import imview
    """
end

# casaplotms
plotms(args...; kwargs...) = py"plotms"(args...; kwargs...)

# casatasks
bandpass(args...; kwargs...) = py"bandpass"(args...; kwargs...)
concat(args...; kwargs...) = py"concat"(args...; kwargs...)
gaincal(args...; kwargs...) = py"gaincal"(args...; kwargs...)
listobs(args...; kwargs...) = py"listobs"(args...; kwargs...)
listvis(args...; kwargs...) = py"listvis"(args...; kwargs...)
tclean(args...; kwargs...) = py"tclean"(args...; kwargs...)
virtualconcat(args...; kwargs...) = py"virtualconcat"(args...; kwargs...)
vishead(args...; kwargs...) = py"vishead"(args...; kwargs...)

# casatools
casatable(args...; kwargs...) = py"table"(args...; kwargs...)

# casaviewer
imview(args...; kwargs...) = py"imview"(args...; kwargs...)

end
