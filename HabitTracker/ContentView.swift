import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var store = HabitStore()
    

    
    var body: some View{
        NavigationView {
            HStack{
                ForEach(store.habits, id: \.id){ habit in
                    VStack(alignment: .leading){
                        Text(habit.name)
                            .font(.headline)
                        
                        HabitHeatmapView(habit: habit)
                        
                        let today = Habit.dateToString(Date())
                        let isDone = store.isHabitDone(habit, on: Date())
                        
                        Button("Done"){
                            store.markHabitDone(habit.id)
                        }.padding(.top, 4)
                            .disabled(isDone)
                            .opacity(0.3)
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
