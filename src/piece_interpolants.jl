abstract type PieceInterpolant{T} <: Interpolant{T} end

struct ConstantInterpolant{T} <: PieceInterpolant{T}
    t::Interval{T}
    value::T
end

unsafe_interpolate(y_i::ConstantInterpolant{T}, ::T) where {T} = y_i.value;

struct LinearInterpolant{T} <: PieceInterpolant{T}
    t::Interval{T}
    times::Tuple{T, T}
    values::Tuple{T, T}
    slope::T
    shift::T

    function LinearInterpolant(t::Interval{T}, times::Tuple{T, T}, values::Tuple{T, T}) where {T}

        slope = (values[2] - values[1]) / (times[2] - times[1]);
        shift = values[1] - slope * times[1];
        return new{T}(t, times, values, slope, shift)
    end
end

unsafe_interpolate(y_i::LinearInterpolant{T}, t::T) where {T} = y_i.slope * t + y_i.shift;

struct LagrangeInterpolant{T} <: PieceInterpolant{T}
    t::Interval{T}
    times::Vector{T}
    values::Vector{T}
    weights::Vector{T}

    function LagrangeInterpolant(t::Interval{T}, times::Vector{T}, values::Vector{T}, weights::Vector{T}) where {T}

        length(times) == length(values) == length(weights) ? nothing : throw(ArgumentError(""));
        return new{T}(t, times, values, weights)
    end
end

function unsafe_interpolate(y_i::LagrangeInterpolant{T}, t::T) where {T}

    for j in eachindex(y_i.times)
        if y_i.times[j] == t
            return y_i.values[j]
        end
    end

    numerator = zero(T);
    denominator = zero(T);

    for j in eachindex(y_i.times, y_i.weights, y_i.values)
        common_j = y_i.weights[j] / (t - y_i.times[j]);
        numerator += common_j * y_i.values[j];
        denominator += common_j;
    end

    return numerator / denominator
end

function (y_i::PieceInterpolant{T})(t::T) where {T}

    y_i.t.lower ≤ t ≤ y_i.t.upper ? nothing : throw(DomainError(t, ""));
    return unsafe_interpolate(y_i, t)
end

@recipe function plot(y_i::P; plotdensity=100) where {P<:PieceInterpolant}

    if plotdensity < 2
        throw(DomainError(""))
    end
    
    x_plot = collect(range(start=y_i.t.lower, stop=y_i.t.upper, length=plotdensity));
    y_plot = y_i.(x_plot);

    xlims --> (y_i.t.lower, y_i.t.upper)
    widen --> true
    label := get(plotattributes, :label, "")

    return x_plot, y_plot
end