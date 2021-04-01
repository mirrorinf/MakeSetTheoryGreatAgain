import Foundation

extension FOL {
    // Support axiom schema with single formula
    class Theory: NSObject {
        private static let sharedInstance = Theory()
        
        func allAxioms() -> [Selector] {
            var c: AnyClass? = object_getClass(self)
            let base: AnyClass? = object_getClass(Theory.sharedInstance)
            let baseDes = String(cString: class_getName(base))
            var ns: [Selector] = []

            while true {
                let des = String(cString: class_getName(c))
                if des == baseDes {
                    return ns
                }
                var count: UInt32 = 0
                let methods = class_copyMethodList(c, &count)!
                for i in 0..<count {
                    let method = methods[Int(i)]
                    let methodName = method_getName(method)
                    let nameStr = String(cString: sel_getName(methodName))
                    if nameStr == "init" {
                        continue
                    }
                    ns.append(methodName)
                }
                c = class_getSuperclass(c)
            }
        }
    }
}
