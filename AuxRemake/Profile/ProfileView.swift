//
//  ProfileView.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/27/24.
//

import SwiftUI
import FirebaseFirestore
import GoogleSignIn

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil

    func loadCurrentUser() async throws {
        guard let userId = UserManager.shared.getCurrentUserId() else {
            return
        }

        self.user = try await UserManager.shared.getUser(userId: userId)
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool

    @State private var userId: String? = nil

    var body: some View {
        List {
            if let name = UserManager.shared.getName() {
                Text("Welcome \(name)!")
                    .font(.headline) // Makes the text bigger

            }
        }
        .task {
            do {
                try await viewModel.loadCurrentUser()
            } catch {
                // handle error
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(showSignInView: .constant(false))
        }
    }
}
