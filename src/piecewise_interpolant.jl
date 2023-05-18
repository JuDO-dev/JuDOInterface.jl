struct PiecewiseInterpolant{T, P<:PieceInterpolant} <: Interpolant{T}
    piece_interpolants::Vector{P}

    function PiecewiseInterpolant(y::Vector{P}) where {T, P<:PieceInterpolant{T}}

        for i in 2:length(y)
            y[i].t.lower == y[i-1].t.upper ? nothing : throw(ArgumentError(""));
        end
        return new{T, P}(y)
    end
end

function Base.getindex(y::PiecewiseInterpolant, i::Integer)
    
    1 ≤ i ≤ length(y.piece_interpolants) ? nothing : throw(BoundsError(y, i));
    return y.piece_interpolants[i]
end

Base.firstindex(y::PiecewiseInterpolant) = 1;

Base.lastindex(y::PiecewiseInterpolant) = length(y.piece_interpolants);

transform(y_i::PieceInterpolant) = y_i.t.lower;
transform(t) = t;

function (y::PiecewiseInterpolant{T})(t::T) where {T}

    y[1].t.lower ≤ t ≤ y[end].t.upper ? nothing : throw(DomainError(t, ""));

    i = searchsortedlast(y.piece_interpolants, t; lt=(t_i, y_i)->isless(t_i, y_i.t.lower));
    return y[i](t)
end

@recipe function plot(y::PiecewiseInterpolant{T, P}; plotdensity=100) where {T, P<:PieceInterpolant}

    t_0 = y[1].t.lower;
    t_f = y[end].t.upper;
    
    xlims --> (t_0, t_f)
    widen --> true

    x_plot = [collect(range(
        start=y[i].t.lower,
        stop=y[i].t.upper,
        length=max(2, round(Int, plotdensity * (y[i].t.upper - y[i].t.lower) / (t_f - t_0)))
    )) for i in 1:lastindex(y)];
    
    y_plot = [y[i].(x_plot[i]) for i in 1:lastindex(y)];

    return vcat(x_plot...), vcat(y_plot...)
end