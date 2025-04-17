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
        guard let index = habits.firstIndex(where: { $0.id == habitID }) else { return }

        let today = Habit.dateToString(Date())
        habits[index].completionHistory[today] = true

        save()
    }
    
    func isHabitDone(_ habit: Habit, on date: Date) -> Bool {
        let key = Habit.dateToString(date)
        return habit.completionHistory[key] ?? false
    }
    
    func addMockHabit(name: String) -> Void {
        var newHabit = Habit(name: name)
        let dates = Habit.datesBackwards(from: Date(), count: 120)
        
        for date in dates{
            if Bool.random(){
                let key = Habit.dateToString(date)
                newHabit.completionHistory[key] = true
            }
        }
        
        habits.append(newHabit)
        save()
        
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
