//
//  AppPreferences.swift
//  Board
//
//  Created by max on 2024-11-09.
//


struct AppPreferences {
    var selectedBoard: BoardType
    var theme: Theme
    
    enum Theme: String, Codable {
        case light
        case dark
        case system
    }
}