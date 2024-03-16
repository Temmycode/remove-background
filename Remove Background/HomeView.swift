//
//  HomeView.swift
//  Remove Background
//
//  Created by Temiloluwa Akisanya on 16/03/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .fontWeight(.light)
                .frame(width: 175)
            
            Text("Drag an image into the screen")
                .font(.title)
                .fontWeight(.regular)
        }
        .toolbar {
            Button {
                
            } label: {
                Label("Add image from finder", systemImage: "plus")
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    HomeView()
}
