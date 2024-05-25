//
//  SettingsView.swift
//  SafePulse
//
//  Created by Adarsh Singh on 25/05/24.
//

import SwiftUI
import Firebase
struct SettingsView: View {
    @Binding var isSignedIn:Bool
    @Binding var path: NavigationPath
    var body: some View {
        NavigationStack{
            List {
                Button {
                    signOut()
                } label: {
                    Text("Log Out")
                }
            }
            .navigationTitle("Settings")

        }
        

    }
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
            
          try firebaseAuth.signOut()
            isSignedIn = false
            path.removeLast(path.count)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        
       
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    @State static var isSignedIn = false
    @State static var path = NavigationPath()
    static var previews: some View {
        NavigationStack{
            SettingsView(isSignedIn: $isSignedIn,path: $path)
        }
    }
}

