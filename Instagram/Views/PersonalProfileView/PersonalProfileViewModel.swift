//
//  ProfileProfileViewModel.swift
//  Instagram
//
//  Created by Oliver Gilcher on 2/16/25.
//

import Foundation

final class PersonalProfileViewModel : ObservableObject {
    static var shared = PersonalProfileViewModel()
    init() {}
    
    @Published var isLoading: Bool = true
}
