//
//  AppDelegate.swift
//  Remove Background
//
//  Created by Temiloluwa Akisanya on 17/03/2024.
//

import AppKit

extension Notification.Name {
    static let receivedUrlsNotification = Notification.Name("ReceivedURLsNotification")
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func application(_ application: NSApplication, open urls: [URL]) {
        guard !urls.isEmpty else {return}
        
        NotificationCenter.default.post(name: .receivedUrlsNotification, object: nil, userInfo: ["URLs" : urls])
    }
}
