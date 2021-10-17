//
//  NetworkService.swift
//  ClearScoreTask
//
//  Created by Daniel Rybak on 10/10/2021.
//

import Foundation

protocol NetworkServiceProtocol {
  func performNetworkCall<T: Codable>(urlString: String, objectType: T.Type) async -> T?
}

class NetworkService: NetworkServiceProtocol {
  
  func performNetworkCall<T: Codable>(urlString: String, objectType: T.Type) async -> T? {
    
    guard let url = URL(string: urlString) else {
      print("Invalid URL: \(urlString)")
      return nil
    }
    
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      
      if let response = response as? HTTPURLResponse {
        if response.statusCode != 200 {
          return nil
        }
      }
      
      let decodedResponse = try JSONDecoder().decode(T.self, from: data)
      return decodedResponse
      
    } catch let DecodingError.dataCorrupted(context) {
      print(context.codingPath)
      return nil
      
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
      
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
      
    } catch let DecodingError.typeMismatch(type, context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return nil
      
    } catch {
      print("error: ", error)
      return nil
    }
  }
}
