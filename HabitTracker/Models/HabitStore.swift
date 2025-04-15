import Foundation

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = [] //?
    
    private let storageKey = "SavedHabits"
    
    init(){
        load()
    }
    
    func addHabit(name: String) -> Void{
        let newHabit = Habit(name: name)
        habits.append(newHabit)
        save()
    }
    
    func deleteHabit(at indexSet: IndexSet) -> Void{
        habits.remove(atOffsets: indexSet)
        save()
    }
    
    func markHabitDone(_ habitID: UUID) {
        let today = Habit.dateToString(Date())
        
        if let index = habits.firstIndex(where: { $0.id == habitID }) {
            habits[index].completionHitory[today] = true
            save()
        }
    }
    
    func isHabitDone(_ habit: Habit, on date: Date) -> Bool {
        let key = Habit.dateToString(date)
        return habit.completionHitory[key] ?? false
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private func load(){
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([Habit].self, from: data) else {
            return
        }

        habits = decoded
    }
}
