//: [Previous](@previous)

import Foundation

var dict: [String:Any] = [
    "countries": [
        "japan": [
            "capital": "tokyo"
        ]
    ]
]

//extension Dictionary {
//    subscript(jsonDict key: Key) -> [String: Any]? {
//        return self[key] as? [String: Any]
//    }
//}
// 给Dictionary 扩展了 下面这个subscript(jsonDict key: Key) -> [String: Any]?  这个下标方法之后，可以更简单的取出字典类型
//dict[jsonDict: "countries"]?[jsonDict: "japan"]?["capital"]

extension Dictionary {
    subscript(jsonDict key: Key) -> [String: Any]? {
        get {
            self[key] as? [String: Any]
        }
        set {
            self[key] = newValue as? Value
        }
    }
}

//dict[jsonDict: "countries"]?[jsonDict: "japan"] = nil


extension Dictionary {
    subscript(jsonDict key: Key) -> String? {
        get {
            self[key] as? String
        }
        set {
            self[key] = newValue as? Value
        }
    }
}
dict[jsonDict: "countries"]?[jsonDict: "japan"]?[jsonDict: "capital"]?.append("!")
print(dict)


//: [Next](@next)
