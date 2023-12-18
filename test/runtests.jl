using TypeArrays
using Test

@testset "TypeArrays.jl" begin
    @test TypeArray((:a, :b)) == TypeArray{(:a, :b)}() == TypeArray([:a, :b])

    m1 = TypeArray{(:a, :b, :c, :d),Tuple{2,2}}()
    @test m1 isa AbstractMatrix
    @test m1[4] === :d
    @test m1[1, 1] === :a
    @test findfirst(==(:c), m1) == 3
    @test collect(m1) == [:a :c; :b :d]
    @test collect(m1) == [:a :c; :b :d]

    m2 = TypeArray([10 20; 30 40])
    @test m2 isa AbstractMatrix
    @test m2[2] == 30
    @test m2[2, 2] == 40
    @test findfirst(==(20), m2) == 3
    @test collect(m2) == [10 20; 30 40]
end
