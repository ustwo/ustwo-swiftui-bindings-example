//
//  ContentView.swift
//  SwiftUIDataExample
//
//  Created by Mattias Bowallius on 2019-08-06.
//  Copyright © 2019 ustwo AB. All rights reserved.
//

import SwiftUI

struct StateContentView: View {
    
    private let images: [String] = ["🚀", "⛵️", "⚓️"]
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text(images[currentIndex])
                .font(.largeTitle)
            Spacer()
                .frame(height: 16.0)
            Button(action: nextImage, label: {
                Text("Next")
            })
            Spacer()
        }
    }
    
    private func nextImage() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}

#if DEBUG
struct StateContentView_Previews: PreviewProvider {
    static var previews: some View {
        StateContentView()
    }
}
#endif
