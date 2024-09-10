
import Foundation
import SwiftUI

struct ListHeaderView: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var buttonTitle: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            completedText
            Spacer()
            showButton
        }
        .background(colorScheme == .light ? Resources.LightTheme.Back.primaryColor : Resources.DarkTheme.Back.primaryColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 18)
    }
    
    var completedText: some View {
        Text("Выполнено - \(viewModel.countItemsAreDone)")
            .foregroundColor(colorScheme == .light ? Resources.LightTheme.Label.TetiaryColor : Resources.DarkTheme.Label.TetiaryColor)
            .font(.system(size: 15))
    }
    
    var showButton: some View {
        Button(buttonTitle) {
            toggleButtonTitle()
            if viewModel.contentFilter == ContentFilter.allItems {
                viewModel.contentFilter = .onlyNotCompletedItems
            } else {
                viewModel.contentFilter = ContentFilter.allItems
            }
        }
        .foregroundColor(Resources.LightTheme.blueColor)
        .font(.system(size: 15))
        .bold()
    }
    
    private func toggleButtonTitle() {
        buttonTitle = (buttonTitle == "Показать") ? "Скрыть" : "Показать"
    }
}
