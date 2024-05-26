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
                .offset(x: 0, y: 0)
                .opacity(0.20)
            VStack(spacing: 24) {
                VStack(spacing: 2) {
                    Text("Create an account")
                        .font(Font.custom("Inter", size: 18))
                        .bold()
                        .lineSpacing(2)
                        .foregroundColor(.black)
                        .padding()
                    Text("Enter your email to sign up for this app")
                        .font(Font.custom("Inter", size: 14))
                        .lineSpacing(21)
                        .foregroundColor(.black)
                }
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 16) {
                        TextField("email@domaincom", text: $email)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .background(.white)
                            .cornerRadius(8)
                        
                    }.padding(.top)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    HStack(spacing: 16) {
                        Button{
                            
                        }label: {
                            Text("Sign up with email")
                                .font(Font.custom("Inter", size: 14).weight(.medium))
                                .lineSpacing(19.60)
                                .foregroundColor(.white)
                        }
                            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .background(.black)
                            .cornerRadius(8)

                    }.padding()
                    
                    HStack(spacing: 8) {
                      Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                        .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                      Text("or continue with")
                        .font(Font.custom("Inter", size: 14))
                        .lineSpacing(19.60)
                        .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                      Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
                        .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                    }
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
                            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                    } .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        .offset(x: 0, y: 3)
                    

                    
                    
                    

                    
                }

            }
            Text("SafePulse")
              .font(Font.custom("Inter", size: 24))
              .lineSpacing(36)
              .foregroundColor(.black)
              .offset(x: -0.50, y: -296)
              .bold()

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
