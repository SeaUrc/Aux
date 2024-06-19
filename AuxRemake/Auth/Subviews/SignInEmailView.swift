import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else { // Can add validation here
            throw NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "No email or password found."])
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Image("invertCrop")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("  L  O  G  I  N  ")
                    .font(.system(size: 48, weight: .bold)) // Adjusted font size
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .colorInvert()
                
                Spacer()
                    .frame(height: 170) // Adjust the height as needed to raise the title and image
                
                Spacer()
                    .frame(height: 100)
                
                TextField("Email", text: $viewModel.email)
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                SecureField("Password", text: $viewModel.password)
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                Spacer()
                    .frame(height: 50)
                
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
                        .frame(width: 340, height: 55) // Enlarge button to match text box dimensions
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                Button {
                    // Add your navigation action here
                } label: {
                    NavigationLink(destination: CreateAccountEmailView(showSignInView: .constant(false))) {
                        Text("Create Account")
                            .frame(width: 340, height: 55) // Enlarge button to match text box dimensions
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationTitle("") // Empty to make space for custom title
        }
    }
}

// Preview struct for Xcode canvas
struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInEmailView(showSignInView: .constant(true))
    }
}


