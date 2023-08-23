from sympy import symbols, Or, And, Not, Implies, Equivalent, to_cnf, to_dnf


def main():
    # Define symbols
    A, B, C, D = symbols('A B C D')

    # Define the logical expression
    expr = Implies((And(A, And(B, Or(C, B)))), D)

    # Convert to CNF and DNF
    cnf = to_cnf(expr)
    dnf = to_dnf(expr)

    print("Original Expression:", expr)
    print("CNF:", cnf)
    print("DNF:", dnf)


if __name__ == "__main__":
    main()
