import Foundation

public extension FOL.Variable {
    override var debugDescription: String {
        return name
    }
}

public extension FOL.Constant {
    override var debugDescription: String {
        return name
    }
}

public extension FOL.Function {
    override var debugDescription: String {
        return name
    }
}

extension FOL.Term: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .variable(let identity):
            return identity.debugDescription
        case .constant(let identity):
            return identity.debugDescription
        case .function(let identity, let arguments):
            let partial = arguments.debugDescription.trimmingCharacters(in: ["[", "]"])
            return "\(identity.name)(\(partial))"
        }
    }
}
