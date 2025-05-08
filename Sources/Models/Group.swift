import Foundation

struct Group: Identifiable, Codable {
    let id: UUID
    let name: String
    let creator: User
    let members: [User]
    let createdAt: Date
    let season: Int
    var weeklyResults: [WeeklyResult]
    
    struct WeeklyResult: Codable {
        let week: Int
        let memberResults: [MemberResult]
    }
    
    struct MemberResult: Codable {
        let userId: UUID
        let correctPicks: Int
        let incorrectPicks: Int
        let pushes: Int
        let totalPoints: Int
    }
} 