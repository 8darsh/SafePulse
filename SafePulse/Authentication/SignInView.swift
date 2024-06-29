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
    @State var email:String = ""
    
    var body: some View {
        ZStack() {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 375, height: 812)
                .background(
                    AsyncImage(url: URL(string: "https://images.pexels.com/photos/3951632/pexels-photo-3951632.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
                )
                .opacity(0.35)
            VStack(spacing: 24) {
                VStack(spacing: 2) {
                    Text("Sign in with Google")
                        .font(.title2)
                        
                        .bold()
                        .lineSpacing(2)
                        .foregroundColor(.black)
                        .padding()
                    
                    
                    VStack{
                        HStack(spacing: 16) {
                            Button(action: {
                                signIn()
                            }) {
                                HStack {
                                    Image("gg") // Replace with the name of your logo image
                                        .resizable()
                                        .frame(width: 20, height: 20) // Adjust the size as needed
                                    Text("Google")
                                        .font(Font.custom("Inter", size: 14).weight(.medium))
                                        .lineSpacing(19.60)
                                        .foregroundColor(.black)
                                }

                            }
                            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                            
                        }.padding()
                        
                        Text("By clicking continue, you agree to our Terms of Service and Privacy Policy")
                            .font(Font.custom("Inter", size: 12))
                            .lineSpacing(1)
                            .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                    } .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        .offset(x: 0, y: 3)

                }

            }
            Text("SafePulse")
                .font(.largeTitle)
              .lineSpacing(36)
              .foregroundColor(.black)
              .offset(x: -0.50, y: -296)
              .bold()

        }
        
    }
                    
    
    
    
    

    
    

    
}

extension SignInView{
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
