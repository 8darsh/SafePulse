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
                NavigationStack{
                    HomeView(isSignedIn: $isSignedIn,path: $path)
                }
            } else {
                SignInView(isSignedIn: $isSignedIn)
            }
        }.onAppear(perform: {
            checkAuth()
        })
        
        .onChange(of: isSignedIn){
            newValue in
            
            if !newValue{
                path = NavigationPath()
            }
        }
        
    
        
        
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
