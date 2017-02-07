//
//  Value-Extraction.swift
//  BSON
//
//  Created by Robbert Brandsma on 18-04-16.
//
//

import Foundation

extension ValueConvertible {
    /// Returns this value interpeted as a `Double`.
    /// This works for values of the following types:
    ///
    /// - `Double`, returning the exact value
    /// - `String`, using `Double(value)`
    /// - `Bool`, returning `1` for `true` and `0` for `false`
    /// - `Int32`, using `Double(value)`
    /// - `Int`, using `Double(value)`
    ///
    /// If the value cannot be interpeted as a `Double`, nil will be returned.
    public var double : Double? {
        get {
            if let num = self as? Int32 {
                return Double(num)
            } else if let num = self as? Int {
                return Double(num)
            } else if let num = self as? Double {
                return num
            } else if let num = self as? String {
                return Double(num)
            } else if let bool = self as? Bool {
                return bool ? 1 : 0
            }
            
            return nil
        }
        set {
            if let newValue = newValue as? Self {
                self = newValue
            }
        }
    }
    
    /// Returns this value interpeted as a `String`.
    /// This works for values of the following types:
    ///
    /// - `String`, using the exact value
    /// - `Int`, using `String(value)`
    /// - `Int32`, using `String(value)`
    /// - `Double`, using `String(value)`
    /// - `Bool`, returning `"true"` for `true` and `"false"` for `false`
    /// - `ObjectId`, using `value.hexString`
    ///
    /// If the value cannot be interpeted as a `String`, nil will be returned.
    public var string : String? {
        get {
            if let s = self as? String {
                return s
            } else if let num = self as? Int {
                return String(num)
            } else if let num = self as? Double {
                return String(num)
            } else if let bool = self as? Bool {
                return bool ? "true" : "false"
            } else if let num = self as? Int32 {
                return String(num)
            } else if let oid = self as? ObjectId {
                return oid.hexString
            }
            
            return nil
        }
        set {
            if let newValue = newValue as? Self {
                self = newValue
            }
        }
    }
    
    /// Returns this value interpeted as a `Int64`.
    /// This works for values of the following types:
    ///
    /// - `Int32`, using `Int64(value)`
    /// - `Int`, using `In64(value)`
    /// - `Double`, using `In64(value)`
    /// - `String`, using `In64(value)`
    /// - `Bool`, returning `1` for `true` and `0` for `false`
    ///
    /// If the value cannot be interpeted as an `Int64`, nil will be returned.
    public var int64 : Int64? {
        get {
            if let num = self as? Int32 {
                return Int64(num)
            } else if let num = self as? Int {
                return Int64(num)
            } else if let num = self as? Double {
                return Int64(num)
            } else if let num = self as? String {
                return Int64(num)
            } else if let bool = self as? Bool {
                return bool ? 1 : 0
            }
            
            return nil
        }
        set {
            if let newValue = newValue as? Self {
                self = newValue
            }
        }
    }
    
    /// Returns this value interpeted as a `Int`.
    /// This works for values of the following types:
    ///
    /// - `Int32`, using `Int(value)`
    /// - `Int`, using the exact value
    /// - `Double`, using `Int(value)`
    /// - `String`, using `Int(value)`
    /// - `Bool`, returning `1` for `true` and `0` for `false`
    ///
    /// If the value cannot be interpeted as an `Int`, nil will be returned.
    public var int : Int? {
        get {
            if let num = self as? Int32 {
                return Int(num)
            } else if let num = self as? Int {
                return num
            } else if let num = self as? Double {
                return Int(num)
            } else if let num = self as? String {
                return Int(num)
            } else if let bool = self as? Bool {
                return bool ? 1 : 0
            }
            
            return Int(int64)
        }
        set {
            if let newValue = newValue as? Self {
                self = newValue
            }
        }
    }
    
    /// Returns this value interpeted as a `Int`.
    /// This works for values of the following types:
    ///
    /// - `Int32`, using the exact value
    /// - `Int`, using `Int(value)`
    /// - `Double`, using `Int(value)`
    /// - `String`, using `Int(value)`
    /// - `Bool`, returning `1` for `true` and `0` for `false`
    ///
    /// If the value cannot be interpeted as an `Int`, nil will be returned.
    public var int32 : Int32? {
        get {
            if let num = self as? Int32 {
                return Int32(num)
            } else if let num = self as? Int {
                return Int32(num)
            } else if let num = self as? Double {
                return Int32(num)
            } else if let num = self as? String {
                return Int32(num)
            } else if let bool = self as? Bool {
                return bool ? 1 : 0
            }
            
            return nil
        }
        set {
            if let newValue = newValue as? Self {
                self = newValue
            }
        }
    }
    
    /// Returns the raw value only if the underlying value is stored as `Double`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? Double instead")
    public var doubleValue : Double? {
        return self as? Double
    }
    
    /// Returns the raw value only if the underlying value is stored as `String`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? String instead")
    public var stringValue : String? {
        return self as? String
    }
    
    /// Returns the raw value only if the underlying value is stored as `Document`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? Document instead")
    public var documentValue : Document? {
        return self as? Document
    }
    
    /// Returns the raw value only if the underlying value is stored as `Bool`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? Bool instead")
    public var boolValue : Bool? {
        return self as? Bool
    }
    
    /// Returns the raw value only if the underlying value is stored as `Date`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? Date instead")
    public var dateValue : Date? {
        return self as? Date
    }
    
    /// Returns the raw value only if the underlying value is stored as `Int32`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? Int32 instead")
    public var int32Value : Int32? {
        return self as? Int32
    }
    
    /// Returns the raw value only if the underlying value is stored as `ObjectId`. Otherwise, returns `nil`.
    @available(4.2, deprecated, message: "Use as? ObjectId instead")
    public var objectIdValue : ObjectId? {
        return self as? ObjectId
    }
}
