//
//  SignInEmailView.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/26/24.
//

import SwiftUI

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .frame(width: 300) // Adjust the width as needed
                .multilineTextAlignment(.center) // Center the text
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            SecureField("Password", text: $viewModel.password)
                .frame(width: 300) // Adjust the width as needed
                .multilineTextAlignment(.center) // Center the text
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                       print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .frame(width: 300) // Adjust the width as needed
                    .multilineTextAlignment(.center) // Center the text
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            Button {
                // Add your navigation action here
            } label: {
                NavigationLink(destination: CreateAccountEmailView(showSignInView: .constant(false))) {
                    Text("Create Account")
                        .frame(width: 300) // Adjust the width as needed
                        .multilineTextAlignment(.center) // Center the text
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }

            
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack {
            SignInEmailView(showSignInView: .constant(false))
        }
    }
}
