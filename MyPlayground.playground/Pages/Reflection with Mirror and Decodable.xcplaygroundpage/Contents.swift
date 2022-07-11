//: [Previous](@previous)

import Foundation


struct User: Codable {
    var name: String
    var createdAt: Date
    var updatedAt: Date
    var githubId: Int
}

extension User {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.githubId = try container.decode(Int.self, forKey: .githubId)
    }
}

func fieldsAndValues(_ value: Any) {
    let m = Mirror(reflecting: value)
    m.children.forEach { e in
        print("\(e.label!)--\(e.value)")
    }
}

let user = User(name: "name", createdAt: Date(), updatedAt: Date(), githubId: 123)
print(fieldsAndValues(user))

//: [Next](@next)
