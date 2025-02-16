//
//  SettingsView.swift
//  Instragram
//
//  Created by Oliver Gilcher on 2/15/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    @State var accountCenterShowing: Bool = false
    
    var body: some View {
        ScrollView {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)
                Button (action: { self.searchText = "" },
                    label: {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                )
            }
            .padding()
            .frame(width: 350, height: 40)
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 15))
            
            Button(
                action: {
                    accountCenterShowing = true
                },
                label: {
                    Text("open accountcentershowing")
                }
            )
            
        }
        .navigationTitle("Settings and activity")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Button (
                        action: {
                            dismiss()
                        },
                        label: {
                            Image(systemName: "chevron.left")
                        }
                    )
                }
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            }
        }
        .sheet(isPresented: $accountCenterShowing, content: {
            AccountsCenterView(showing: $accountCenterShowing)
                .presentationCornerRadius(30)
        })
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
