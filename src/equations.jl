struct ResidualEquations <: Equations
    n::Int
    r!::Function    # r!(r(t), ẋ(t), x(t), u(t), p, t)
end

Base.length(e::ResidualEquations) = e.n;

struct ODEquations <: Equations 
    n::Int
    f!::Function    # f!(ẋ(t), x(t), u(t), p, t)
end

Base.length(e::ODEquations) = e.n;

struct DAEquations <: Equations
    n_f::Int
    f!::Function    # f!(ẋ(t), x(t), u(t), p, t)
    n_a::Int
    a!::Function    # a!(a(t), x(t), u(t), p, t)
end

Base.length(e::DAEquations) = e.n_f + e.n_a;