import Foundation

prefix operator ¬
public prefix func ¬(_ f: FOL.Formula) -> FOL.Formula {
    return .negation(f)
}

infix operator ∧: LogicalConjunctionPrecedence
public func ∧(_ lhs: FOL.Formula, _ rhs: FOL.Formula) -> FOL.Formula {
    return .conjunction(left: lhs, right: rhs)
}

infix operator ∨: LogicalDisjunctionPrecedence
public func ∨(_ lhs: FOL.Formula, _ rhs: FOL.Formula) -> FOL.Formula {
    return .disjunction(left: lhs, right: rhs)
}

infix operator →: LogicalDisjunctionPrecedence
public func →(_ lhs: FOL.Formula, _ rhs: FOL.Formula) -> FOL.Formula {
    return .implication(left: lhs, right: rhs)
}

infix operator ↔: LogicalDisjunctionPrecedence
public func ↔(_ lhs: FOL.Formula, _ rhs: FOL.Formula) -> FOL.Formula {
    return .biconditional(left: lhs, right: rhs)
}

public extension FOL {
    enum __FormulaBuildingVariableBinder {
        case universal(_: FOL.Variable)
        case existential(_: FOL.Variable)
        
        func callAsFunction(_ f: FOL.Formula) -> FOL.Formula {
            switch self {
            case .universal(let variable):
                return .universal(binding: variable, in: f)
            case .existential(let variable):
                return .existential(binding: variable, in: f)
            }
        }
    }
}

prefix operator ∀
public prefix func ∀(_ x: FOL.Variable) -> FOL.__FormulaBuildingVariableBinder {
    return .universal(x)
}

prefix operator ∃
public prefix func ∃(_ x: FOL.Variable) -> FOL.__FormulaBuildingVariableBinder {
    return .existential(x)
}

public extension FOL.Function {
    func callAsFunction(_ args: FOL.Term...) -> FOL.Term {
        guard arity == args.count else {
            fatalError("Making function application with wrong number of arguments")
        }
        return .function(identity: self, arguments: args)
    }
}

public extension FOL.Predicate {
    func callAsFunction(_ args: FOL.Term...) -> FOL.Formula {
        guard arity == args.count else {
            fatalError("Making predicate with wrong number of arguments")
        }
        return .predicate(identity: self, arguments: args)
    }
}
