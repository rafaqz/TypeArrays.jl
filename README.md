# TypeArrays

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://rafaqz.github.io/TypeArrays.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://rafaqz.github.io/TypeArrays.jl/dev/)
[![Build Status](https://github.com/rafaqz/TypeArrays.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rafaqz/TypeArrays.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/rafaqz/TypeArrays.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/rafaqz/TypeArrays.jl)

A very simple package that defines a `StaticArrays.StaticArray`
that is only stored in the type. A `TypeArray`!

Usage:

```julia
julia> using TypeArrays

julia> A = TypeArray((:a, :b))
2-element TypeArray{(:a, :b), Tuple{2}, Symbol, 1} with indices SOneTo(2):
 :a
 :b

julia> A[1]
:a

julia> A = TypeArray([10 20; 30 40])
2×2 TypeArray{(10, 30, 20, 40), Tuple{2, 2}, Int64, 2} with indices SOneTo(2)×SOneTo(2):
 10  20
 30  40

julia> A[2, 2]
40
```

And why would you want to use this package? 
`findfirst` can be a compile-time op:

```julia
julia> using BenchmarkTools, StaticArrays

julia> ta = TypeArray{(:a, :b, :c, :d),Tuple{2,2}}()
2×2 TypeArray{(:a, :b, :c, :d), Tuple{2, 2}, Symbol, 2} with indices SOneTo(2)×SOneTo(2):
 :a  :c
 :b  :d

julia> sa = SArray(ta)
2×2 SMatrix{2, 2, Symbol, 4} with indices SOneTo(2)×SOneTo(2):
 :a  :c
 :b  :d

julia> julia> @btime findfirst(==(:d), $sa)
  5.951 ns (0 allocations: 0 bytes)
CartesianIndex(2, 2)


julia> @btime findfirst(==(:d), $ta)
  1.073 ns (0 allocations: 0 bytes)
CartesianIndex(2, 2)
```

With these properties `TypeArray` may be useful as no-cost lookups in DimensionalData,jl or AxisKeys.jl
