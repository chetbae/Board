//
//  ClimbListViewModel.swift
//  Board
//
//  Created by max on 2024-11-10.
//

import SwiftUI

@MainActor
class ClimbListViewModel: ObservableObject {
    @Published private(set) var climbs: [ClimbDetails] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let repository: KilterBoardRepository
    
    init(repository: KilterBoardRepository) {
        self.repository = repository
    }
    
    func loadClimbs() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                climbs = try await repository.getClimbs()
                error = nil
            } catch {
                self.error = error
                climbs = []
            }
            isLoading = false
        }
    }
}
