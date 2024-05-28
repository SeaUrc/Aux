//
//  SettingsView.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/26/24.
//

import SwiftUI
import FirebaseFirestore

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var musicAPIConnected = false
    
    var body: some View {
        List {
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
            
            Button("Connect to Music Service") {
                if let url = URL(string: "https://accounts.spotify.com/en/login") {
                    UIApplication.shared.open(url)
                }
                
                Task {
                    do {
                        if let userId = UserManager.shared.getCurrentUserId() {
                            // Update the musicAPIConnected property in Firestore
                            let userRef = Firestore.firestore().collection("users").document(userId)
                            try await userRef.updateData(["music_api_connected": true])
                        }
                    } catch {
                        print(error)
                    }
                }
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
}

extension SettingsView {
    
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
}
