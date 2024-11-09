//
//  PreferencesViewModel.swift
//  Board
//
//  Created by max on 2024-11-09.
//


import SwiftUI

@MainActor
class PreferencesViewModel: ObservableObject {  // Now conforms to ObservableObject
    @Published private(set) var preferences: AppPreferences
    private let preferencesUseCase: PreferencesUseCase
    
    init(preferencesUseCase: PreferencesUseCase) {
        self.preferencesUseCase = preferencesUseCase
        self.preferences = preferencesUseCase.getAppPreferences()
    }
    
    func switchBoard(to board: BoardType) {
        preferencesUseCase.updateBoard(board)
        preferences = preferencesUseCase.getAppPreferences()
    }
    
    func updateTheme(_ theme: AppPreferences.Theme) {
        preferencesUseCase.updateTheme(theme)
        preferences = preferencesUseCase.getAppPreferences()
    }
}
