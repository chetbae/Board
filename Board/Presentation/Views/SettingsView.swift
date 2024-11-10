//
//  SettingsView.swift
//  Board
//
//  Created by max on 2024-11-09.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var preferencesVM: PreferencesViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init(preferencesVM: PreferencesViewModel) {
        _preferencesVM = StateObject(wrappedValue: preferencesVM)
    }
    
    var body: some View {
        NavigationView {
            List {
                
                // Custom title
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.leading, 8)  // Add some leading padding
                    .listRowInsets(EdgeInsets()) // Remove default row insets
                    .listRowBackground(Color.clear) // Make row background clear
            
                Section("Board Selection") {
                    Picker("Current Board", selection: Binding(
                        get: { preferencesVM.preferences.selectedBoard },
                        set: { preferencesVM.switchBoard(to: $0) }
                    )) {
                        Text("Kilter")
                            .tag(BoardType.kilter)
                    }
                }
                
                Section("Theme") {
                    ForEach(AppPreferences.Theme.allCases, id: \.self) { theme in
                        Button(action: { preferencesVM.updateTheme(theme) }) {
                            HStack {
                                HStack {
                                    themeIcon(for: theme)
                                        .foregroundColor(.accentColor)
                                    Text(theme.displayName)
                                }
                                
                                Spacer()
                                
                                if preferencesVM.preferences.theme == theme {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .listStyle(.insetGrouped)
        }
        .preferredColorScheme(preferredColorScheme)
    }
    
    private var preferredColorScheme: ColorScheme? {
        switch preferencesVM.preferences.theme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    private func themeIcon(for theme: AppPreferences.Theme) -> Image {
        switch theme {
        case .light:
            return Image(systemName: "sun.max.fill")
        case .dark:
            return Image(systemName: "moon.fill")
        case .system:
            return Image(systemName: "gear")
        }
    }
}

// MARK: - Theme Display Name
extension AppPreferences.Theme {
    static var allCases: [AppPreferences.Theme] {
        [.light, .dark, .system]
    }
    
    var displayName: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .system:
            return "System"
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
