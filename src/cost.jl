struct Cost
    initial::Function   # c_0(ẋ_0, x_0, p, t_0)
    final::Function  # c_f(ẋ_f, x_f, p, t_f)
    running::Function   # c(ẋ(t), x(t), u(t), p, t)
end

struct CostSolution{T, C<:Interpolant{T}}
    intial::T
    final::T
    running::C
    running_integrated::T
    total::T
end