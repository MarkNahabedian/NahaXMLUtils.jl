
"""
    elt(f, tagname::AbstractString, things...)
    elt(tagname::AbstractString, things...)

Return an XML element.  `f` is called with a single argument: either
an XML.AbstractXMLNode or a Pair describing an XML attribute to be added to the
resulting element.

Each of `things` is either an XML.AbstractXMLNode or a Pair describing
an XML attribute to be added to the resulting element.

Each of things, and whatever `f` is called on are added to the new XML
element.

An argument could also be either a string or a number, in which case
it is included as text content.

If an argument is an `AbstractDict` then each entry is added as an
attribute.
"""
function elt(f::Function, tagname::AbstractString, things...)
    attributes = OrderedDict()
    children = Vector{Union{String, XML.AbstractXMLNode}}()
    function add_thing(s)
        if s isa Pair
            attributes[Symbol(s.first)] = XML.escape(string(s.second))
        elseif s isa AbstractDict    # set of attributes, e.g. from attributes(::XML.Node):
            for (k, v) in s
                attributes[Symbol(k)] = v
            end
        elseif s isa AbstractString
            push!(children, s)
        elseif s isa Number
            push!(children, string(s))
        elseif s isa XML.AbstractXMLNode
            push!(children, s)
        elseif s isa Nothing
            # Ignore
        else
            error("unsupported XML content: $s")
        end
    end
    for thing in things
        add_thing(thing)
    end
    f(add_thing)
    Node(XML.Element, tagname, attributes, nothing, children)
end

elt(tagname::AbstractString, things...) = elt(identity, tagname, things...)


function xmlComment(text::AbstractString)
    XML.Comment(text)
end

