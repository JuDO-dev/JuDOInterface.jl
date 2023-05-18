struct DOProblem{T, T0<:Union{T, Interval{T}}, TF<:Union{T, Interval{T}},
    XS<:Interpolant{T}, US<:Interpolant{T},
    E<:Equations, C<:Union{Nothing, Cost}} <: Problem{T}
    
    t_0::T0
    t_f::TF
    x::Vector{DifferentialVariable{T, XS}}
    u::Vector{AlgebraicVariable{T, US}}
    p::Vector{Parameter{T}}
    equations::E
    cost::C
end

const DFProblem{T, T0, TF, XS, US, E} = DOProblem{T, T0, TF, XS, US, E, Nothing};

const FixedTimeDOProblem{T, XS, US, E, C} = DOProblem{T, T, T, XS, US, E, C};
const FixedTimeDFProblem{T, XS, US, E} = DFProblem{T, T, T, XS, US, E};