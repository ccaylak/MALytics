import Foundation
import KeychainSwift

@MainActor
class TokenHandler: ObservableObject {
    static let shared = TokenHandler()

    private let keychain = KeychainSwift()

    private var accessToken: String?
    @Published private(set) var isAuthenticated: Bool = false

    private init() {
        populateAccess()
    }

    private func populateAccess() {
        if let token = keychain.get("accessToken") {
            accessToken = token
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }

    func setToken(_ token: Data) {
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("Fehler beim Umwandeln des Tokens in String")
            return
        }

        keychain.set(tokenString, forKey: "accessToken")
        accessToken = tokenString
        isAuthenticated = true
    }

    func getToken() -> String? {
        return accessToken
    }

    func revokeToken() {
        keychain.delete("accessToken")
        accessToken = nil
        isAuthenticated = false
    }
}
