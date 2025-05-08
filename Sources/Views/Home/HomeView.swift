import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedWeek = 1
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                weekPicker
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                } else {
                    gameList
                }
            }
            .navigationTitle("NFL Picks")
            .task {
                await viewModel.loadGames()
            }
        }
    }
    
    private var weekPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(1...18, id: \.self) { week in
                    Button {
                        selectedWeek = week
                        Task {
                            await viewModel.loadWeekGames(week)
                        }
                    } label: {
                        Text("Week \(week)")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedWeek == week ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedWeek == week ? .white : .primary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
        }
    }
    
    private var gameList: some View {
        List(viewModel.games) { game in
            GameRow(game: game) { teamId in
                viewModel.makePick(gameId: game.id, teamId: teamId)
            }
        }
        .listStyle(.plain)
    }
}

struct GameRow: View {
    let game: Game
    let onPick: (UUID) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                TeamView(team: game.awayTeam)
                Spacer()
                Text("vs")
                    .foregroundColor(.secondary)
                Spacer()
                TeamView(team: game.homeTeam)
            }
            
            HStack {
                Text("Spread: \(game.spread > 0 ? "+" : "")\(String(format: "%.1f", game.spread))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button {
                        onPick(game.awayTeam.id)
                    } label: {
                        Text(game.awayTeam.abbreviation)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Capsule())
                    }
                    
                    Button {
                        onPick(game.homeTeam.id)
                    } label: {
                        Text(game.homeTeam.abbreviation)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct TeamView: View {
    let team: Team
    
    var body: some View {
        VStack {
            if let url = team.logoURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 40, height: 40)
            }
            
            Text(team.abbreviation)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    HomeView()
} 