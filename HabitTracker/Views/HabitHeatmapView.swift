import SwiftUI

struct HabitHeatmapView: View {
    var habit: Habit
    
    var body: some View {
        let columns = Array(repeating: GridItem(.fixed(12), spacing: 4), count: 12)
        let dates = Habit.datesBackwards(from: Date(), count: 120)
        
        LazyVGrid(columns: columns, spacing: 4){
            ForEach(dates, id: \.self){ date in
                let key = Habit.dateToString(date)
                let isCompleted = habit.completionHistory[key] ?? false
                Rectangle()
                    .fill(isCompleted ? Color.green : Color.gray.opacity(0.2))
                    .frame(width: 12, height: 12)
            }
        }
    }
}
//it takes habit as input and returns grid of heatmap for this habit with: completed, not-completed, streaks gradation
