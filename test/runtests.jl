using NahaXMLUtils
using Test
using XML

@testset "test Bounds" begin
    bounds = Bounds(minX=0, minY=0, maxX=10, maxY=8)
    @test bounds isa Bounds
    viewbox = bounds_to_viewbox(bounds)
    show(viewbox)
end

@testset "test elt" begin
    e = elt("foo", :min => 3, :id => :phred,
            "text content",
            elt("child")) do f
                f(:max => 10)
                f(2),
                f("more text")
            end
    @test e isa XML.Node
    @test e.nodetype == XML.Element
    @test e.tag == "foo"
    @test e.attributes == Dict(
        "min" => "3",
        "id"  => "phred",
        "max" => "10",
    )
    children = e.children
    @test length(children) == 4
    @test children[1] == XML.Text("text content")
    @test children[2] isa XML.Node
    @test children[2].tag == "child"
    @test children[3] == XML.Text("2")
    @test children[4] == XML.Text("more text")
end

