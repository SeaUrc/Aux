//
//  AuthenticationView.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/26/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // Function to handle Google Sign-In
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        ZStack {
            // Background image
            Image("AUXBACKGROUND")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea() // Ensures the image covers the entire screen

            VStack {
                // Spacer to push the title and image upwards
                Spacer()
                    .frame(height: 50) // Adjust the height as needed to raise the title and image
                
                // VStack for title and image
                VStack {
                    // Custom title centered in the navigation bar
                    Text("  A  U  X  ?")
                        .font(.system(size: 48, weight: .bold)) // Adjusted font size
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Image below the navigation title
                    Image("AUX LOGO")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180) // Adjust the height as needed
                }
                .padding(.bottom, 70) // Additional padding below the title and image
                
                // Spacer to push the buttons slightly downwards
                Spacer()
                    .frame(height: 130) // Adjust this height to slightly lower the buttons

                // NavigationLink to the email sign-in view
                NavigationLink {
                    SignInEmailView(showSignInView: $showSignInView)
                } label: {
                    HStack {
                        Spacer()
                        Text("Sign In With Email")
                            .font(.headline)
                            .foregroundColor(.black) // Text color set to black
                            .frame(height: 55)
                        Spacer()
        
                    }
                    .frame(maxWidth: 300)
                    .background(Color.white) // White background
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1) // Black outline
                    )
                }
                Spacer()
                    .frame(height:35)
                
                // Google Sign-In button
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)){
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                }
                .frame(maxWidth: 300) // Set the maximum width of the GoogleSignInButton
                
                Spacer() // Spacer at the bottom to add some flexibility in layout
            }
            .padding()
            .navigationTitle("") // Empty to make space for custom title
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
