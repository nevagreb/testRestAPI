//
//  NewContactView.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 25.03.2024.
//

import SwiftUI
import PhotosUI

struct ContactView: View {
    var person: Person?
    var saveHandler: (_ person: Person) async throws -> Void
    
    @State private var name: String = ""
    @State private var last_name: String = ""
    @State private var email: String = ""
    
    var title: String {
        if let _ = person {
            "Edit contact"
        } else {
            "New contact"
        }
    }
   
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                image
                PhotoPicker()
                list
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    buttonSave
                }
                ToolbarItem(placement: .topBarLeading) {
                    buttonBack
                
                }
            }
        }
    }
    
    @ViewBuilder
    var buttonBack: some View {
        if person == nil {
            Button("Back", role: .cancel) {
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }
    }
    
    var buttonSave: some View {
        Button("Save") {
            Task {
                let data = Person(id: person?.id, email: email, first_name: name, last_name: last_name, avatar: person?.avatar)
                try await saveHandler(data)
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    var image: some View {
        if let avatar = person?.avatar {
            AsyncImage(url: URL(string: avatar), content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
            },
                placeholder: {
                    ProgressView()
            })
        } else {
            Image("sample")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
        }
    }
    
    
    var list: some View {
        List {
            TextField("First Name", text: $name)
            TextField("Last Name", text: $last_name)
            TextField("Email", text: $email)
        }
        .listStyle(.plain)
    }
    
    init(person: Person?, saveHandler: @escaping (_ person: Person) async throws -> Void) {
        self.saveHandler = saveHandler
        self.person = person
        
        _name = State(initialValue: person?.first_name ?? "")
        _last_name = State(initialValue: person?.last_name ?? "")
        _email = State(initialValue: person?.email ?? "")
    }
}

struct PhotoPicker: View {
    @State private var pickerItem: PhotosPickerItem? = PhotosPickerItem(itemIdentifier: "String1")
    @State private var selectedImage: Image?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.gray.opacity(0.1))
                .frame(width: 150, height: 40)
            photoPicker
        }
        .scaleEffect(CGSize(width: 0.7, height: 0.7))
    }
    
    var photoPicker: some View {
        VStack {
            //selectedImage?
                //.resizable()
                //.scaledToFit()
            PhotosPicker("Select a photo", selection: $pickerItem, matching: .images)
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        ContactView(person: Binding<Person>, title: "New contact", saveHandler: {person in })
//    }
//}
