//
//  Document+LiteralConvertibles.swift
//  BSON
//
//  Created by Robbert Brandsma on 03-02-16.
//  Copyright © 2016 Robbert Brandsma. All rights reserved.
//

import Foundation

extension Document {
    public var arrayValue: [Value] {
        return self.elements.map{$0.1}
    }
    
    /// Returns the dictionary equivalent of `self`. Subdocuments are nog converted and will still be of type `Document`. If you need these converted to dictionaries, too, you should use `recursiveDictionaryValue` instead.
    public var dictionaryValue: [String : Value] {
        var value = [String : Value]()
        for element in self.elements {
            value[element.0] = element.1
        }
        return value
    }
    
    /// Returns the dictionary equivalent of `self`, converting any contained documents to dictionaries.
    public var recursiveDictionaryValue: [String : Any] {
        var value = [String : Any]()
        for element in self.elements {
            if let subdocument = element.1.documentValue {
                value[element.0] = subdocument.recursiveDictionaryValue
            } else {
                value[element.0] = element.1
            }
        }
        return value
    }
}

extension Document : ArrayLiteralConvertible {
    /// Initialize a Document using an array of `BSONElement`s.
    public init(array: [Value]) {
        elements = array.map { ("", $0) }
        self.enforceArray()
    }
    
    /// For now.. only accept BSONElement
    public init(arrayLiteral arrayElements: Value...) {
        self.init(array: arrayElements)
    }
    
    public mutating func enforceArray() {
        for i in 0..<elements.count {
            elements[i].0 = "\(i)"
        }
    }
}

extension Document : DictionaryLiteralConvertible {
    public init(dictionaryElements: [(String, Value)]) {
        self.elements = dictionaryElements
    }
    
    /// Create an instance initialized with `elements`.
    public init(dictionaryLiteral dictionaryElements: (String, Value)...) {
        self.elements = dictionaryElements
    }
}

extension Document {
    internal init(native: [String: Value]) {
        self.elements = native.map({ $0 })
    }
}