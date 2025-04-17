import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completionHistory: [String:Bool] = [:]
    
    //Date formatting funciton
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    static func datesBackwards(from today: Date, count: Int) -> [Date] {
        return (0..<count).compactMap {
            Calendar.current.date(byAdding: .day, value: -$0, to: today)
        }.reversed()
    }
    
    func isCompleted(on date: Date)-> Bool {
        let key = Self.dateToString(date)
        return completionHistory[key] ?? false
    }
    
    func currentSteak(asOf referenceDate: Date = Date()) -> Int {
        var streak = 0
        let dates = Self.datesBackwards(from: referenceDate, count: 120)
        
        for date in dates.reversed(){
            if isCompleted(on: date ){
                streak += 1
            }
            else{
                break
            }
        }
        
        return streak
    }
    
    func longestStreak() -> Int {
        let dates = Self.datesBackwards(from: Date(), count: 120)
        var maxStreak = 0
        var current = 0

        for date in dates {
            if isCompleted(on: date) {
                current += 1
                maxStreak = max(maxStreak, current)
            } else {
                current = 0
            }
        }

        return maxStreak
    }
    
    //Map each date to the streak value at that day (necessary for implementation of the color gradation)
    func streakMap() -> [String: Int] {
        let dates = Self.datesBackwards(from: Date(), count: 120)
        var streak = 0
        var map: [String: Int] = [:]

        for date in dates {
            let key = Self.dateToString(date)
            if isCompleted(on: date) {
                streak += 1
            } else {
                streak = 0
            }
            map[key] = streak
        }

        return map
    }
}
