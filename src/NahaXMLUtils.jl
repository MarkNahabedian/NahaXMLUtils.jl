module NahaXMLUtils

using XML
using Printf
using OrderedCollections

export Bounds, bounds_to_viewbox, elt

const SVG_NAMESPACE = "http://www.w3.org/2000/svg"

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

include("elt.jl")

end
