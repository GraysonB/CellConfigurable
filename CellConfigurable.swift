//
//  CellConfigurable.swift
//
//  Created by Grayson Bianco on 11/26/20.
//

import UIKit

@propertyWrapper
struct CellConfigurable<Value: Equatable> {
    struct Other<Value: Equatable> {
        var value: Value
    }
    
    private var stored: Value
    
    
    init(wrappedValue initialValue: Value) {
        self.stored = initialValue
    }
    
    var wrappedValue: Value {
        get { fatalError("called wrappedValue getter") }
        set { fatalError("called wrappedValue setter") }
    }
    
    var projectedValue: Other<Value> {
        get { fatalError("called projectedValue getter") }
        set { fatalError("called projectedValue setter") }
    }
    
    static subscript<EnclosingSelf: UICollectionViewCell, FinalValue>(
        _enclosingInstance observed: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, FinalValue>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            observed[keyPath: storageKeyPath].stored
        }
        set {
            if observed[keyPath: storageKeyPath].stored != newValue {
                observed.setNeedsUpdateConfiguration()
            }
            
            observed[keyPath: storageKeyPath].stored = newValue
        }
    }
    
    static subscript<EnclosingSelf: UICollectionViewCell>(
        _enclosingInstance observed: EnclosingSelf,
        projected wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Other<Value>>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Other<Value> {
        get {
            Other(value: observed[keyPath: storageKeyPath].stored)
        }
        set {}
    }
}
