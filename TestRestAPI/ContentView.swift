//
//  ContentView.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var people = MyList()
    @State private var isShowingSheet = false
    @State private var newPerson = Person()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(people.data, id: \.self) { person in
                    PersonRaw(person: person)
                }
                .onDelete(perform: delele)
            }
            .listStyle(.grouped)
            .navigationTitle("My contacts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingSheet.toggle()
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
        .sheet(isPresented: $isShowingSheet) {
            NewContactView()
                .environmentObject(people)
        }
    }
    
    func delele(at indexSet: IndexSet) {
        for i in indexSet.makeIterator() {
            let item = people.data[i]
            Task {
                try await people.delete(id: item.id)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MyList())
}
