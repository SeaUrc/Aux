//
//  AuthenticationView.swift
//  AuxRemake
//
//  Created by Josh Grewal on 5/26/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 300)
                    .background(Color.black)
                    .cornerRadius(10)
                    
            }
        }
        
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
        
        .padding()
        .navigationTitle("Sign In")
    }
}

struct AuthenticationView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
