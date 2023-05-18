module JuDOInterface

import RecipesBase: @recipe, @series

include("interval.jl")
export Interval

abstract type Interpolant{T} end
include("piece_interpolants.jl")
export ConstantInterpolant, LinearInterpolant, LagrangeInterpolant
include("piecewise_interpolant.jl")
export PiecewiseInterpolant

include("variables.jl")
export DifferentialVariable, AlgebraicVariable

include("parameter.jl")
export Parameter

abstract type Equations end
include("equations.jl")
export ODEquations, DAEquations, ResidualEquations

include("cost.jl")
export Cost

abstract type Problem{T<:Real} end
include("problems.jl")
export DOProblem, DFProblem,
FixedTimeDOProblem, FixedTimeDFProblem

abstract type Solution{T<:Real} end
include("solutions.jl")
export DOSolution

end
