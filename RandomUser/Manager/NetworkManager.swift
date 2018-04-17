//
//  NetworkManager.swift
//  RandomUser
//
//  Created by San on 16.04.18.
//  Copyright © 2018 San. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    let defaultSession = URLSession(configuration: .default)
    var errorMessage = ""
    
    typealias JSONDictionary = [String: Any]
    
    func getUser(completion: @escaping ([UserModel]) -> Void) {
        let url = URL(string: "https://randomuser.me/api?results=20")! //&callback=randomuserdata
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateSearchResults(data, success: { (users) in
                    completion(users)
                })
                //self.updateSearchResults(data)
//                let str = NSString(data:unwrappedData, encoding: String.Encoding.utf8.rawValue) //try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments)
//                print(str!)
            }
        }
        task.resume()
    }

    fileprivate func updateSearchResults(_ data: Data, success: ([UserModel]) -> Void) {
        var response: JSONDictionary?
        var users: [UserModel] = []
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }

        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary {
                
                let user = UserModel().parseDictionary(dict: trackDictionary)
                users.append(user)

            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
        success(users)
    }
    
    func loadImage(imageUrlString: String, completion: @escaping (UIImage) -> Void) {
        
        let imageUrl:URL = URL(string: imageUrlString)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let image = UIImage(data: imageData as Data)
            
            if let image = image {
                completion(image)
            }
        }
        
    }
}
