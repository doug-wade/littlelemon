//
//  OnboardingView.swift
//  PrimoFiori
//
//  Created by Doug Wade on 3/1/24.
//

import SwiftUI

enum UserDefaultsKey: String {
    case firstName = "first name key"
    case lastName = "last name key"
    case email = "email key"
    case isLoggedIn = "is logged in key"
}

struct OnboardingView: View {
    @State private var isLoggedIn = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: HomeView(),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                Button("Register") {
                    if (
                        !firstName.isEmpty &&
                        !lastName.isEmpty &&
                        email.contains(/\@/)
                    ) {
                        UserDefaults.standard.set(
                            firstName,
                            forKey: UserDefaultsKey.firstName.rawValue
                        )
                        UserDefaults.standard.set(
                            lastName,
                            forKey: UserDefaultsKey.lastName.rawValue
                        )
                        UserDefaults.standard.set(
                            email,
                            forKey: UserDefaultsKey.email.rawValue
                        )
                        UserDefaults.standard.set(
                            true,
                            forKey: UserDefaultsKey.isLoggedIn.rawValue
                        )
                        isLoggedIn = true
                    }
                }
            }
            .padding()
            .onAppear() {
                if (
                    UserDefaults.standard.bool(
                        forKey: UserDefaultsKey.isLoggedIn.rawValue
                    )
                ) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
