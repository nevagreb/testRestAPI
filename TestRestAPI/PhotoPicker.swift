//
//  PhotoPicker.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 27.03.2024.
//

import PhotosUI
import SwiftUI

struct PhotoPicker: View {
    @State private var pickerItem: PhotosPickerItem? = PhotosPickerItem(itemIdentifier: "String1")
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .scaledToFit()
            PhotosPicker("Select a photo", selection: $pickerItem, matching: .images)
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}

#Preview {
    PhotoPicker()
}
