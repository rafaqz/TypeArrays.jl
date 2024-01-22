module TypeArrays

using StaticArrays

export TypeArray

"""
    TypeArray <: StaticArray

    TypeArray{values}()
    TypeArray(values::Union{Tuple,AbstractArray})

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

for f in (:findfirst, :findlast, :findall, :findmin, :findmax)
    @eval begin
        Base.@assume_effects :foldable Base.$f(f::Function, A::TypeArray{V}) where V = 
            CartesianIndices(A)[$f(f, V)]
        Base.@assume_effects :foldable Base.$f(f::Function, A::TypeArray{V,<:Any,<:Any,1}) where V = 
            $f(f, V)
    end
end

for f in (:findprev, :findnext)
    @eval begin
        Base.@assume_effects :foldable Base.$f(f::Function, A::TypeArray{V}, i::CartesianIndex) where V = 
            CartesianIndices(A)[$f(f, V, LinearIndices(A)[i])]
        Base.@assume_effects :foldable Base.$f(f::Function, A::TypeArray{V,<:Any,<:Any,1}, i::Integer) where V = 
            $f(f, V, i)
    end
end

# TODO `searchsorted...`

end
