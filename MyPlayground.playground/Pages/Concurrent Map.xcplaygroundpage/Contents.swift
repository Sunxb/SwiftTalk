//: [Previous](@previous)

import XCTest


class TestTime: XCTestCase {
    let urls = [
        "https://baidcu.comcmdasmf",
        "dsfadfdsfdasfds",
        "dfads234radfsf  asdfadsf dsf df",
        "dfads234radfsasdfadsf dsf df",
        "dfads234radfsf  asdfadsf dsf df",
        "dfas234radfsf  a、sdfadsf dsf df",
        "dfads234rafsf  asdfadsf dsf df",
        "dfads234radfs  asdfadsf dsf df",
        "dfads234radfs asdfadsf dsf dfs",
        "https://baidcu.comcmdasmf",
        "dsfadfdsfd asfds",
        "dfads234fradfsf  asdfadsf dsf df",
        "dfads234radfsasdfadsf dsf df",
        "dfads234radfsf  asdfadsf dsf df",
        "dfas234radfsf  a、sdffadsf dsf df",
        "dfads234rafsf  asdfadsf dsf df",
        "dfa324ds234radfs  asdfadsf dsf df",
        "dfads234radfs asdfadsf dsf dfs",
        "httpsffrds://baidcu.comcmdasmf",
        "dsfadfdsfdasfds",
        "dfad    s234radfsf  asdfadsf dsf df",
        "dfads234radfsasdfadsf dsf df",
        "dfads2s34rqadfsf  asdfadsf dsf df",
        "dfas23d4radfsf  a、sdfadsf fdsf df",
        "dfads234rafsf  asdfadsf dsf df",
        "dfads234radfs  asdfadsf dsf df",
        "dfads234radfs asdfaf dsf dsf dfs"
    ]

    func testTime() {
        measure {
            let result = urls.map { url in
                URL(string: url)?.absoluteString.count ?? 0
            }
            let count = result.reduce(0, +)
        }
    }

}

TestTime.defaultTestSuite.run()


extension Array {
    func concurrentmMap<T>(_ transform: (Element) -> T) -> [T] {
        var result = Array<T?>(repeating: nil, count: count)
        DispatchQueue.concurrentPerform(iterations: count) { idx in
            let transformed = transform(self[idx])
            result[idx] = transformed
        }
        
        return result.map { $0! }
    }
}

//measure


//time {
//    let result = urls.map { $0.count }
//    let count = result.reduce(0, +)
//}
//: [Next](@next)

