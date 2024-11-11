import SwiftUI
import SQLite

struct ClimbListView: SwiftUICore.View {
    @StateObject private var viewModel: ClimbListViewModel
    
    init(viewModel: ClimbListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some SwiftUICore.View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Text("Unable to load climbs")
                            .font(.headline)
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Button("Try Again") {
                            viewModel.loadClimbs()
                        }
                    }
                } else if viewModel.climbs.isEmpty {
                    Text("No climbs found")
                        .font(.headline)
                        .foregroundColor(.secondary)
                } else {
                    List(viewModel.climbs) { climb in
                        Text(climb.name)
                    }
                }
            }
            .navigationTitle("Climbs")
        }
        .task {
            viewModel.loadClimbs()
        }
    }
}

// MARK: - Preview Provider
struct ClimbListView_Previews: PreviewProvider {
    static var previews: some SwiftUICore.View {
        // Create a mock repository that returns some sample data
        let mockRepo = MockKilterBoardRepository()
        let viewModel = ClimbListViewModel(repository: mockRepo)
        ClimbListView(viewModel: viewModel)  // Pass viewModel instead of mockRepo
    }
}

// MARK: - Mock Repository for Preview
private class MockKilterBoardRepository: KilterBoardRepository {
    init() {
        // Create an in-memory database for the mock
        do {
            let db = try Connection(.inMemory)
            super.init(db: db)
        } catch {
            fatalError("Failed to create in-memory database: \(error)")
        }
    }
    
    override func getClimbs() async throws -> [ClimbDetails] {
        return [
            ClimbDetails(
                id: "1",
                name: "The Crimp",
                grade: "V4",
                angle: 20,
                rating: 4.5,
                ascentCount: 100,
                dateSet: Date(),
                setter: "John Doe",
                frames: "",
                holdSequence: HoldSequence(
                    startHolds: [],
                    handHolds: [],
                    footHolds: [],
                    topHolds: []
                ),
                metadata: RouteMetadata(
                    dateSet: Date(),
                    ascentCount: 100,
                    averageRating: 4.5,
                    userRating: nil,
                    userAscent: false
                )
            ),
            ClimbDetails(
                id: "2",
                name: "Slopey McSlope",
                grade: "V5",
                angle: 25,
                rating: 4.8,
                ascentCount: 75,
                dateSet: Date(),
                setter: "Jane Smith",
                frames: "",
                holdSequence: HoldSequence(
                    startHolds: [],
                    handHolds: [],
                    footHolds: [],
                    topHolds: []
                ),
                metadata: RouteMetadata(
                    dateSet: Date(),
                    ascentCount: 75,
                    averageRating: 4.8,
                    userRating: nil,
                    userAscent: false
                )
            )
        ]
    }
}
