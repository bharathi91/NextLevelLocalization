

import Foundation

public final class BKLocalizable {
    
    public typealias LanguageKey = String
    public typealias Language = Dictionary<String, String>
    public typealias Translations = Dictionary<LanguageKey, Language>
    
    let tableName: String
    let translations: Translations
    
    static let BKBundleName = "BKLocalizable.bundle"
    let manager = FileManager.default
    lazy var bundlePath: URL = {
        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
        let bundlePath = documents.appendingPathComponent(BKLocalizable.BKBundleName, isDirectory: true)
        return bundlePath
    }()
    
    public init(translations: Translations, name: String = "Localizable") {
        tableName = name
        self.translations = translations
    }
    
    func clean() throws {
        // TODO: There can be multiple table names in the same Bundle. So only remove the bundle if there is no more string files.
        var _: Dictionary<String, Int> = [:]
        
        for _ in manager.enumerator(at: bundlePath, includingPropertiesForKeys: nil, options: [.skipsPackageDescendants])! {
        }
        if manager.fileExists(atPath: bundlePath.path) {
            try manager.removeItem(at: bundlePath)
        }
    }
    
    public func writeToBundle() throws -> Bundle {
        
        if manager.fileExists(atPath: bundlePath.path) == false {
            try manager.createDirectory(at: bundlePath, withIntermediateDirectories: true, attributes: [FileAttributeKey.protectionKey : FileProtectionType.complete])
        }
        
        for language in translations {
            let lang = language.key
            let langPath = bundlePath.appendingPathComponent("\(lang).lproj", isDirectory: true)
            if manager.fileExists(atPath: langPath.path) == false {
                try manager.createDirectory(at: langPath, withIntermediateDirectories: true, attributes: [FileAttributeKey.protectionKey : FileProtectionType.complete])
            }
            
            let sentences = language.value
            let res = sentences.reduce("", { $0 + "\"\($1.key)\" = \"\($1.value)\";\n" })
            
            let filePath = langPath.appendingPathComponent("\(tableName).strings")
            let data = res.data(using: .utf32)
            manager.createFile(atPath: filePath.path, contents: data, attributes: [FileAttributeKey.protectionKey : FileProtectionType.complete])
        }
        
        let localBundle = Bundle(url: bundlePath)!
        return localBundle
    }
}
