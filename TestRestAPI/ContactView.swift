//
//  NewContactView.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 25.03.2024.
//

import SwiftUI

struct ContactView: View {
    @Binding var person: Person
    var saveHandler: (_ person: Person) async throws -> Void
    
    var title: String {
        if let _ = person.id {
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
        if person.id == nil {
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
                try await saveHandler(person)
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    var image: some View {
        if let avatar = person.avatar {
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
            TextField("First Name", text: $person.first_name)
            TextField("Last Name", text: $person.last_name)
            TextField("Email", text: $person.email)
        }
        .listStyle(.grouped)
    }
}

//#Preview {
//    NavigationStack {
//        ContactView(person: Binding<Person>, title: "New contact", saveHandler: {person in })
//    }
//}

/*
struct ContactView: View {
    @EnvironmentObject var people: MyList
    var id: Int?
    var saveHandler: (_ person: Person) async throws -> Void
    
    var title: String {
        if let _ = id {
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
        if id == nil {
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
                let person = people.data[index(at: id)]
                try await saveHandler(person)
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    var image: some View {
        if let avatar = people.data[index(at: id)].avatar {
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
            TextField("First Name", text: $people.data[index(at: id)].first_name)
            TextField("Last Name", text: $people.data[index(at: id)].last_name)
            TextField("Email", text: $people.data[index(at: id)].last_name)
        }
        .listStyle(.grouped)
    }
    
    func index(at id: Int?) -> Int {
        people.data.firstIndex(where: {$0.id == id!})!
    }
}*/
