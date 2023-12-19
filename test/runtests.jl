using TypeArrays
using Test

@testset "TypeArrays.jl" begin
    v = TypeArray((:a, :b))
    vref = collect(v)
    @test v == vref == TypeArray{(:a, :b)}() == TypeArray([:a, :b])

    m1 = TypeArray{(:a, :b, :c, :d),Tuple{2,2}}()
    @test m1 isa AbstractMatrix
    @test m1[4] === :d
    @test m1[1, 1] === :a
    @test collect(m1) == [:a :c; :b :d]
    @test collect(m1) == [:a :c; :b :d]

    m2 = TypeArray([10 20; 30 40])
    @test m2 isa AbstractMatrix
    @test m2[2] == 30
    @test m2[2, 2] == 40
    @test collect(m2) == [10 20; 30 40]

    for f in (findfirst, findlast, findall, findmin, findmax)
        f = findlast
        @test f(==(:b), v) == f(==(:b), vref)
        @test f(==(:c), m1) == f(==(:c), collect(m1))
        @test f(==(20), m2) == f(==(20), collect(m2))
    end
    
    @test findprev(==(:a), v , 2) == findprev(==(:a), collect(v) , 2)
    @test findprev(==(:a), m1, CartesianIndex(2, 1)) == findprev(==(:a), collect(m1), CartesianIndex(2, 1))
    @test findprev(==(20), m2, CartesianIndex(2, 2)) == findprev(==(20), collect(m2), CartesianIndex(2, 2))
    @test findnext(==(:b), v , 1) == findnext(==(:b), collect(v) , 1)
    @test findnext(==(:d), m1, CartesianIndex(2, 1)) == findnext(==(:d), collect(m1), CartesianIndex(2, 1))
    @test findnext(==(40), m2, CartesianIndex(2, 1)) == findnext(==(40), collect(m2), CartesianIndex(2, 1))
end
