//
//  BoardApp.swift
//  Board
//
//  Created by max on 2024-10-26.
//

import SwiftUI

@main
struct BoardApp: App {
    // Create dependencies
    private let preferencesStorage = UserDefaultsPreferencesStorage()
    private let preferencesUseCase: PreferencesUseCase
    private let preferencesViewModel: PreferencesViewModel
    
    init() {
        // Initialize use case and view model
        preferencesUseCase = PreferencesUseCase(storage: preferencesStorage)
        preferencesViewModel = PreferencesViewModel(preferencesUseCase: preferencesUseCase)
    }
    
    var body: some Scene {
        WindowGroup {
            SettingsView(preferencesVM: preferencesViewModel)
        }
    }
}

