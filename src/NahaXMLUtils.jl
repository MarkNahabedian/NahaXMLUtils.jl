module NahaXMLUtils

using XML
using Printf
using OrderedCollections
using Unitful
using UnitfulUS

export SVG_NAMESPACE, Bounds, bounds_to_viewbox, elt

# XML namespaces I care about:
const SVG_NAMESPACE = "http://www.w3.org/2000/svg"
SHAPER_NAMESPACE = "http://www.shapertools.com/namespaces/shaper"

Base.@kwdef struct Bounds
    minX::Real
    maxX::Real
    minY::Real
    maxY::Real
end


"""
    bounds_to_viewbox(::Bounds)

Returns a vector of `Pair`s which provide the `viewBox`, `width` and
`height` attributes to [`elt`](@ref) for an `svg` element.
"""
function bounds_to_viewbox(bounds::Bounds)
    # bounds is in terms of coordinate system units:
    width = abs(bounds.maxY - bounds.minY)
    height = abs(bounds.maxX - bounds.minX)
    [
        "viewBox" =>
            @sprintf("%3.3f %3.3f %3.3f %3.3f",
                     bounds.minY,
                     bounds.minX,
                     width, height),
        "width" => "$width",
        "height" => "$height"
    ]
end

include("svgval.jl")
include("elt.jl")

end
