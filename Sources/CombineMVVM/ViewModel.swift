//
//  ViewModel.swift
//  
//
//  Created by Pascal Burlet on 15.11.22.
//

import Combine

@MainActor
public protocol ViewModel: ObservableObject where ObservableObjectPublisher == Self.ObjectWillChangePublisher {
    var subscriptions: Set<AnyCancellable> { get set }
    
    func pipeUpdates<Observable: ObservableObject>(of observable: Observable) where ObservableObjectPublisher == Observable.ObjectWillChangePublisher
    func pipeViewModelUpdates(of viewModel: some ViewModel)
}

public extension ViewModel where ObservableObjectPublisher == Self.ObjectWillChangePublisher {
    func pipeUpdates<Observable: ObservableObject>(of observable: Observable) where ObservableObjectPublisher == Observable.ObjectWillChangePublisher {
        observable.objectWillChange.sink { _ in
            self.objectWillChange.send()
        } receiveValue: { _ in }
        .store(in: &subscriptions)
    }
    
    func pipeViewModelUpdates(of viewModel: some ViewModel) {
        pipeUpdates(of: viewModel)
    }
}
