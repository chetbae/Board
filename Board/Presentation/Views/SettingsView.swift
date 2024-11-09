//
//  SettingsView.swift
//  Board
//
//  Created by max on 2024-11-09.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var preferencesVM: PreferencesViewModel
    
    init(preferencesVM: PreferencesViewModel) {
        _preferencesVM = StateObject(wrappedValue: preferencesVM)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Board Selection") {
                    Picker("Current Board", selection: Binding(
                        get: { preferencesVM.preferences.selectedBoard },
                        set: { (newValue: BoardType) in
                            preferencesVM.switchBoard(to: newValue)
                        }
                    )) {
                        Text("Kilter").tag(BoardType.kilter)
                        Text("Moon").tag(BoardType.moon)
                        Text("Tension").tag(BoardType.tension)
                    }
                }
                
                Section("Theme") {
                    Picker("App Theme", selection: Binding(
                        get: { preferencesVM.preferences.theme },
                        set: { (newValue: AppPreferences.Theme) in
                            preferencesVM.updateTheme(newValue)
                        }
                    )) {
                        Text("Light").tag(AppPreferences.Theme.light)
                        Text("Dark").tag(AppPreferences.Theme.dark)
                        Text("System").tag(AppPreferences.Theme.system)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.insetGrouped)
        }
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with mock dependencies
        SettingsView(preferencesVM: PreferencesViewModel(
            preferencesUseCase: PreferencesUseCase(
                storage: MockPreferencesStorage()
            )
        ))
    }
}

// MARK: - Mock Storage for Preview
private class MockPreferencesStorage: PreferencesStorage {
    func getCurrentBoard() -> BoardType {
        return .kilter
    }
    
    func setCurrentBoard(_ board: BoardType) {
        // No-op for preview
    }
    
    func getTheme() -> AppPreferences.Theme {
        return .system
    }
    
    func setTheme(_ theme: AppPreferences.Theme) {
        // No-op for preview
    }
}
