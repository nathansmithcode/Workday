//
//  NetworkService.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import Foundation

class NetworkService {
    
    enum NetworkError: Error {
        case badRequest
        case notFound
        case serverError
    }
    
    static func fetchNasaData(forSearch text: String, pageNumber: String, completion: @escaping (NasaData?) -> ()) {
        guard !text.isEmpty,
              let url = URL(string: NetworkConstants.getUrlString(withSearchText: text, pageNumber: pageNumber))
        else {
            completion(nil)
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let data = data
            else {
                print(error ?? "Unknown error") // Can handle errors with NetworkError
                completion(nil)
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(NasaData.self, from: data) {
                completion(decodedResponse)
            }
          
        }
        task.resume()
        
    }
}

