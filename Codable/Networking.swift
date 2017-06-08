//
//  Networking.swift
//  Codable
//
//  Created by Eli Slade on 2017-06-08.
//  Copyright © 2017 Eli Slade. All rights reserved.
//

import Foundation

struct API {
    let url:URL
    let session:URLSession
    let decoder = JSONDecoder()
    
    static let shared = API()
    
    init(){
        session = URLSession.shared
        url = URL(string: "https://jsonplaceholder.typicode.com")!
    }
}

protocol APIListable: Decodable {
    static var endpoint: String {get}
    static func list(completion:(([Self]?) -> Void)?)
}

extension APIListable {
    static func list(completion:(([Self]?) -> Void)?) {
        let request = URLRequest(url: API.shared.url.appendingPathComponent(endpoint))
        let task = API.shared.session.dataTask(with: request, completionHandler: { (data, res, error) in
            if let data = data {
                do {
                    let data = try API.shared.decoder.decode([Self].self, from: data)
                    completion?(data)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                // data is nil
                if let error = error {
                   print("Error", error)
                } else {
                    // no data, no error
                    if let res = res {
                        print("Response", res)
                    } else {
                        // All the args in the callback are nil
                        print("Data, response, and error were all nil in the DataTask completion.")
                    }
                }
            }
        })
        task.resume()
    }
}
