struct DOSolution{T, X<:Interpolant{T}, U<:Interpolant{T},
    R<:Interpolant{T}, C<:Union{Nothing, CostSolution{<:Interpolant{T}}}} <: Solution{T}
    
    t_0::T
    t_f::T
    x::Vector{X}
    u::Vector{U}
    p::Vector{T}
    residuals::Vector{R}
    residuals_integrated::T
    cost::C
end

const DFSolution{T, X, U, R} = DOSolution{T, X, U, R, Nothing};