Simple and minimalistic habit tracker for iOS

Core features are:
- Tracking habits using git-like view of the story of the habit for 120 days period, that is stored locally on the device.
- Adding and deleting habits 

The structure of the app currently follows this chart:
HabitTracker/
├── Models/
│   └── Habit.swift               ← name, id, history, streak logic
├── ViewModels/
│   └── HabitStore.swift          ← app-wide state, persistence
├── Views/
│   ├── ContentView.swift         ← main UI, list of habits
│   ├── HabitRowView.swift        ← single habit + button + streaks
│   └── HabitHeatmapView.swift    ← heatmap view per habit
├── Widgets/                      ← (later)
│   └── HabitWidget.swift
├── Extensions/
│   └── Date+Utils.swift          ← date formatting, helpers
├── Resources/
│   └── Assets.xcassets
├── HabitHeatApp.swift


Basic functionality of the app (ver 1.0)
 N Add habit                          Core        User creates a new habit with a name
 N Delete habit                       Optional    Remove habit from the list (optional for MVP)
 N Mark habit as done                 Core        One-tap button marks today as completed for that habit
 N Heatmap calendar (120 days)        Core        Grid of colored squares showing past 120 days of completion
 N Color gradation based on streak    Core        Each square’s color intensity reflects streak progress
 N Current streak tracking            Core        Show how many consecutive days the habit was done
 N Longest streak tracking            Optional    Record of the longest streak ever achieved
 N Persistent data                    Core        Store and load all data using UserDefaults
 
 Additional funcitonality (ver 1.1)
 N Widget                           Phase 2    WidgetKit extension to mark habit as done from home screen
 N Habit customization              Future     Icons / colors per habit (UI polish feature)
