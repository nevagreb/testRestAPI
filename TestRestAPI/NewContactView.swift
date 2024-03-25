//
//  NewContactView.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 25.03.2024.
//

import SwiftUI

struct NewContactView: View {
    @EnvironmentObject var people: MyList
    
    @State private var name: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                image
                
                list
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    buttonSave
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var buttonSave: some View {
        Button("Save") {
            Task {
                try await people.addContact(email: email, first_name: name, last_name: lastName)
                dismiss()
            }
        }
    }
    
    var image: some View {
        Image("sample")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 150, height: 150)
    }
    
    var list: some View {
        List {
            TextField("First Name", text: $name)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
        }
        .listStyle(.grouped)
    }
}

//#Preview {
//    NavigationStack {
//        NewContactView()
//    }
//}
