//
//  ContentView.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var people = MyList()
    @State private var showNewContactView = false
    
    var body: some View {
        NavigationStack {
            List{
                contactList
            }
            .listStyle(.grouped)
            .navigationTitle("My contacts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        people.newPerson.clearData()
                        showNewContactView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await people.loadData()
            }
        }
        .sheet(isPresented: $showNewContactView) {
            ContactView(person: $people.newPerson, saveHandler: people.addContact)
        }
        
    }
    
    var contactList: some View {
        ForEach(people.data, id: \.self) { person in
            NavigationLink(destination: ContactView(person: $people.data[index(of: person.id)], saveHandler: people.editContact)) {
                PersonRaw(person: person)
            }
        }
        .onDelete(perform: delele)
    }
    
    func index(of id: Int?) -> Int {
        people.data.indices.first {people.data[$0].id == id} ?? 0
    }
    
    func delele(at indexSet: IndexSet) {
        for i in indexSet.makeIterator() {
            let item = people.data[i]
            Task {
                try await people.delete(id: item.id!)
            }
        }
    }
}

#Preview {
    ContentView()
}

/*
struct ContentView: View {
    @StateObject var people = MyList()
    @State private var showNewContactView = false
    
    var body: some View {
        NavigationStack {
            List{
                contactList
            }
            .listStyle(.grouped)
            .navigationTitle("My contacts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //people.newPerson.clearData()
                        showNewContactView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .environmentObject(people)
        .onAppear {
            Task {
                try await people.loadData()
            }
        }
        .sheet(isPresented: $showNewContactView) {
            //ContactView(person: $people.newPerson, saveHandler: people.addContact)
        }
        
    }
    
    var contactList: some View {
        ForEach(people.data, id: \.self) { person in
            NavigationLink(destination: ContactView(id: person.id, saveHandler: people.editContact)) {
                PersonRaw(person: person)
            }
        }
        .onDelete(perform: delele)
    }
    
    func index(of id: Int?) -> Int {
        people.data.indices.first {people.data[$0].id == id} ?? 0
    }
    
    func delele(at indexSet: IndexSet) {
        for i in indexSet.makeIterator() {
            let item = people.data[i]
            Task {
                try await people.delete(id: item.id!)
            }
        }
    }
}

#Preview {
    ContentView()
}*/
