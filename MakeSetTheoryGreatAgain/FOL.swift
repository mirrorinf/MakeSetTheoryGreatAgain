import Foundation

public /* namespace */ enum FOL {}

public extension FOL {
    class Variable : NSObject {
        let name: String
        
        init(name n: String) {
            name = n
        }
    }
    
    class Function : NSObject {
        let name: String
        let arity: Int
        
        init(name n: String, arity a: Int) {
            name = n
            arity = a
        }
    }
    
    class Constant : NSObject {
        let name: String
        
        init(name n: String) {
            name = n
        }
    }
    
    class Predicate : NSObject {
        let name: String
        let arity: Int
        
        init(name n: String, arity a: Int) {
            name = n
            arity = a
        }
    }
    
    enum Term {
        case variable(identity: Variable)
        case constant(identity: Constant)
        indirect case function(identity: Function, arguments: [Term])
    }
    
    enum Formula {
        case predicate(identity: Predicate, arguments: [Term])
        indirect case negation(_: Formula)
        indirect case conjunction(left: Formula, right: Formula)
        indirect case disjunction(left: Formula, right: Formula)
        indirect case implication(left: Formula, right: Formula)
        indirect case biconditional(left: Formula, right: Formula)
        indirect case universal(binding: Variable, in: Formula)
        indirect case existential(binding: Variable, in: Formula)
    }
}

public extension FOL.Term {
    func replace(_ toBeReplaced: FOL.Variable, with newTerm: FOL.Term) -> FOL.Term {
        switch self {
        case .constant(_):
            return self
        case .variable(let identity):
            if identity == toBeReplaced {
                return newTerm
            } else {
                return self
            }
        case .function(let identity, let arguments):
            let newArguments = arguments.map{$0.replace(toBeReplaced, with: newTerm)}
            return .function(identity: identity, arguments: newArguments)
        }
    }
}

public extension FOL.Formula {
    func replace(_ toBeReplaced: FOL.Variable, with newTerm: FOL.Term) -> FOL.Formula {
        return self._replace(toBeReplaced, with: newTerm, boundVaribles: [])
    }
    
    private func _replace(_ toBeReplaced: FOL.Variable, with newTerm: FOL.Term, boundVaribles: [FOL.Variable]) -> FOL.Formula {
        if boundVaribles.contains(toBeReplaced) {
            return self
        }
        switch self {
        case .biconditional(let left, let right):
            return .biconditional(left: left._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles), right: right._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles))
        case .conjunction(let left, let right):
            return .conjunction(left: left._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles), right: right._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles))
        case .disjunction(let left, let right):
            return .disjunction(left: left._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles), right: right._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles))
        case .implication(let left, let right):
            return .implication(left: left._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles), right: right._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles))
        case .negation(let left):
            return .negation(left._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles))
        case .predicate(let identity, let arguments):
            let newArguments = arguments.map{$0.replace(toBeReplaced, with: newTerm)}
            return .predicate(identity: identity, arguments: newArguments)
        case .universal(let binding, let formula):
            return .universal(binding: binding, in: formula._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles + [binding]))
        case .existential(let binding, let formula):
            return .existential(binding: binding, in: formula._replace(toBeReplaced, with: newTerm, boundVaribles: boundVaribles + [binding]))
        }
    }
}
