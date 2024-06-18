import SwiftUI
import FirebaseFirestore

// Extension to extract the access token from a string.
extension String {
    func extractAccessToken() -> String? {
        if let range = self.range(of: #"\"access_token\":\"([^\"]+)\""#, options: .regularExpression) {
            return String(self[range])
        }
        return nil
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var musicAPIConnected = false
    @State private var buttonLabel = "Connect to Music Service"
    
    var body: some View {
        List {
            if let userId = UserManager.shared.getCurrentUserId() {
                Text("User ID: \(userId)")
            }
            Button("Log Out"){
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button(buttonLabel) {
                connectToSpotifyAPI()
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }
            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
    
    private var emailSection: some View {
        Section(header: Text("Email Settings")) {
            Button("Update Password"){
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATED!")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update Email"){
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("EMAIL UPDATED!")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Reset Password"){
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET!")
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    private func connectToSpotifyAPI() {
        let clientID = "d65d581aa24f40dd805299c956401bda"
        let clientSecret = "2fb1f73cf1e74d9e97339b06f4d48ab7"
        
        guard let url = URL(string: "https://accounts.spotify.com/api/token") else {
            print("Invalid URL")
            return
        }
        
        let body = "grant_type=client_credentials&client_id=\(clientID)&client_secret=\(clientSecret)"
        let bodyData = body.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let accessToken = json["access_token"] as? String ?? ""
                        let tokenType = json["token_type"] as? String ?? ""
                        let expiresIn = json["expires_in"] as? Int ?? 0
                        
                        // Now you can use these variables as needed in your code
                        print("Access Token: \(accessToken)")
                        print("Token Type: \(tokenType)")
                        print("Expires In: \(expiresIn)")
                        
                        DispatchQueue.main.async {
                            self.musicAPIConnected = true
                            self.buttonLabel = "Connected to Music Service: \(accessToken)"
                        }
                    }
                } catch {
                    print("Error deserializing JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
