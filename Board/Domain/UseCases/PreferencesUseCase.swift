//
//  PreferencesUseCase.swift
//  Board
//
//  Created by max on 2024-11-09.
//


class PreferencesUseCase {
    private let storage: PreferencesStorage
    
    init(storage: PreferencesStorage) {
        self.storage = storage
    }
    
    func getAppPreferences() -> AppPreferences {
        AppPreferences(
            selectedBoard: storage.getCurrentBoard(),
            theme: storage.getTheme()
        )
    }
    
    func updateBoard(_ board: BoardType) {
        storage.setCurrentBoard(board)
    }
    
    func updateTheme(_ theme: AppPreferences.Theme) {
        storage.setTheme(theme)
    }
}
