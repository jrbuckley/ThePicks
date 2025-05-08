import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let username: String
    let email: String
    var profileImageURL: URL?
    var groups: [UUID] // Group IDs
    var picks: [Pick]
    
    struct Pick: Codable {
        let gameId: UUID
        let week: Int
        let selectedTeamId: UUID
        let timestamp: Date
        var result: PickResult?
        
        enum PickResult: String, Codable {
            case correct
            case incorrect
            case push
            case pending
        }
    }
} 