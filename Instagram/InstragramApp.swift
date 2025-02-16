//
//  InstragramApp.swift
//  Instragram
//
//  Created by Oliver Gilcher on 2/15/25.
//

import SwiftUI
import AWSS3

func initializeS3() {
    let poolId = ""
    let region = AWSRegionType.USWest1
    
    let credentialsProvider = AWSCognitoCredentialsProvider(
        regionType: region,
        identityPoolId: poolId
    )
    let configuration = AWSServiceConfiguration(region: region, credentialsProvider: credentialsProvider)
    AWSServiceManager.default().defaultServiceConfiguration = configuration
}


@main
struct InstragramApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
