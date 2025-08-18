using NahaXMLUtils
using Documenter

DocMeta.setdocmeta!(NahaXMLUtils, :DocTestSetup, :(using NahaXMLUtils); recursive=true)

makedocs(;
    modules=[NahaXMLUtils],
    authors="MarkNahabedian <naha@mit.edu> and contributors",
    sitename="NahaXMLUtils.jl",
    format=Documenter.HTML(;
        canonical="https://MarkNahabedian.github.io/NahaXMLUtils.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MarkNahabedian/NahaXMLUtils.jl",
    devbranch="main",
)
