//
//  HomeView.swift
//  SafePulse
//
//  Created by Adarsh Singh on 25/05/24.
//

import SwiftUI
import Firebase
struct HomeView: View {
    @Binding var isSignedIn:Bool
    @Binding var path: NavigationPath
    var body: some View {
        NavigationStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView(isSignedIn: $isSignedIn, path: $path)) {
                    Image(systemName: "gear")
                }
                
                
            }
        }
    }
    

}

struct HomeView_Previews: PreviewProvider {
    @State static var isSignedIn = false
    @State static var path = NavigationPath()
    static var previews: some View {
        NavigationStack{
            HomeView(isSignedIn: $isSignedIn,path: $path)
        }
    }
}
