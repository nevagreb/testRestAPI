//
//  ContentView.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var people = MyList()
    
    var body: some View {
        NavigationStack {
            List(people.data, id: \.self) {person in
                    PersonRaw(person: person)
            }
            .listStyle(.grouped)
            
            Button("Load Data") {
                Task {
                    try await people.loadData()
                }
            }
            .navigationTitle("My contacts")
        }
    }
}

#Preview {
    ContentView()
}
