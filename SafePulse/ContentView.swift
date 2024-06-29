//
//  ContentView.swift
//  SafePulse
//
//  Created by Adarsh Singh on 25/05/24.
//

import SwiftUI
import Firebase
struct ContentView: View {
    @State private var isSignedIn = false
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            if isSignedIn {
           
                HomeView(isSignedIn: $isSignedIn,path: $path)
            
            } else {
                SignInView(isSignedIn: $isSignedIn)
            }
        }.onAppear(perform: {
            checkAuth()
        })
        

        
    
        
        
    }
    func checkAuth(){
        if Auth.auth().currentUser != nil{
            isSignedIn = true
        }else{
            isSignedIn = false
        }
    }
}

#Preview {
    ContentView()
}
