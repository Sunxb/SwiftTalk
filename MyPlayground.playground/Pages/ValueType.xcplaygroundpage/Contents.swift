import Foundation
/*
var sampleBytes: [UInt8] = [0x0b,0xad,0xf0,0x0d]

final class Box<A> {
    let unbox: A
    init(_ value: A) {
        unbox = value
    }
}

struct MyData {
    var data = Box(NSMutableData())
    var dataForWriting: NSMutableData {
        mutating get {
            if isKnownUniquelyReferenced(&data) {
                return data.unbox
            }
            print("making a copy")
            data = Box(data.unbox.mutableCopy() as! NSMutableData)
            return data.unbox
        }
    }
    
    mutating func append(_ bytes: [UInt8]) {
        dataForWriting.append(bytes, length: bytes.count)
    }
}

extension MyData: CustomDebugStringConvertible {
    var debugDescription: String {
        return String(describing: data)
    }
}

var data = MyData()
 var copy = data

print("Before loop")
for _ in 0..<10 {
    data.append(sampleBytes)
}

print("Using reduce")
(0..<10).reduce(data) { result, _ in
    var copy = result
    copy.append(sampleBytes)
    return copy
}
*/


var sampleBytes: [UInt8] = [0x0b,0xad,0xf0,0x0d]
//let nsData = NSMutableData(bytes: sampleBytes, length: sampleBytes.count)
//
//nsData.append(sampleBytes, length: sampleBytes.count)

//let nsOtherData = nsData
//nsData.append(sampleBytes, length: sampleBytes.count)

//let nsOtherData = nsData.mutableCopy() as! NSMutableData
//nsData.append(sampleBytes, length: sampleBytes.count)

//let data = Data(bytes: sampleBytes, count: sampleBytes.count)

//var data = Data(bytes: sampleBytes, count: sampleBytes.count)
//data.append(contentsOf: sampleBytes)

final class Box<A> {
    let unbox: A
    init(_ value: A) {
        self.unbox = value
    }
}

struct MyData {
    var data = Box(NSMutableData())
    
    var dataForWriting: NSMutableData {
        mutating get {
            if isKnownUniquelyReferenced(&data) {
                return data.unbox
            }
            print("make a copy")
            data = Box(data.unbox.mutableCopy() as! NSMutableData)
            return data.unbox
        }
    }
    
    mutating func append(_ bytes: [UInt8]) {
        dataForWriting.append(bytes, length: bytes.count)
    }
}

extension MyData: CustomDebugStringConvertible {
    var debugDescription: String {
        return String(describing: data)
    }
}

var data = MyData()
var copy = data
for _ in 0..<10 {
    data.append(sampleBytes)
}

(0..<10).reduce(data) { result, _ in
    var copy = result
    copy.append(sampleBytes)
    return copy
}
