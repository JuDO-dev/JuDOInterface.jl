struct Interval{T}
    lower::T
    upper::T

    function Interval(lower::T, upper::T) where {T<:Real}

        lower ≤ upper ? nothing : throw(DomainError(upper, "Ensure lower ≤ upper"));
        return new{T}(lower, upper)
    end
end

..(lower, upper) = Interval(lower, upper);

Base.in(item::T, t::Interval{T}) where {T} = t.lower ≤ item ≤ t.upper;

Base.issubset(t_inner::Interval, t_outer::Interval) = t_outer.lower ≤ t_inner.lower && t_inner.upper ≤ t_outer.upper;

Base.show(io::IO, ::MIME"text/plain", t::Interval{T}) where {T} = 
    print(io, "Interval{$T} [", t.lower, ", ", t.upper, "]");