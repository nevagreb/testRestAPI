//
//  ViewModel.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import Foundation

class MyList: ObservableObject {
    @Published var data: [Person]
//    let url = "https://reqres.in/api/users"
//    let url1 = "https://reqres.in/api/users?page=2"
    let myUrl = "http://localhost:3000/url"
    
    init() {
        data = []
    }
    
    func loadData() async throws {
        if let url = URL(string: myUrl) {
            var request = URLRequest(url: url)
    
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let lists = try? JSONDecoder().decode([Person].self, from: data) {
                        self.data = lists
                    } else {
                        print("Invalid response")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                }
                
            }
            task.resume()
        }
            
    }
}
