import Foundation

struct Game: Identifiable, Codable {
    let id: UUID
    let homeTeam: Team
    let awayTeam: Team
    let spread: Double
    let week: Int
    let date: Date
    let status: GameStatus
    let homeScore: Int?
    let awayScore: Int?
    
    enum GameStatus: String, Codable {
        case upcoming
        case inProgress
        case final
    }
}

struct Team: Identifiable, Codable {
    let id: UUID
    let name: String
    let abbreviation: String
    let logoURL: URL?
} 