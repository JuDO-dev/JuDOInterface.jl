struct DifferentialVariable{T, S<:Interpolant{T}}
    bounds::Interval{T}
    initial::Interval{T}
    final::Interval{T}
    start::S
    
    function DifferentialVariable(bounds::I, initial::I, final::I, start::S) where
        {T<:Real, I<:Interval{T}, S<:Interpolant{T}}

        initial ⊆ bounds ? nothing : throw(DomainError(initial, "Ensure initial ⊆ bounds"));
        final ⊆ bounds   ? nothing : throw(DomainError(final, "Ensure final ⊆ bounds"));
        
        return new{T, S}(bounds, initial, final, start)
    end
end

struct AlgebraicVariable{T, S<:Interpolant{T}}
    bounds::Interval{T}
    start::S
end