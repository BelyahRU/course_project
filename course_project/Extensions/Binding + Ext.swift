import Foundation
import SwiftUI
extension Binding {
    init(_ base: Binding<Value>) {
        self.init(
            get: { base.wrappedValue },
            set: { newValue in base.wrappedValue = newValue }
        )
    }
}
