import Foundation

class ZFC: FOL.Theory {
    static var emptySet = FOL.Constant(name: "∅")
    static var subordinate = FOL.Predicate(name: "∈", arity: 2)
    static var equal = FOL.Predicate(name: "=", arity: 2)
}

infix operator ∈: ComparisonPrecedence
func ∈(_ lhs: FOL.Term, _ rhs: FOL.Term) -> FOL.Formula {
    return ZFC.subordinate(lhs, rhs)
}

func ∈(_ lhs: FOL.Variable, _ rhs: FOL.Term) -> FOL.Formula {
    return ZFC.subordinate(FOL.Term.variable(identity: lhs), rhs)
}

func ∈(_ lhs: FOL.Variable, _ rhs: FOL.Variable) -> FOL.Formula {
    return ZFC.subordinate(FOL.Term.variable(identity: lhs), FOL.Term.variable(identity: rhs))
}

func ∈(_ lhs: FOL.Term, _ rhs: FOL.Variable) -> FOL.Formula {
    return ZFC.subordinate(lhs, FOL.Term.variable(identity: rhs))
}

func ==(_ lhs: FOL.Term, _ rhs: FOL.Term) -> FOL.Formula {
    return ZFC.equal(lhs, rhs)
}

func ==(_ lhs: FOL.Variable, _ rhs: FOL.Term) -> FOL.Formula {
    return ZFC.equal(FOL.Term.variable(identity: lhs), rhs)
}

func ==(_ lhs: FOL.Variable, _ rhs: FOL.Variable) -> FOL.Formula {
    return ZFC.equal(FOL.Term.variable(identity: lhs), FOL.Term.variable(identity: rhs))
}

func ==(_ lhs: FOL.Term, _ rhs: FOL.Variable) -> FOL.Formula {
    return ZFC.equal(lhs, FOL.Term.variable(identity: rhs))
}

extension /* axioms */ ZFC {
    @objc
    func extensionality() -> Any {
        let x = FOL.Variable(name: "x")
        let y = FOL.Variable(name: "y")
        let z = FOL.Variable(name: "z")
        return (∀x)((∀y)((∀z)(z∈x ↔ z∈y) ↔ (x==y)))
    }
}
