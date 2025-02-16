//
//  AccountsCenterView.swift
//  Instragram
//
//  Created by Oliver Gilcher on 2/15/25.
//

import SwiftUI

struct AccountsCenterView: View {
    @Binding var showing: Bool
    
    var body: some View {
        VStack {
            AccountsCenterHeader(showing: $showing)
            ScrollView {
                VStack (spacing: 15) {
                    Text("Accounts Center")
                    Text("Manage your connected experiences and account settings across Meta technologies like Facebook, Instagram and Meta Horizon.")
                        .multilineTextAlignment(.center)
                    
                    // Profiles opener
                    NavigationLink(
                        destination: self.navigationBarBackButtonHidden(true),
                        label: {
                            HStack {
                                Circle()
                                    .fill(.gray)
                                    .frame(width: 50, height: 50)
                                VStack {
                                    Text("Profiles")
                                        .foregroundStyle(.primary)
                                    Text("Oli Gilcher")
                                        .foregroundStyle(.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .frame(width: 350, height: 70)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        }
                    )
                }
            }
        }
        .padding()
        .background(.settingsBackground)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AccountsCenterHeader: View {
    @Binding var showing: Bool
    
    var body : some View {
        HStack {
            Button(
                action: {
                    showing = false
                },
                label: {
                    Image(systemName: "xmark")
                }
            )
            Spacer()
            Text("∞ Meta")
            Spacer()
        }
        .foregroundStyle(.primary)
        .fontWeight(.semibold)
    }
}

#Preview {
    AccountsCenterView(showing: .constant(true))
}
