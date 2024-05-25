//
//  SignInView.swift
//  SafePulse
//
//  Created by Adarsh Singh on 25/05/24.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct SignInView: View {
    @Binding var isSignedIn: Bool
    
    var body: some View {
        VStack {
            Button(action: signIn) {
                Text("Sign in with Google")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    func signIn(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
          guard error == nil else {
            
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          
         Auth.auth().signIn(with: credential) { result, error in
             
             if let error = error {
                 print("Firebase sign in error: \(error.localizedDescription)")
                 return
             }
             isSignedIn = true
             print("User is signed in with Firebase")
             
             
          }
                
        }
    }
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return UIViewController() }
        guard let rootViewController = screen.windows.first?.rootViewController else { return UIViewController() }
        return rootViewController
    }
}
    



struct SignInView_Previews: PreviewProvider {
    @State static var isSignedIn = false

    static var previews: some View {
        SignInView(isSignedIn: $isSignedIn)
    }
}
