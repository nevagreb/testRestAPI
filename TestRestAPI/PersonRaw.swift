//
//  PersonRaw.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import SwiftUI

struct PersonRaw: View {
    @State var person: Person
    
    var url: URL? {
        URL(string: person.avatar)
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: url, content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            },
                placeholder: {
                    ProgressView()
            })
            
            VStack(alignment: .leading) {
                Text(person.first_name + " " + person.last_name)
                    .font(.title2)
                    .bold()
                Text(person.email)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    List {
        PersonRaw(person: Person.example)
    }
}
