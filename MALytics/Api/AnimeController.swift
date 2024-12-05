import Foundation
import SwiftUI
import KeychainSwift

class AnimeController {
    
    @AppStorage("result") private var result = 10
    @AppStorage("animeRankingType") private var animeRankingType = AnimeSortType.all
    
    private let baseURL = "https://api.myanimelist.net/v2/anime"
    private let apiKey = Config.apiKey
    private let keychain = KeychainSwift()
    
    private let animePreviewFields: [ApiFields] = [.id, .title, .mainPicture, .numEpisodes, .mediaType, .startDate, .status]
    private var animeFields: [ApiFields] = [.numEpisodes, .mediaType, .startDate, .status, .mean, .synopsis, .genres, .recommendations, .endDate, .studios, .relatedAnime, .rank, .popularity, .pictures]
    
    func fetchAnimeRankings() async throws -> MediaResponse {
        var components = URLComponents(string: "\(baseURL)/ranking")!
        components.queryItems = [
            URLQueryItem(name: "ranking_type", value: animeRankingType.rawValue),
            URLQueryItem(name: "limit", value: "\(result)"),
            URLQueryItem(name: "fields", value: ApiFields.fieldsHeader(for: animePreviewFields))
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let request = buildRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MediaResponse.self, from: data)
    }
    
    func fetchAnimePreviews(searchTerm: String) async throws -> MediaResponse {
        var components = URLComponents(string: "\(baseURL)")!
        components.queryItems = [
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "limit", value: "\(result)"),
            URLQueryItem(name: "fields", value: ApiFields.fieldsHeader(for: animePreviewFields))
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let request = buildRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MediaResponse.self, from: data)
    }
    
    func fetchAnimeDetails(animeId: Int) async throws -> Media {
        var components = URLComponents(string: "\(baseURL)/\(animeId)")!
        
        components.queryItems = [
            URLQueryItem(name: "fields", value: ApiFields.fieldsHeader(for: animeFields))
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let request = buildRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Media.self, from: data)
    }
    
    func fetchNextPage(_ nextPage: String) async throws -> MediaResponse {
        guard let url = URL(string: nextPage) else {
            throw URLError(.badURL)
        }
        
        let request = buildRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MediaResponse.self, from: data)
    }
    
    private func buildRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let accessToken = keychain.get("accessToken"), !accessToken.isEmpty {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            request.setValue(apiKey, forHTTPHeaderField: "X-MAL-CLIENT-ID")
        }
        
        return request
    }
}