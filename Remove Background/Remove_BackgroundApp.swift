//
//  Remove_BackgroundApp.swift
//  Remove Background
//
//  Created by Temiloluwa Akisanya on 16/03/2024.
//

import SwiftUI

@main
struct Remove_BackgroundApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var repositoryProvider = Repository()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(repositoryProvider)
        }
    }
}
