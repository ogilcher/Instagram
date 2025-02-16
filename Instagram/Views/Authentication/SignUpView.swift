//
//  SignUpView.swift
//  Instagram
//
//  Created by Oliver Gilcher on 2/16/25.
//

import SwiftUI

@MainActor
final class SignUpViewModel : ObservableObject {
    @Published var email: String? = ""
    @Published var phoneNumber: String? = ""
    @Published var fullName: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    
}

struct SignUpView: View {
    @ObservedObject private var viewModel = SignUpViewModel()
    @State private var enteredIdentifier : String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Instagram")
                    .font(.largeTitle)
                
                Text("Sign up to see photos and videos")
                    .font(.headline)
                Text("from your friends.")
                
                ZStack (alignment: .center) {
                    Divider()
                        .frame(height: 2)
                    Text("OR")
                        .frame(width: 75)
                        .background(Color.init(UIColor.systemBackground))
                }
                .frame(width: 350)
                
                TextField("Mobile Number or Email", text: $enteredIdentifier)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 55)
                    .background(.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                            .fill(.clear)
                    )
                
                    .onSubmit {
                        translateIdentifier()
                    }
                
                TextField("Full Name", text: $viewModel.fullName)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 55)
                    .background(.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                            .fill(.clear)
                    )
                
                TextField("Username", text: $viewModel.userName)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 55)
                    .background(.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                            .fill(.clear)
                    )
                
                TextField("Password", text: $viewModel.password)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 55)
                    .background(.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                            .fill(.clear)
                    )
                
                Text("People who use our service may have uploaded")
                Text("your contact information to Instagram.")
                
                Text("By signing up, you agree to our Terms, Privacy")
                Text("Policy and Cookies Policy.")
                
                Button {
                    print("Signed up")
                } label: {
                    Text("Sign up")
                        .foregroundStyle(.white)
                        .frame(width: 300, height: 45)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                HStack (spacing: 5) {
                    Text("Have an account?")
                    NavigationLink(
                        destination: self.navigationBarBackButtonHidden(),
                        label: {
                            Text("Log in")
                        }
                    )
                }
                
            }
            .padding()
        }
    }
    
    func translateIdentifier () {
        let phoneRegex = "^[0-9+\\-()\\s]{7,}$" // Allows digits, spaces, dashes, parentheses, and '+'
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-0.-]+\\.[A-Za-z]{2,}$" // Standard email pattern
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if phonePredicate.evaluate(with: enteredIdentifier) {
            viewModel.phoneNumber = enteredIdentifier.filter { $0.isNumber }
        } else if emailPredicate.evaluate(with: enteredIdentifier){
            viewModel.email = enteredIdentifier
        } else {
            print("You entered something unidentifiable")
        }
    }
}

#Preview {
    SignUpView()
}
