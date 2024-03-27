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
    @Published var newPerson: Person
    
    var url: URL? {
        URL(string: myUrl)
    }
    
    init() {
        data = []
        newPerson = Person()
    }
    
    @MainActor
    func loadData() async throws {
        if let url {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                if let lists = try? JSONDecoder().decode([Person].self, from: data) {
                        self.data = lists
                } else {
                    print("Invalid response")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
            
//another way to load data
    /*func loadData() async throws {
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
    }*/
    
    func addContact(_ person: Person) async throws {
        if let url {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            
            if let data = try? JSONEncoder().encode(person) {
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
    
    func editContact(_ person: Person) async throws {
        if let id = person.id {
            let urlPut = URL(string: myUrl + "/\(id)")
            if let urlPut {
                var request = URLRequest(url: urlPut)
                request.httpMethod = "PUT"
                request.setValue(
                    "application/json",
                    forHTTPHeaderField: "Content-Type"
                )
                
                if let data = try? JSONEncoder().encode(person) {
                    request.httpBody = data
                    //print(String(data: data, encoding: .utf8))
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

