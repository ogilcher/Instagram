//
//  PersonalProfileView.swift
//  Instagram
//
//  Created by Oliver Gilcher on 2/15/25.
//

import SwiftUI

/// **Personal Profile View**
/// Displays user's personal profile with details, options, and posts.
struct PersonalProfileView: View {
    @State private var isDiscoveryOpen = false
    @State private var showingPosts = true // True: Posts, False: Mentions
    
    @State @ObservedObject private var viewModel = PersonalProfileViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    PersonalDetails(viewModel: $viewModel)
                    PersonalInfo()
                    PersonalOptions(isDiscoveryOpen: $isDiscoveryOpen)
                    
                    if isDiscoveryOpen {
                        PersonalDiscovery()
                    }

                    VStack(spacing: 2) {
                        PersonalImageSelector(showingPosts: $showingPosts)
                        if showingPosts {
                            PersonalPostView(viewModel: $viewModel, photos: 13)
                        }
                    }
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            /// **Navigation Title & Account Selector**
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    print("Opened account selector")
                } label: {
                    HStack(spacing: 2) {
                        Text("oliver.gilcher")
                            .font(.system(size: 20))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                    }
                }
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            }

            /// **Top Bar Actions (Create & Settings)**
            ToolbarItemGroup(placement: .topBarTrailing) {
                HStack {
                    Button {
                        print("Opened create menu")
                    } label: {
                        Image(systemName: "plus.app")
                    }

                    NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            }
        }
    }
}

/// **Personal Profile Details (Profile Image, Name, Stats)**
struct PersonalDetails: View {
    @Binding @ObservedObject var viewModel : PersonalProfileViewModel
    
    var body: some View {
        HStack(spacing: 25) {
            NavigationLink(destination: EmptyView().navigationBarBackButtonHidden(true)) {
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.gray)
                        .skeleton(Circle(), isLoading: viewModel.isLoading)

                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 23))
                        .background(Color.init(uiColor: UIColor.systemBackground))
                        .foregroundStyle(.primary)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.init(uiColor: UIColor.systemBackground), lineWidth: 4))
                        .padding(5)
                }
            }
            .foregroundStyle(.primary)

            VStack(spacing: 8) {
                Text("Oli Gilcher")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 20) {
                    ProfileStats(number: "13", label: "posts")
                    ProfileStats(number: "424", label: "followers")
                    ProfileStats(number: "493", label: "following")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 10)
    }
}

/// **Reusable Profile Stats Component**
private struct ProfileStats: View {
    let number: String
    let label: String

    var body: some View {
        VStack {
            Text(number).fontWeight(.semibold)
            Text(label)
        }
    }
}

/// **Personal Bio & Description**
struct PersonalInfo: View {
    var body: some View {
        VStack {
            Text("Software Engineer & Developer\nCreator of this app")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .font(.system(size: 15))
    }
}

/// **Profile Options (Edit Profile, Share, Discovery)**
struct PersonalOptions: View {
    @Binding var isDiscoveryOpen: Bool

    var body: some View {
        HStack {
            ProfileButton(title: "Edit profile")
            ProfileButton(title: "Share profile")
            ProfileIconButton(icon: "person.badge.plus") { isDiscoveryOpen.toggle() }
        }
    }
}

/// **Reusable Button Components**
private struct ProfileButton: View {
    let title: String

    var body: some View {
        Button(title) {}
            .foregroundStyle(.primary)
            .frame(width: 160, height: 35)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.primary, lineWidth: 1))
    }
}

private struct ProfileIconButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
        }
        .foregroundStyle(.primary)
        .frame(width: 35, height: 35)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.primary, lineWidth: 1))
    }
}

/// **Personal Discovery Section**
struct PersonalDiscovery: View {
    var body: some View {
        HStack { Text("Hello World") }
    }
}

/// **Image Selector (Posts vs. Mentions)**
struct PersonalImageSelector: View {
    @Binding var showingPosts: Bool

    var body: some View {
        VStack(spacing: 3) {
            HStack {
                Spacer()
                ImageSelectorButton(icon: "square.grid.3x3.fill", isActive: showingPosts) {
                    showingPosts = true
                }
                Spacer()
                ImageSelectorButton(icon: "person.crop.square.fill", isActive: !showingPosts) {
                    showingPosts = false
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)

            HStack {
                Rectangle().frame(width: 50, height: 2)
            }
            .frame(maxWidth: .infinity, alignment: showingPosts ? .leading : .trailing)
            .padding(.horizontal, 105)
        }
    }
}

/// **Reusable Image Selector Button**
private struct ImageSelectorButton: View {
    let icon: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
        }
        .foregroundStyle(isActive ? .primary : .secondary)
    }
}

/// **Personal Post Grid View**
struct PersonalPostView: View {
    @Binding @ObservedObject var viewModel: PersonalProfileViewModel
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    var photos: Int

    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(0..<photos, id: \.self) { _ in
                PersonalPhotoCollection(isMultiple: .constant(true), viewModel: $viewModel)
            }
        }
        .padding(.horizontal, 5)
    }
}

/// **Individual Photo Component**
struct PersonalPhotoCollection: View {
    @Binding var isMultiple: Bool
    @Binding @ObservedObject var viewModel: PersonalProfileViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .fill(.gray)
                .frame(width: 130, height: 130)
                .skeleton(isLoading: viewModel.isLoading)

            if isMultiple {
                Image(systemName: "square.filled.on.square")
                    .foregroundStyle(.white)
                    .padding(5)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PersonalProfileView()
    }
}
