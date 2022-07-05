//: [Previous](@previous)

import Foundation

//struct Path {
//    var path: String
//
//    init(_ path: String) {
//        self.path = path
//    }
//
//    func appending(_ component: String) -> Path {
//        return Path(path + "/" + component)
//    }
//}
//
//
////let path = Path("/Users/chris/test.md")
//let path = Path("/Users/chris")
//path.appending("test.md")

enum Directory {}
enum File {}

struct Path<FileType> {
    var components: [String]
    
    private init(_ components: [String]) {
        self.components = components
    }
    
    func render() -> String {
        return "/" + components.joined(separator: "/")
    }
}

extension Path where FileType == Directory {
    init(directoryComponents: [String]) {
        self.components = directoryComponents
    }
    
    func appending(directory: String) -> Path<Directory> {
        return Path<Directory>(directoryComponents: components + [directory])
    }
    
    func appending(file: String) -> Path<File> {
        return Path<File>(components + [file])
    }
}

let path = Path(directoryComponents: ["Users", "charis"])
//let path2 = path.appending(file: "test.md")
let path2 = path.appending(directory: "download")
let path3 = path2.appending(file: "test.md")

/// 总结
/// 通过封装一个Path结构体 来管理我们的文件路径，避免在某些方法中传入随便拼接的文件路径字符串
/// 路径有文件夹 和 文件 之分，如果路径是一个文件的话，那这个路径应该不能继续appending
/// 代码中设计了两个枚举，Directory和File, 然后给Path一个泛型，然后通过有条件的扩展来增加appending方法
/// `extension Path where FileType == Directory`
/// 这样只有在FileType是Directory的时候，才能调用下面的两个appending方法，而且是编译时期的特性。

//: [Next](@next)
