//
//  FeedView.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/29/24.
//

import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil

    func loadCurrentUser() async throws {
        guard let userId = UserManager.shared.getCurrentUserId() else {
            return
        }

        self.user = try await UserManager.shared.getUser(userId: userId)
    }
}

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        List {
                Text("Feedview")
                    .font(.headline) // Makes the text bigger

            }
        .task {
            do {
                try await viewModel.loadCurrentUser()
            } catch {
                // handle error
            }
        }
        .navigationTitle("Feed")
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
