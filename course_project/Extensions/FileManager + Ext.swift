import Foundation
extension FileManager {
    
    public func getUrl(from fileName: String) -> URL? {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentDirectory = urls.first else {
            return nil
        }
        let url = documentDirectory.appendingPathComponent(fileName)
        
        return url
    }
    
    public func isFileExist(fileName: String) -> Bool {
        let url = getUrl(from: fileName)
        if url == nil {
            return false
        } else {
            return FileManager.default.fileExists(atPath: url!.path)
        }
        
    }
}
