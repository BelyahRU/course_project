import Foundation
//Класс для обработки Date. Тут мы можем получить date из string и наоборот
class DateHelper {
    
    static var dateFormatterISO8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    static func getStringFromDate(date: Date?,
                                  dateFormatter: DateFormatter = dateFormatterISO8601) -> String? {
        guard let date = date else { return nil }
        return dateFormatter.string(from: date)
    }

    static func getDateFromString(stringDate: String?, dateFormatter: DateFormatter = dateFormatterISO8601) -> Date? {
        guard let stringDate = stringDate else { return nil }
        return dateFormatter.date(from: stringDate)
    }
}
