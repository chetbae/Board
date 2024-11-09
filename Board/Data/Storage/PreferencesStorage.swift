//
//  PreferencesStorage.swift
//  Board
//
//  Created by max on 2024-11-09.
//

import Foundation


protocol PreferencesStorage {
    func getCurrentBoard() -> BoardType
    func setCurrentBoard(_ board: BoardType)
    func getTheme() -> AppPreferences.Theme
    func setTheme(_ theme: AppPreferences.Theme)
}

class UserDefaultsPreferencesStorage: PreferencesStorage {
    private enum Keys {
        static let currentBoard = "currentBoard"
        static let theme = "theme"
    }
    
    private let defaults = UserDefaults.standard
    
    func getCurrentBoard() -> BoardType {
        guard let boardString = defaults.string(forKey: Keys.currentBoard),
              let board = BoardType(rawValue: boardString) else {
            return .kilter // Default to Kilter board
        }
        return board
    }
    
    func setCurrentBoard(_ board: BoardType) {
        defaults.set(board.rawValue, forKey: Keys.currentBoard)
    }
    
    func getTheme() -> AppPreferences.Theme {
        guard let themeString = defaults.string(forKey: Keys.theme),
              let theme = AppPreferences.Theme(rawValue: themeString) else {
            return .system // Default to system theme
        }
        return theme
    }
    
    func setTheme(_ theme: AppPreferences.Theme) {
        defaults.set(theme.rawValue, forKey: Keys.theme)
    }
}
