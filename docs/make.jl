using JuDOInterface
using Documenter

DocMeta.setdocmeta!(JuDOInterface, :DocTestSetup, :(using JuDOInterface); recursive=true)

makedocs(;
    modules=[JuDOInterface],
    authors="e-duar-do <72969764+e-duar-do@users.noreply.github.com> and contributors",
    repo="https://github.com/JuDO-dev/JuDOInterface.jl/blob/{commit}{path}#{line}",
    sitename="JuDOInterface.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuDO-dev.github.io/JuDOInterface.jl",
        edit_link="dev",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuDO-dev/JuDOInterface.jl",
    devbranch="dev",
)
