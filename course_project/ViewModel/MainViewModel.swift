
import Foundation

class MainViewModel: ObservableObject {
    @Published private(set) var fileCacheModel = FileCache()
    
    @Published var contentFilter: ContentFilter = .allItems {
        didSet {
            filterTodos()
        }
    }
    @Published var countItemsAreDone = 0
    
    @Published var todosArray: [TodoItem] = [] {
        didSet {
            countingAreDone()
        }
    }

    init() {
        filterTodos()
        countingAreDone()
    }
    
    private func countingAreDone() {
        countItemsAreDone = fileCacheModel.toDos.filter({$0.isTaskDone == true}).count
    }
    
    private func filterTodos() {
        if contentFilter == .allItems {
            todosArray = fileCacheModel.toDos
        } else {
            todosArray = fileCacheModel.toDos.filter { !$0.isTaskDone }
        }
    }
    
    private func updateData() {
        filterTodos()
    }
    
    public func addToDo(new item: TodoItem?) {
        guard let item = item else { return }
        fileCacheModel.add(new: item)
        updateData()
    }
    
    public func removeItem(item: TodoItem?) {
        guard let item = item else { return }
        fileCacheModel.removeTask(by: item.id)
        updateData()
        print("успешно удалено")
    }
    
    public func updateTodoItem(_ item: TodoItem) {
        // Обновление элемента в fileCacheModel
        fileCacheModel.updateTask(item)
        
        // Обновление элемента в todosArray
        if let index = todosArray.firstIndex(where: { $0.id == item.id }) {
            todosArray[index] = item
        }
        
        // Перефильтровка данных
        updateData()
    }
}

