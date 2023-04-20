# CombineMVVM
Nested ViewModels/ObservableObjects are tedious no more, just conform to ViewModel and use the `pipeUpdates(:)` method to link with other ViewModels or ObservableObjects!

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

# Donations

You really don't have to pay anything to use this package. But if you feel generous today and would like to donate because this package helped you so much, here's a PayPal donation link: https://www.paypal.com/donate/?hosted_button_id=JYL8DBGA2X4YQ

or just buy me a hot chocolate: https://www.buymeacoffee.com/paescebu