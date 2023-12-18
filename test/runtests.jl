using TypeArrays
using Test

@testset "TypeArrays.jl" begin
    A = TypeArray((:a, :b))
    @test A == TypeArray{(:a, :b)}() == TypeArray([:a, :b])
    @test findfirst(==(:b), A) == 2

    m1 = TypeArray{(:a, :b, :c, :d),Tuple{2,2}}()
    @test m1 isa AbstractMatrix
    @test m1[4] === :d
    @test m1[1, 1] === :a
    @test findfirst(==(:c), m1) == CartesianIndex(1, 2)
    @test collect(m1) == [:a :c; :b :d]
    @test collect(m1) == [:a :c; :b :d]

    m2 = TypeArray([10 20; 30 40])
    @test m2 isa AbstractMatrix
    @test m2[2] == 30
    @test m2[2, 2] == 40
    @test findfirst(==(30), m2) == CartesianIndex(2, 1)
    @test collect(m2) == [10 20; 30 40]
end
