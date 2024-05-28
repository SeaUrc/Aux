//
//  SignInViewModel.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/27/24.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else { //Can add validation here
            throw NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "No email or password found."])
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }

}
