//
//  PersonRaw.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import SwiftUI

struct PersonRaw: View {
    @State var person: Person
    
    var body: some View {
        HStack {
           photo
            
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
    
    @ViewBuilder
    var photo: some View {
        if let avatar = person.avatar {
            AsyncImage(url: URL(string: avatar), content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            },
                placeholder: {
                    ProgressView()
            })
        } else {
            Image("sample")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .background(Circle().fill(.gray).frame(width: 51, height: 51))
        }
    }
}

#Preview {
    List {
        PersonRaw(person: Person.example)
    }
}
