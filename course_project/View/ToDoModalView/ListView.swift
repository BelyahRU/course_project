import Foundation
import SwiftUI

struct ListView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MainViewModel
    @Binding var editingTodoItem: TodoItem?
    @Binding var isShowingModal: Bool
    @Binding var buttonTitle: String
    @State private var newItemText: String = ""
    
    var body: some View {
        List {
            Section {
                ForEach($viewModel.todosArray) { $item in
                    //ячейка
                    TodoItemView(todoItem: $item)
                        .frame(height: 50)
                        .background(colorScheme == .light ? Resources.LightTheme.Back.secondaryColor : Resources.DarkTheme.Back.secondaryColor)
                        .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 0))
                }
                //новое
                NewToDoItemView(text: "") { text in
                    viewModel.addToDo(new: TodoItem(text: text, importance: .ordinary, deadline: nil, isTaskDone: false, creationDate: Date(), modifiedDate: nil))
                }
                    .frame(height: 50)
//                    .background(colorScheme == .light ? Resources.LightTheme.Back.secondaryColor : Resources.DarkTheme.Back.secondaryColor)
                    .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 0))
            //ListHeaderView - Выполнено - 5    Показать
            } header: {
                ListHeaderView(viewModel: viewModel, buttonTitle: $buttonTitle)
                    .padding(.bottom, 15)
                    .padding(.top, -15)
            }
            .listRowBackground(colorScheme == .light ? Resources.LightTheme.Back.secondaryColor : Resources.DarkTheme.Back.secondaryColor)
            .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            .listRowSeparatorTint(colorScheme == .light ? Resources.LightTheme.Support.separatorColor : Resources.DarkTheme.Support.separatorColor)
        }
        .listStyle(PlainListStyle())
        .background(colorScheme == .light ? Resources.LightTheme.Back.primaryColor : Resources.DarkTheme.Back.primaryColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var newItemEditor: some View {
        ZStack(alignment: .leading) {
            if newItemText.isEmpty {
                Text("Новое")
                    .foregroundColor(colorScheme == .light ? Resources.LightTheme.Label.TetiaryColor : Resources.DarkTheme.Label.TetiaryColor)
                    .padding(.leading, 50)
            }
            TextEditor(text: $newItemText)
                .foregroundColor(colorScheme == .light ? Resources.LightTheme.Label.blackColor : Resources.DarkTheme.Label.primaryColor)
                .background(colorScheme == .light ? Resources.LightTheme.Back.primaryColor : Resources.DarkTheme.Back.primaryColor)
                .onTapGesture {
                    if newItemText == "Новое" {
                        newItemText = ""
                    }
                }
                .padding(.leading, 39)
        }
    }
    
    
}
