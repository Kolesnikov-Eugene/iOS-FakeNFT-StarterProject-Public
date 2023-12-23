import Foundation

@propertyWrapper
final class Observable<Value> {
<<<<<<< HEAD
    private var observers: [(Value) -> Void] = []

    var wrappedValue: Value {
        didSet {
            for observer in observers {
                observer(wrappedValue)
            }
=======
    private var onChange: ((Value) -> Void)?

    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
>>>>>>> 05985f48a6956abe56e5a88d9e95632a2b474f24
        }
    }

    var projectedValue: Observable<Value> {
        return self
    }

    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

<<<<<<< HEAD
    func observe(_ observer: @escaping (Value) -> Void) {
        observers.append(observer)
        observer(wrappedValue)
=======
    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
>>>>>>> 05985f48a6956abe56e5a88d9e95632a2b474f24
    }
}
