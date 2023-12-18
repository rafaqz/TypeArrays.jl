module TypeArrays

using StaticArrays

export TypeArray

"""
    TypeArray <: StaticArray

An array that stores data entirely in the type.

This can be useful for e.g. very fast `findfirst`
when lookup values are also known at compile time.
"""
struct TypeArray{V,S,T,N} <: StaticArray{S,T,N} end
TypeArray(A::AbstractArray{T,N}) where {T,N} = TypeArray{Tuple(A),Tuple{size(A)...},T,N}()
TypeArray(V::Tuple) = TypeArray{V}()
TypeArray{V}() where V = TypeArray{V,Tuple{length(V)}}()
function TypeArray{V,S}() where {V,S}
    T = mapreduce(typeof, promote_type, V)
    N = length(Tuple(Size(S)))
    TypeArray{V,S,T,N}()
end

Base.@propagate_inbounds function Base.getindex(::TypeArray{V}, i::Int) where V
    V[i]
end

Base.findfirst(f::Function, A::TypeArray{V}; kw...) where V = 
    CartesianIndices(A)[findfirst(f, V; kw...)]
Base.findfirst(f::Function, A::TypeArray{V,<:Any,<:Any,1}; kw...) where V = 
    findfirst(f, V; kw...)

# TODO `searchsorted...`

end
