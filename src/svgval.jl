export svgval, svglength


"""
    svgval(value)
return a representation of `value` that can appear in SVG code.
"""
function svgval end

function svgval(x::Quantity)
    ustrip(Real, u"inch", x)
end

function svgval(x::Number)
    x
end


SVG_UNITS = Dict{Unitful.Units, String}(
    u"cm" => "cm",
    u"mm" => "mm",
    u"inch" => "in"
)

svglength(x::Number) = x

function svglength(x::Quantity)
    "$(svgval(x))$(SVG_UNITS[unit(x)])"
end

