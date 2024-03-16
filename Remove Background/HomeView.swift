//
//  HomeView.swift
//  Remove Background
//
//  Created by Temiloluwa Akisanya on 16/03/2024.
//

import SwiftUI
import AppKit

struct HomeView: View {
    @State private var selectedImage: NSImage? = nil
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            
            VStack {
                if let image = selectedImage {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: height / 2)
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
        }
    }
    
    func pickImage() {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [.heif, .jpeg, .png, .svg]
        openPanel.allowsMultipleSelection = false
        
        if openPanel.runModal() == .OK {
            if let selectedUrl = openPanel.url, let image = NSImage(contentsOfFile: selectedUrl.path) {
                selectedImage = image
            }
        }
    }
}

#Preview {
    HomeView()
}
