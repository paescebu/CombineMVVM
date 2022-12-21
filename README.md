# CombineMVVM
Nested ViewModels/ObservableObjects are tedious no more, just conform to ViewModel!

Example:
```swift
import CombineMVVM

struct FirstView: View {
    @StateObject var viewModel = FirstViewModel()
    
    var body: some View {
        //The Text View now also updates the text
        Text(viewModel.nestedViewModel.text)
        SecondView(viewModel: viewModel.nestedViewModel)
    }
}

class FirstViewModel: ViewModel {
    var subscriptions: Set<AnyCancellable> = .init()
    var nestedViewModel = SecondViewModel()
    
    init() {
        pipeViewModelUpdates(of: nestedViewModel)
    }
}

struct SecondView: View {
    @ObservedObject var viewModel: SecondViewModel
    
    var body: some View {
        Text(viewModel.text)
        TextField("Enter Text", text: $viewModel.text)
            .foregroundColor(.gray)
    }
}

class SecondViewModel: ViewModel {
    var subscriptions: Set<AnyCancellable> = .init()
    @Published var text = "Hello"
}
```
