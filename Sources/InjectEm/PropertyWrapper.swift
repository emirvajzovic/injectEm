//
//  PropertyWrapper.swift
//  InjectEm
//
//  Created by Emir Vajzović on 2. 6. 2025..
//

@propertyWrapper
struct Injected<T> {
    
    var wrappedValue: T {
        return Container.shared.resolve(T.self)
    }
}
