//
//  PropertyWrapper.swift
//  InjectEm
//
//  Created by Emir Vajzović on 2. 6. 2025..
//

import Foundation

final class Container: @unchecked Sendable {
    static let shared = Container()

    private var builders: [ObjectIdentifier: () -> Any] = [:]
    private let lock = NSRecursiveLock()

    private init() {}

    func register<T>(_ type: T.Type, builder: @escaping () -> T) {
        lock.withLock {
            let key = ObjectIdentifier(type)
            builders[key] = builder
        }
    }

    func resolve<T>(_ type: T.Type) -> T {
        lock.withLock {
            let key = ObjectIdentifier(type)
            guard let builder = builders[key], let service = builder() as? T else {
                fatalError("No registered factory for \(type)")
            }
            return service
        }
    }

    func callAsFunction<T>(_ builder: @escaping () -> T) -> DependencyBuilder<T> {
        DependencyBuilder(builder: builder)
    }
}
