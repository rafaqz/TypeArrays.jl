using TypeArrays
using Documenter

DocMeta.setdocmeta!(TypeArrays, :DocTestSetup, :(using TypeArrays); recursive=true)

makedocs(;
    modules=[TypeArrays],
    authors="Rafael Schouten <rafaelschouten@gmail.com>",
    repo="https://github.com/rafaqz/TypeArrays.jl/blob/{commit}{path}#{line}",
    sitename="TypeArrays.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://rafaqz.github.io/TypeArrays.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/rafaqz/TypeArrays.jl",
    devbranch="main",
)
