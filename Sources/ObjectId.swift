//
//  ObjectId.swift
//  BSON
//
//  Created by Joannis Orlandos on 23/01/16.
//  Copyright © 2016 Robbert Brandsma. All rights reserved.
//
import Foundation

#if os(Linux)
    import Glibc
#endif


public struct ObjectId {
    public typealias Raw = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
    
    #if os(Linux)
    private static var random: UInt8 = Int32(rand()).bsonData[0]
    #else
    private static var random: UInt8 = UInt8(arc4random_uniform(255))
    #endif
    private static var counter: Int16 = 0
    
    public var storage: Raw
    
    /// Generate a new random ObjectId.
    public init() {
        let currentTime = NSDate()
        
        var data = [UInt8]()
        
        // Take the current UNIX epoch as Int32 and take it's bytes
        data += Int32(currentTime.timeIntervalSince1970).bsonData
        
        // Take the machine identifier
        // TODO: Change this to a MAC address
        data += Array(NSProcessInfo.processInfo().hostName.hash.bsonData[0...2])
        
        // Take the process identifier as 2 bytes
        data += Array(NSProcessInfo.processInfo().processIdentifier.bsonData[0...1])
        
        // Take a random number
        data += [ObjectId.random]
        
        // And add a counter as 2 bytes and increment it
        data += ObjectId.counter.bsonData
        ObjectId.counter += 1
        
        self.storage = (data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11])
    }
    
    /// Initialize a new ObjectId from given Hexadecimal string, such as "0123456789abcdef01234567".
    ///
    /// **Note that this string should always be a valid hexadecimal string of 24 characters.**
    ///
    /// Throws errors in case of an invalid string (e.g. wrong length)
    public init(_ hexString: String) throws {
        guard hexString.characters.count == 24 else {
            throw DeserializationError.ParseError
        }
        
        var data = [UInt8]()
        
        var gen = hexString.characters.generate()
        while let c1 = gen.next(), c2 = gen.next() {
            let s = String([c1, c2])
            
            guard let d = UInt8(s, radix: 16) else {
                break
            }
            
            data.append(d)
        }
        
        guard data.count == 12 else {
            throw DeserializationError.ParseError
        }
        
        storage = (data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11])
    }
    
    public init(raw: Raw) {
        storage = raw
    }
    
    public init(bsonData data: [UInt8]) throws {
        guard data.count == 12 else {
            throw DeserializationError.InvalidElementSize
        }
        
        storage = (data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11])
    }
    
    public var hexString: String {
        let data = [storage.0, storage.1, storage.2, storage.3, storage.4, storage.5, storage.6, storage.7, storage.8, storage.9, storage.10, storage.11]
        
        return data.map{
            var s = String($0, radix: 16, uppercase: false)
            
            while s.characters.count < 2 {
                s = "0" + s
            }
            return s
        }.joinWithSeparator("")
    }
}