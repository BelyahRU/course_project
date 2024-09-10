import Foundation
import SwiftUI

struct NewToDoItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var text: String
    var closureItem: (String) -> Void
    
    
    var body: some View {
            TextField("Новое", text: $text)
                .frame(height: 56)
                .font(.subheadline)
                .foregroundColor(colorScheme == .light ? Resources.LightTheme.Label.blackColor : Resources.DarkTheme.Label.primaryColor)
                .onSubmit {
                    closureItem(text)
                    text = ""
                }
    }
}
