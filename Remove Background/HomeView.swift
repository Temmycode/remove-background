//
//  HomeView.swift
//  Remove Background
//
//  Created by Temiloluwa Akisanya on 16/03/2024.
//

import SwiftUI
import AppKit

struct HomeView: View {
    @Environment(Repository.self) var repositoryProvider
    @State private var selectedImage: NSImage? = nil
    @State private var fileName: String?
    @State private var receivedURLs: [URL] = []
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            
            VStack(spacing: 20) {
                if let image = selectedImage {
                    Image(nsImage: repositoryProvider.removedBackgroundImage ?? image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: height / 2)
                    
                    buttonLoader
                    
                } else {
                    VStack(spacing: 10.0) {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.light)
                            .frame(width: 175)
                        
                        Text("Drag an image into the screen")
                            .font(.title)
                            .fontWeight(.regular)
                    }
                }
            }
            .toolbar {
                Button {
                    pickImage()
                } label: {
                    Label("Add image from finder", systemImage: "plus")
                }
                .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(NotificationCenter.default.publisher(for: .receivedUrlsNotification), perform: { notification in
                if let image = notification.userInfo?["URLs"] as? NSImage {
                    print(image)
                    selectedImage = image
                }
            })
        }
    }
    
    @ViewBuilder
    var buttonLoader: some View {
        if repositoryProvider.isLoading {
            ProgressView()
        } else {
            Button("Remove Background") {
                Task {
                    repositoryProvider.removeBackground(paramName: "image", fileName: fileName!, image: selectedImage!)
                }
            }.buttonStyle(.borderedProminent)
        }
    }
    
    func pickImage() {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [.heif, .jpeg, .png, .svg]
        openPanel.allowsMultipleSelection = false
        
        if openPanel.runModal() == .OK {
            if let selectedUrl = openPanel.url, let image = NSImage(contentsOfFile: selectedUrl.path) {
                fileName = selectedUrl.lastPathComponent
                selectedImage = image
            }
        }
    }
}

#Preview {
    HomeView()
}
