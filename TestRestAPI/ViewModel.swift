//
//  ViewModel.swift
//  TestRestAPI
//
//  Created by Kristina Grebneva on 24.03.2024.
//

import Foundation


let myUrl = "http://localhost:3000/url"

class MyList: ObservableObject {
    @Published var data: [Person]
    
    var url: URL? {
        URL(string: myUrl)
    }
    
    init() {
        data = []
    }
    
    func loadData() async throws {
        if let url {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let lists = try? JSONDecoder().decode([Person].self, from: data) {
                        DispatchQueue.main.async {
                            self.data = lists
                        }
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
    
    func addContact(email: String, first_name: String, last_name: String) async throws {
        if let url {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            
            let contact = Person(email: email, first_name: first_name, last_name: last_name, avatar: "")
            if let data = try? JSONEncoder().encode(contact) {
                request.httpBody = data
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print(statusCode)
                    if statusCode == 200 {
                        print("SUCCESS")
                        if let data = data {
                            if let lists = try? JSONDecoder().decode([Person].self, from: data) {
                                DispatchQueue.main.async {
                                    self.data = lists
                                }
                            } else {
                                print("Invalid response")
                            }
                        }
                    } else {
                        print("FAILURE")
                    }
                }
                
                task.resume()
            }
        }
    }
    
    func delete(id: Int) async throws {
        let urlDelele = URL(string: myUrl + "/\(id)")
        if let urlDelele {
            var request = URLRequest(url: urlDelele)
            request.httpMethod = "DELETE"
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                print(statusCode)
                if statusCode == 200 {
                    print("SUCCESS")
                    if let data = data {
                        if let lists = try? JSONDecoder().decode([Person].self, from: data) {
                            DispatchQueue.main.async {
                                self.data = lists
                            }
                        } else {
                            print("Invalid response")
                        }
                    }
                } else {
                    print("FAILURE")
                }
            }
            
            task.resume()
            
        } else {
            print("URL is not correct")
        }
        
    }
}

