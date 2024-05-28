import SwiftUI
import FirebaseFirestore

@MainActor
final class CreateAccountEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func signUp() async throws -> Bool {
        guard !email.isEmpty, !password.isEmpty else { //Can add validation here
            print("No email or password found.")
            return false
        }
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try await AuthenticationManager.shared.signInUser(email: email, password: password) // Automatically sign in the user
        if let userId = UserManager.shared.getCurrentUserId() {
            let userRef = Firestore.firestore().collection("users").document(userId)
            var userData: [String:Any] = [
                "user_id": authDataResult.uid,
                "date_created": Timestamp(),
                "music_api_connected": authDataResult.musicAPIConnected ?? false
            ]
            if let email = authDataResult.email {
                userData["email"] = email
            }
            if let photoUrl = authDataResult.photoUrl {
                userData["photo_url"] = photoUrl
            }
            try await userRef.setData(userData, merge: false)
        }
        return true
    }
}

struct CreateAccountEmailView: View {
    
    @StateObject private var viewModel = CreateAccountEmailViewModel()
    @Binding var showSignInView: Bool
    @Environment(\.dismiss) var dismiss
    
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
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .frame(width: 300) // Adjust the width as needed
                .multilineTextAlignment(.center) // Center the text
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        let signUpSuccess = try await viewModel.signUp()
                        if signUpSuccess {
                            dismiss()
                            // Navigate to settings page here
                        }
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign Up")
                    .frame(width: 300) // Adjust the width as needed
                    .multilineTextAlignment(.center) // Center the text
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Create Account")
        }
    }
    
    struct CreateAccountEmailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                CreateAccountEmailView(showSignInView: .constant(false))
            }
        }
    }
}
