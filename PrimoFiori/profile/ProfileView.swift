//
//  UserProfileView.swift
//  PrimoFiori
//
//  Created by Doug Wade on 3/1/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(
        forKey: UserDefaultsKey.firstName.rawValue
    )
    let lastName = UserDefaults.standard.string(
        forKey: UserDefaultsKey.lastName.rawValue
    )
    let email = UserDefaults.standard.string(
        forKey: UserDefaultsKey.email.rawValue
    )
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text("First name: " + (firstName ?? ""))
            Text("Last name: " + (lastName ?? ""))
            Text("Email: " + (email ?? ""))
            Button("Logout") {
                UserDefaults.standard.setValue(
                    false,
                    forKey: UserDefaultsKey.isLoggedIn.rawValue
                )
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
