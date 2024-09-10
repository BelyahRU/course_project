import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = MainViewModel()
    @State private var editingTodoItem: TodoItem? = nil
    @State private var isShowingModal = false
    @State private var buttonTitle = "Скрыть"
    
    var body: some View {
        ZStack {
            NavigationSplitView {
                
                ListView(viewModel: viewModel, editingTodoItem: $editingTodoItem, isShowingModal: $isShowingModal, buttonTitle: $buttonTitle)
                    .navigationTitle("Мои дела")
                    .background(colorScheme == .light
                        ? Resources.LightTheme.Back.primaryColor
                        :   Resources.DarkTheme.Back.primaryColor
                    )
            
            } detail: {
                
            }
            .background(colorScheme == .light
                ? Resources.LightTheme.Back.primaryColor
                :   Resources.DarkTheme.Back.primaryColor
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                addButton
                    .padding(.bottom, 54)
            }
            
        }
        .environmentObject(viewModel)
        .background(colorScheme == .light
            ? Resources.LightTheme.Back.primaryColor
            :   Resources.DarkTheme.Back.primaryColor
        )
    }
    
    
    var addButton: some View {
        Button {
            self.editingTodoItem = nil
            self.isShowingModal = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
        }
        .padding(.bottom, 15)
        .sheet(isPresented: $isShowingModal, onDismiss: {
            if let newItem = editingTodoItem {
                viewModel.addToDo(new: newItem)
            }
        }) {
            ToDoModalView(todoItem: $editingTodoItem)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
