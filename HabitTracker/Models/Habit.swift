import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var CompletionHitory: [String:Bool] = [:]
    
    //Date formatting funciton
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
}
