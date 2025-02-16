//
//  ContentView.swift
//  Instragram
//
//  Created by Oliver Gilcher on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                Tab("", systemImage: "house") {
                    Text("Put a HomeView here")
                }
                Tab("", systemImage: "magnifyingglass") {
                    NavigationStack {
                        Text("Search View")
                            .navigationTitle("Search")
                    }
                }
                Tab("", systemImage: "plus.app") {
                    NavigationStack {
                        Text("Add image View")
                            .navigationTitle("Add Image")
                    }
                }
                
                Tab("", systemImage: "bag") {
                    NavigationStack {
                        Text("Shopping")
                            .navigationTitle("Shopping")
                    }
                }
                
                Tab("", systemImage: "person.circle") {
                    NavigationStack {
                        PersonalProfileView()
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
