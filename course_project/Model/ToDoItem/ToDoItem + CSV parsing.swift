import Foundation
extension TodoItem {
    
    static let regex = #"(?!\B"[^"]*),(?![^"]*"\B)"# // регулярное выражение
    
    var csv: String {
        var columns: [String] = []
        columns.append(id)
        columns.append("\"\(text)\"")
        columns.append(importance.rawValue)
        columns.append("\(isTaskDone)")
        columns.append(DateHelper.getStringFromDate(date: creationDate)!)
        columns.append(DateHelper.getStringFromDate(date: modifiedDate) ?? "")
        columns.append(DateHelper.getStringFromDate(date: deadline) ?? "")
        return columns.joined(separator: ",")
    }
    
    static func parse(csv: String) -> TodoItem? {
        let columns = String.customSplit(text: csv, regexStr: regex)//используем кастомный сплит с регулярным выражением, т.к. csv файл разделяется на запятые, но в text могут быть тоже запятые, поэтому text у меня обраблен кавычками и благодаря регулярному выражению и этой функции запятые, которые находяся в кавычках не будут "заспличены"
        if columns.count == ToDoDictionaryKeys.allCases.count {
            let id = columns[0]
            let text = columns[1]
            let importanceStr = columns[2]
            let isTaskDone = columns[3].lowercased() == "true"
            guard let creationDate = DateHelper.getDateFromString(stringDate: columns[4]) else {
                return nil
            }
            let modifiedDate = columns[5].isEmpty ? nil :
            DateHelper.getDateFromString(stringDate: columns[5])
            let deadline = columns[6].isEmpty ? nil : DateHelper.getDateFromString(stringDate: columns[6])
            let importance = Importance(rawValue: importanceStr) ?? Importance.ordinary
            
            return TodoItem(id: id,
                            text: text,
                            importance: importance,
                            deadline: deadline,
                            isTaskDone: isTaskDone,
                            creationDate: creationDate,
                            modifiedDate: modifiedDate)
        } else {
            print("CSV parse error")
            return nil
        }
    }
    
}
