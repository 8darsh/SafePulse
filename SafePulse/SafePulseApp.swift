//
//  SafePulseApp.swift
//  SafePulse
//
//  Created by Adarsh Singh on 25/05/24.
//

import SwiftUI
import FirebaseAuth

@main
struct SafePulseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    handleSignIn(with: url)
                })
        }
    }
    
    func handleSignIn(with url: URL) {
        if let email = UserDefaults.standard.string(forKey: "Email") {
            Auth.auth().signIn(withEmail: email, link: url.absoluteString) { result, error in
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                    return
                }
                print("Successfully signed in with email link")
            }
        }
    }
}
