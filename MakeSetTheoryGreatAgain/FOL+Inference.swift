import Foundation

extension FOL.Formula {
    static func unification(_ a: Self, _ b: Self) -> [FOL.Variable : FOL.Term]? {
        fatalError("unification not implemented")
    }
    
    func conjunctiveNormalForm() -> FOL.Formula {
        fatalError("conversion to cnf not implemented")
    }
}

extension FOL {
    struct Sequent {
        let assumptions, conclutions: [Formula]
        
        func checkByResolution(ofMaxDepth: Int) -> Bool {
            fatalError("resolution not implemented")
        }
    }
    
    struct Proof {
        let steps: [Sequent]
    }
}
