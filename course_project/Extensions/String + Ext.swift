import Foundation
extension String {
    // кастомный метод сплит с использованием регулярки
    static func customSplit(text: String, regexStr: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regexStr)
            let nsText = text as NSString
            let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))
            
            var substrings = [String]()
            var previousIndex = 0
            
            for match in matches {
                let range = match.range
                var substring = nsText.substring(with: NSRange(location: previousIndex, length: range.location - previousIndex))
                // Удаляем кавычки в начале и конце подстроки
                substring = substring.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                substrings.append(substring)
                previousIndex = range.location + range.length
            }
            
            if previousIndex < nsText.length {
                var remainingSubstring = nsText.substring(from: previousIndex)
                // Удаляем кавычки в начале и конце оставшейся подстроки
                remainingSubstring = remainingSubstring.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                substrings.append(remainingSubstring)
            }
            
            if !substrings.isEmpty && matches.last?.range.location == nsText.length - 1 {
                substrings.append("")
            }
            
            return substrings
        } catch {
            print("Error creating regex: \(error.localizedDescription)")
            return []
        }
    }

}
