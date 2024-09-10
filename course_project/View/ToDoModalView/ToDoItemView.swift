import Foundation
import SwiftUI
struct TodoItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var todoItem: TodoItem
    @State private var isShowingModal = false
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            checkboxButton
            if let _ = todoItem.deadline {
                VStack(alignment: .leading) {
                    titleText
                    deadlineText
                        .padding(.leading, 5)
                }
            } else {
                titleText
            }
            Spacer()
            arrowChangeButton
        }
        .frame(height: 50)
    }
    
    var deadlineText: some View {
        HStack(spacing: 4) {
            Image(colorScheme == .light ?
                  Resources.LightTheme.Images.lightCalendar
                  : Resources.LightTheme.Images.darkCalendar)
            Text("\(todoItem.deadline!.getDayMonthFormatted())")
                .foregroundColor(colorScheme == .light ?
                                 Resources.LightTheme.Label.TetiaryColor
                                 : Resources.DarkTheme.Label.TetiaryColor)
                .font(.system(size: 15))
        }
    }
    
    var checkboxButton: some View {
        Button(action: {
            todoItem.isTaskDone.toggle()
            viewModel.updateTodoItem(todoItem)
        }) {
            Image(systemName: imageName(forState: todoItem.isTaskDone))
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(color(forState: todoItem.isTaskDone, importance: todoItem.importance))
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
    var titleText: some View {
        HStack(spacing: 0) {
            if todoItem.importance == .important {
                Image(Resources.LightTheme.Images.exclamationMark)
            }
            Text(todoItem.text)
                .foregroundColor(colorScheme == .light
                                 ? (todoItem.isTaskDone ? Resources.LightTheme.Label.TetiaryColor
                                    : Resources.LightTheme.Label.blackColor)
                                 : (todoItem.isTaskDone ? Resources.DarkTheme.Label.TetiaryColor
                                   : Resources.DarkTheme.Label.primaryColor))
                .strikethrough(todoItem.isTaskDone)
                .padding(.leading, 8)
        }
    }
    
    var arrowChangeButton: some View {
        Button(action: {
            self.isShowingModal = true
        }) {
            Image(Resources.LightTheme.Buttons.arrowButton)
                .contentShape(Rectangle())
        }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 8)
            .sheet(isPresented: $isShowingModal) {
                ToDoModalView(todoItem: Binding($todoItem))
            }
    }

    func imageName(forState isSelected: Bool) -> String {
        isSelected ? "checkmark.circle.fill" : "circle"
    }

    func color(forState isSelected: Bool, importance: Importance) -> Color {
        switch importance {
        case .unimportant:
            return isSelected ? Resources.LightTheme.greenColor : Resources.LightTheme.grayColor
        case .ordinary:
            return isSelected ? Resources.LightTheme.greenColor : Resources.LightTheme.grayColor
        case .important:
            return isSelected ? Resources.LightTheme.greenColor : Resources.LightTheme.redColor
        }
    }
}
