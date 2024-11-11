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
    
    // Create repository and climb list view model
    private let repository: KilterBoardRepository
    private let climbListViewModel: ClimbListViewModel
    
    init() {
        // Initialize preferences
        preferencesUseCase = PreferencesUseCase(storage: preferencesStorage)
        preferencesViewModel = PreferencesViewModel(preferencesUseCase: preferencesUseCase)
        
        // Initialize repository and view model
        do {
            repository = try KilterBoardRepository.create()
            climbListViewModel = ClimbListViewModel(repository: repository)
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ClimbListView(viewModel: climbListViewModel)
                    .tabItem {
                        Label("Climbs", systemImage: "list.bullet")
                    }
                
                SettingsView(preferencesVM: preferencesViewModel)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
