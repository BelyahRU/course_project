import Foundation

final class FileCache {
    private(set) var toDos: [TodoItem] = [
        TodoItem(
            text: "Купить продукты",
            importance: .important,
            deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
            isTaskDone: false,
            creationDate: Date(),
            modifiedDate: nil
        ),
        TodoItem(
            text: "Завершить проект",
            importance: .ordinary,
            deadline: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
            isTaskDone: false,
            creationDate: Date(),
            modifiedDate: nil
        ),
        TodoItem(
            text: "Позвонить маме",
            importance: .important,
            deadline: nil,
            isTaskDone: false,
            creationDate: Date(),
            modifiedDate: nil
        ),
        TodoItem(
            text: "Забрать посылку",
            importance: .unimportant,
            deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
            isTaskDone: true,
            creationDate: Date(),
            modifiedDate: Date()
        ),
        TodoItem(
            text: "Прочитать книгу",
            importance: .ordinary,
            deadline: nil,
            isTaskDone: false,
            creationDate: Date(),
            modifiedDate: nil
        ),
        TodoItem(
            text: "Забрать посылку",
            importance: .unimportant,
            deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
            isTaskDone: true,
            creationDate: Date(),
            modifiedDate: Date()
        ),
        TodoItem(
            text: "Прочитать книгу",
            importance: .ordinary,
            deadline: nil,
            isTaskDone: false,
            creationDate: Date(),
            modifiedDate: nil
        ),
        TodoItem(
            text: "Забрать посылку",
            importance: .unimportant,
            deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
            isTaskDone: true,
            creationDate: Date(),
            modifiedDate: Date()
        ),
        TodoItem(
            text: "Прочитать книгу",
            importance: .ordinary,
            deadline: nil,
            isTaskDone: false,
            creationDate: Date(),
            modifiedDate: nil
        )
    ]
    
    func add(new task: TodoItem) {
        //проверка на дублирование
        if toDos.first(where: { $0.id == task.id }) != nil {
            print("FileCache Error. Task added before")
        } else{
            toDos.append(task)
        }
    }
    
    func removeTask(by id: String) {
        toDos.removeAll(where: { $0.id == id })
    }
    
    func updateTask(_ item: TodoItem) {
        if let index = toDos.firstIndex(where: { $0.id == item.id }) {
            toDos[index] = item
        }
    }
    
    func saveInFile(fileName: String) {
        let jsonDataArray = toDos.map({ $0.json })
        
        //getUrl(from: ) - extension for FileManager
        guard let url = FileManager.default.getUrl(from: fileName) else {
            print("Error getting url")
            return
        }
        //isFileExist(fileName: ) - extension for FileManager
        if FileManager.default.isFileExist(fileName: fileName) {
             print("Error, file existed before")
             return
        }
        let isValidJson = JSONSerialization.isValidJSONObject(jsonDataArray)
        if !isValidJson {
            print("Error, JSON is not valid")
            return
        }
        
        let data: Data
        do {
            data = try JSONSerialization.data(withJSONObject: jsonDataArray, options: [])
        } catch {
            print("Error creating JSON data: \(error.localizedDescription)")
            return
        }
        
        do {
            try data.write(to: url)
            print("File saved: \(url.description)")
        } catch {
            print("Error writing file: \(error.localizedDescription)")
        }
        
    }
    
    //Может быть нужно вернуть nil?
    func uploadFromFile(fileName: String) -> [TodoItem] {
        //getUrl(from: ) - extension for FileManager
        guard let url = FileManager.default.getUrl(from: fileName) else {
            return []
        }
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            print("Error uploading data from file: \(error.localizedDescription)")
            return []
        }
        do {
            let todosJson = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            return todosJson!.compactMap({ TodoItem.parse(json: $0) })
        } catch {
            print("Error convert data to JSON: \(error.localizedDescription)")
            return []
        }
    }
}
