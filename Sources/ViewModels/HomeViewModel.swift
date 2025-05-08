import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var selectedWeek: Int = 1
    @Published var isLoading = false
    @Published var error: Error?
    
    private let nflService = NFLService.shared
    
    func loadGames() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            games = try await nflService.fetchCurrentWeekGames()
        } catch {
            self.error = error
        }
    }
    
    func loadWeekGames(_ week: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            games = try await nflService.fetchWeekGames(week: week)
            selectedWeek = week
        } catch {
            self.error = error
        }
    }
    
    func makePick(gameId: UUID, teamId: UUID) {
        // TODO: Implement pick submission
        // This will be connected to the backend service
    }
} 