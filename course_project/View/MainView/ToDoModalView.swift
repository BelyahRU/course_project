import SwiftUI

struct ToDoModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var todoItem: TodoItem?
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var text: String = "Что надо сделать?"
    @State private var importance: Importance = .unimportant
    @State private var deadline: Date? = nil
    @State private var isTaskDone: Bool = false
    @State private var creationDate: Date = Date()
    @State private var modifiedDate: Date? = nil

    @State private var selectedImportanceIndex = 0
    @State private var switchIsOn: Bool = false
    @State private var datePickerIsOn: Bool = false

    var body: some View {
        mainNavigationStack
    }

    var mainNavigationStack: some View {
        NavigationStack {
            MainListView(
                text: $text,
                importance: $importance,
                deadline: $deadline,
                selectedImportanceIndex: $selectedImportanceIndex,
                switchIsOn: $switchIsOn,
                datePickerIsOn: $datePickerIsOn,
                todoItem: $todoItem
            )
            .padding(.top, -20)
            .navigationTitle("Дело")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            })
            .background(Resources.LightTheme.Back.primaryColor)
            .onAppear {
                loadTodoItem()
            }
        }
        .frame(minHeight: 112.5, maxHeight: .infinity, alignment: .top)
        .background(Resources.LightTheme.Back.primaryColor)
    }

    var saveButton: some View {
        Button {
            saveTodoItem()
        } label: {
            Text("Сохранить")
                .font(.system(size: 17))
                .fontWeight(.bold)
        }
    }

    var cancelButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Отменить")
                .font(.system(size: 17))
        }
    }

    private func saveTodoItem() {
        switch selectedImportanceIndex {
        case 0:
            importance = .unimportant
        case 1:
            importance = .ordinary
        case 2:
            importance = .important
        default:
            importance = .ordinary
        }

        let updatedTodoItem = TodoItem(
            id: todoItem?.id ?? UUID().uuidString,
            text: text,
            importance: importance,
            deadline: deadline,
            isTaskDone: isTaskDone,
            creationDate: creationDate,
            modifiedDate: Date()
        )

        if let _ = todoItem {
            viewModel.updateTodoItem(updatedTodoItem)
        } else {
            viewModel.addToDo(new: updatedTodoItem)
        }

        self.presentationMode.wrappedValue.dismiss()
    }

    private func loadTodoItem() {
        importance = todoItem?.importance ?? .ordinary
        switch importance {
        case .unimportant:
            selectedImportanceIndex = 0
        case .ordinary:
            selectedImportanceIndex = 1
        case .important:
            selectedImportanceIndex = 2
        }
        text = todoItem?.text ?? "Что надо сделать?"
        deadline = todoItem?.deadline ?? nil
        if deadline != nil {
            switchIsOn = true
        }
    }
}

struct AddToDoModalView_Previews: PreviewProvider {
    @State static var examleToDoItem: TodoItem? = TodoItem(text: "sdfgsdfg", importance: .important, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: nil)
    static var previews: some View {
        ToDoModalView(todoItem: $examleToDoItem)
    }
}
