//: [Previous](@previous)

import Foundation

typealias SqlValue = String

//final class Query<A> {
//    typealias Placeholder = String
//
//    let sqls: String
//    let values: [SqlValue]
//    let parse: ([SqlValue]) -> A
//
//    init(values: [SqlValue], build: ([Placeholder]) -> String, parse: @escaping ([SqlValue]) -> A) {
//        let placehodlers = values.enumerated().map({ "$\($0.0 + 1)" })
//        self.values = values
//        self.sqls = build(placehodlers)
//        self.parse = parse
//    }
//}
//
//
//
//let id = "1234"
//let query = Query<String>(values: [id]) { placeholders in
//    return "select * from users where id = \(placeholders[0])"
//} parse: { $0[0] }

struct QueryPart {
    var sql: String
    var values: [SqlValue]
}

struct Query<A> {
    let query: QueryPart
    let parse: ([SqlValue]) -> A
    
    init(_ part: QueryPart, parse: @escaping ([SqlValue]) -> A) {
        self.query = part
        self.parse = parse
    }
}

extension QueryPart: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        self.sql = value
        self.values = []
    }
}

struct QueryPartStringInterpolation: StringInterpolationProtocol {
    typealias StringLiteralType = String
    
    var sql: String = ""
    var values: [SqlValue] = []
    
    init(literalCapacity: Int, interpolationCount: Int) {
    }
    
    mutating func appendLiteral(_ literal: String) {
        sql += literal
    }
    
    mutating func appendInterpolation(param value: SqlValue) {
        sql += "$\(values.count + 1)"
        values.append(value)
    }
}

extension QueryPart: ExpressibleByStringInterpolation {
    typealias StringInterpolation = QueryPartStringInterpolation
    
    init(stringInterpolation: QueryPartStringInterpolation) {
        self.sql = stringInterpolation.sql
        self.values = stringInterpolation.values
    }
}

let id = "1234"
let query = Query<String>("select * from users where id = \(param: id)", parse: { $0[0] }).query
assert(query.sql == "select * from users where id = $1")
assert(query.values == ["1234"])

//: [Next](@next)
