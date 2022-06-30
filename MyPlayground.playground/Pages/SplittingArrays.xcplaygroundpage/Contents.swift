//: [Previous](@previous)

import Foundation
import XCTest

enum Block: Equatable {
    case code(String)
    case text(String)
    case header(String)
}

enum PlaygroundElement: Equatable {
    case code(String)
    case documentation([Block])
}

// 最普通的实现方式，就是循环整个blocks 数组，如果是code，直接添加到playground数组，如果是其他的类型，先放到一个暂时的数组中，等待判断下一个元素的类型
// 如果是连续的非code类型，要保证放到一个数组中，再保存到playground
//func playground(blocks: [Block]) -> [PlaygroundElement] {
//    var result: [PlaygroundElement] = []
//    var documents: [Block] = []
//    for block in blocks {
//        switch block {
//        case .code(let code):
//            if !documents.isEmpty {
//                result.append(.document(documents))
//                documents = []
//            }
//            result.append(.code(code))
//        default:
//            documents.append(block)
//        }
//    }
//
//    if !documents.isEmpty {
//        result.append(.document(documents))
//        documents = []
//    }
//
//    return result
//}

// 判断documents是否为空的代码是有重复的，所以我们再方法内存新建一个方法，把这部分代码抽取出来
//func playground(blocks: [Block]) -> [PlaygroundElement] {
//    var result: [PlaygroundElement] = []
//    var documents: [Block] = []
//
//    func flush() {
//        if !documents.isEmpty {
//            result.append(.documentation(documents))
//            documents = []
//        }
//    }
//
//    for block in blocks {
//        switch block {
//        case .code(let code):
//            flush()
//            result.append(.code(code))
//        default:
//            documents.append(block)
//        }
//    }
//    flush()
//    return result
//}

// 如果采用上面的方法，我们必须要在两处调用flush函数，所以我们换了一种处理思路，那就是每次循环blocks时，判断此时的playground数组最后一个是什么
// 如果是code类型，不管即将添加的是哪种类型，直接添加
// 如果是documents类型，那就得看新添加的是code类型还是非code类型
// - 如果要加入的是code类型，直接添加
// - 如果要加入的是非code类型， 把playground数组最后一个移除，然后跟新添加的合并成一个再次添加
//func playground(blocks: [Block]) -> [PlaygroundElement] {
//    var result: [PlaygroundElement] = []
//    for block in blocks {
//        switch block {
//        case .code(let code):
//            result.append(.code(code))
//        default:
//            var newBlock = [block]
//            if case let .documentation(existBlock) = result.last {
//                result.removeLast()
//                newBlock = existBlock + newBlock
//            }
//            result.append(.documentation(newBlock))
//        }
//    }
//    return result
//}

// 下面这种优化，就完全罗列出了三种我们需要处理的情况，看起来很清晰
func playground(blocks: [Block]) -> [PlaygroundElement] {
    var result: [PlaygroundElement] = []
    for block in blocks {
        switch (block, result.last) {
        case let (.code(code), _):
            result.append(.code(code))
        case let (_, .documentation(existBlock)):
            result.removeLast()
            result.append(.documentation(existBlock + [block]))
        default:
            result.append(.documentation([block]))
        }
    }
    return result
}

// 去掉for循环的优化
func playground_finish(blocks: [Block]) -> [PlaygroundElement] {
    return blocks.reduce([]) { partialResult, block in
        switch (block, partialResult.last) {
        case let (.code(code), _):
            return partialResult + [.code(code)]
        case let (_, .documentation(existBlock)):
            return partialResult.dropLast() + [.documentation(existBlock + [block])]
        default:
            return partialResult + [.documentation([block])]
        }
    }
}

func AssertEqual<A: Equatable>(_ l: [A], _ r: [A]) {
    var message = ""
    dump(l, to: &message)
    message += "\n\n is not equal to \n\n"
    dump(r, to: &message)
    XCTAssertEqual(l, r, message)
}

class SplittingArrayTest: XCTestCase {
    func testPlayground() {
        let sample: [Block] = [
            .code("swift sample code"),
            .header("My Header"),
            .text("Hello"),
            .code("more")
        ]
                
        let result: [PlaygroundElement] = [
            .code("swift sample code"),
            .documentation([Block.header("My Header"), Block.text("Hello")]),
            .code("more")
        ]
        
        AssertEqual(playground(blocks: sample), result)
    }
}

SplittingArrayTest.defaultTestSuite.run()
//: [Next](@next)
