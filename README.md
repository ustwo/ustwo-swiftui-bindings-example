# SwiftUI data example

[![Build Status](https://img.shields.io/badge/platforms-iOS-lightgrey.svg)]()
[![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.0-blue.svg)](https://developer.apple.com/xcode)

With SwiftUI handling the state of a view has never been easier. There are however some common pitfalls. Take this perfectly valid prototype code for instance.

![](/app_preview.gif)
```swift
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
```

This was a great way of getting something up and running quickly, however now we want to convert this code into production code where we might want the current image state to be shared by multiple views.

In UIKit we would either have stored the value in a common model or passed the current image along to the child view controller when navigating. While both options are still available to us in SwiftUI it is incredibly easy to pass along model dependencies to the view and all of it's children. Step in ObservableObject.

```swift
    final class ImageModel: ObservableObject {
       ...
    }
```

By making our model object conform to the ObservableObject protocol we are able to pass it along as an environment object on our view when 
we instantiate it.

```swift
     EnvironmentObjectView().environmentObject(ImageModel())
```

The model will now be available to the view and all of its children by adding the @EnvironmentObject annotation to it like so

```swift
    struct EnvironmentObjectView: View {
        @EnvironmentObject var imageModel: ImageModel
        ...
    }
```

But the real magic comes now. By marking any properties that we want to be able to observe changes to with @Published we can now simply assign the value of those properties as data for our view and it will automatically update whenever the models value changes.

```swift
    final class ImageModel: ObservableObject {
        ...
        @Published var currentImage: String
        ...
    }

    struct EnvironmentObjectView: View {
    
        @EnvironmentObject var imageModel: ImageModel
    
        var body: some View {
            VStack {
                ...
                Text(imageModel.currentImage)
                    .font(.largeTitle)
                ...
                Button(action: imageModel.nextImage, label: {
                    Text("Next")
                })
                ...
            }
        }
    }
```

And that's it! We now have a fully reusable model that is shared between all the views. Both the views and model are also fully testable since all dependencies have been injected through the Environment.

## Maintainers

* Mattias Bowallius (@MattiasBowallius)

## Contact

[open.source@ustwo.com](mailto:open.source@ustwo.com)
