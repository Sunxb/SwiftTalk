//: [Previous](@previous)

import XCTest

final class ThreadSafe<V> {
    private var _value: V
    private let queue = DispatchQueue(label: "safe_queue")
    
    init(_ value: V) {
        self._value = value
    }
    
    var value: V {
        queue.sync { _value }
    }
    
    func atomic(_ transform: (inout V) -> Void) {
        queue.sync {
            transform(&self._value)
        }
    }
}

extension Array {
    func concurrentmMap<T>(_ transform: (Element) -> T) -> [T] {
        let operate = ThreadSafe(Array<T?>(repeating: nil, count: count))
        // 内部并发执行，全部执行完在执行后面的
        DispatchQueue.concurrentPerform(iterations: count) { idx in
            let transformed = transform(self[idx])
//            usleep(100000) //will sleep for 0.1 second
            operate.atomic { $0[idx] = transformed }
        }
        return operate.value.map { $0! }
    }
}


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
        "https://baidcu.comcmdasmf"
    ]

    func testMapTime() {
        measure {
            let result = urls.map { url -> Int in
//                usleep(100000) //will sleep for 0.1 second
                return URL(string: url)?.absoluteString.count ?? 0
            }
            let count = result.reduce(0, +)
        }
    }
    
    func testConcurrentMapTime() {
        measure {
            let result = urls.concurrentmMap { url -> Int in
                return URL(string: url)?.absoluteString.count ?? 0
            }
            let count = result.reduce(0, +)
        }
    }

}

TestTime.defaultTestSuite.run()



//measure


//time {
//    let result = urls.map { $0.count }
//    let count = result.reduce(0, +)
//}
//: [Next](@next)

