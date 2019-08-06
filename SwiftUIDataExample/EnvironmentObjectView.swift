//
//  EnvironmentObjectView.swift
//  SwiftUIDataExample
//
//  Created by Mattias Bowallius on 2019-08-06.
//  Copyright © 2019 ustwo AB. All rights reserved.
//

import SwiftUI

struct EnvironmentObjectView: View {
    
    @EnvironmentObject var imageModel: ImageModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(imageModel.currentImage)
                .font(.largeTitle)
            Spacer()
                .frame(height: 16.0)
            Button(action: imageModel.nextImage, label: {
                Text("Next")
            })
            Spacer()
        }
    }
}

#if DEBUG
struct EnvironmentObjectView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectView()
    }
}
#endif

final class ImageModel: ObservableObject {
    
    private let images: [String] = ["🚀", "⛵️", "⚓️"]
    
    private var currentIndex = 0
    
    @Published var currentImage: String
    
    init() {
        currentImage = images[currentIndex]
    }
    
    func nextImage() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        currentImage = images[currentIndex]
    }
}
