import Foundation

actor NFLService {
    static let shared = NFLService()
    private let baseURL = "https://api.example.com/nfl" // Replace with actual NFL API endpoint
    
    func fetchCurrentWeekGames() async throws -> [Game] {
        // TODO: Implement actual API call
        // For now, return mock data
        return mockGames
    }
    
    func fetchWeekGames(week: Int) async throws -> [Game] {
        // TODO: Implement actual API call
        return mockGames
    }
    
    // Mock data for development
    private var mockGames: [Game] {
        [
            Game(
                id: UUID(),
                homeTeam: Team(id: UUID(), name: "Kansas City Chiefs", abbreviation: "KC", logoURL: nil),
                awayTeam: Team(id: UUID(), name: "San Francisco 49ers", abbreviation: "SF", logoURL: nil),
                spread: -2.5,
                week: 1,
                date: Date(),
                status: .upcoming,
                homeScore: nil,
                awayScore: nil
            ),
            Game(
                id: UUID(),
                homeTeam: Team(id: UUID(), name: "Buffalo Bills", abbreviation: "BUF", logoURL: nil),
                awayTeam: Team(id: UUID(), name: "Miami Dolphins", abbreviation: "MIA", logoURL: nil),
                spread: -3.0,
                week: 1,
                date: Date().addingTimeInterval(86400),
                status: .upcoming,
                homeScore: nil,
                awayScore: nil
            )
        ]
    }
} 