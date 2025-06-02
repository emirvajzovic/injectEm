//
//  ContainerFactory.swift
//  InjectEm
//
//  Created by Emir Vajzović on 2. 6. 2025..
//

struct DependencyBuilder<T> {
    private let builder: () -> T

    init(builder: @escaping () -> T) {
        self.builder = builder
        Container.shared.register(T.self, builder: builder)
    }

    func resolve() -> T {
        builder()
    }
}
