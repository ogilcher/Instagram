//
//  ProfileView.swift
//  Instragram
//
//  Created by Oliver Gilcher on 2/15/25.
//

import SwiftUI

struct ProfileView : View {
    @State var isDiscoveryOpen : Bool = false
    @State var showingPosts : Bool = true // Posts = true, Mentions = false
    
    var body : some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    ProfileDetails()
                    ProfileInfo()
                    ProfileOptions(isDiscoveryOpen: $isDiscoveryOpen)
                    if isDiscoveryOpen {
                        ProfileDiscovery()
                    }
                    VStack (spacing: 2) {
                        ProfileImageSelector(showingPosts: $showingPosts)
                        if showingPosts {
                            PostView(photos: 5)
                        }
                    }
                }
            }
        }
    }
}

struct ProfileDetails : View {
    var body : some View {
        HStack (spacing: 25) {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.gray)
            
            VStack {
                Text("574")
                Text("Posts")
            }
            
            VStack {
                Text("1,018")
                Text("Followers")
            }
            
            VStack {
                Text("712")
                Text("Followers")
            }
        }
    }
}

struct ProfileInfo : View {
    var body : some View {
        VStack {
            Text("Kyia")
            Text("Blogger and photographer")
            Text("Followed by paisley.print.48 and e.anny.well.52")
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfileOptions : View {
    @Binding var isDiscoveryOpen : Bool
    
    var body : some View {
        HStack {
            Button(
                action: {
                    print("pressed follow")
                },
                label: {
                    Text("Follow")
                }
            )
            .foregroundStyle(.white)
            .frame(width: 150, height: 40)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 15))
            
            Button(
                action: {
                    print("pressed messenger")
                },
                label: {
                    Text("Message")
                }
            )
            .foregroundStyle(.primary)
            .frame(width: 150, height: 40)
            .background(.gray.opacity(0.2))
            .clipShape(.rect(cornerRadius: 15))
            
            Button(
                action: {
                    print("pressed discovery")
                    isDiscoveryOpen.toggle()
                },
                label: {
                    Image(systemName: "person.badge.plus")
                }
            )
            .foregroundStyle(.primary)
            .frame(width: 40, height: 40)
            .background(.gray.opacity(0.2))
            .clipShape(.rect(cornerRadius: 15))
        }
    }
}

struct ProfileDiscovery : View {
    var body : some View {
        HStack {
            Text("Hello World")
        }
    }
}

struct ProfileImageSelector : View {
    @Binding var showingPosts : Bool
    
    var body : some View {
        VStack (spacing: 3) {
            HStack {
                Spacer()
                Button(
                    action: {
                        showingPosts = true
                    },
                    label: {
                        Image(systemName: showingPosts ? "square.grid.3x3.fill" : "square.grid.3x3")
                    }
                )
                .foregroundStyle(showingPosts ? .primary : .secondary)
                Spacer()
                Button(
                    action: {
                        showingPosts = false
                    },
                    label: {
                        Image(systemName: showingPosts ? "person.crop.square" : "person.crop.square.fill")
                    }
                )
                .foregroundStyle(showingPosts ? .secondary : .primary)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                Rectangle()
                    .frame(width: 50, height: 2)
            }
            .frame(maxWidth: .infinity, alignment: showingPosts ? .leading : .trailing)
            .padding(.horizontal, 105)
        }
    }
}

struct PostView : View {
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    var photos : Int // Change to more robust coding
    
    var body : some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(0..<photos, id: \.self) { photo in
                PhotoCollection(isMultiple: .constant(true))
            }
        }
        .padding(.horizontal, 5)
    }
}

struct PhotoCollection : View {
    @Binding var isMultiple : Bool
    
    var body : some View {
        ZStack (alignment: .topTrailing) {
            
            Rectangle()
                .fill(.gray)
                .frame(width: 130, height: 130)
            
            if isMultiple {
                Image(systemName: "square.filled.on.square")
                    .foregroundStyle(.white)
                    .padding(5)
            }
        }
    }
}

#Preview {
    ProfileView()
}
