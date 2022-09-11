//
//  WebService.swift
//  CryptoCrazySUI
//
//  Created by Alperen Kavuk on 11.09.2022.
//

import Foundation
class Webservice {
   
    func downloadCurrenciesAsync(url : URL) async throws-> [CryptoCurrency]{
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
    return currencies ?? []
    }
    /*
    func downloadCurrencies(url : URL, completion : @escaping (Result<[CryptoCurrency]?,DownloadEror>) -> Void ){
        
        URLSession.shared.dataTask(with: url) { data, response, eror in
            if let eror = eror{
                print(eror)
                completion(.failure(.badURL))
            }
            guard let data = data , eror == nil else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseEror))
            }
            completion(.success(currencies))
     }     }.resume()
}*/
}
enum DownloadEror : Error {
    case badURL
    case noData
    case dataParseEror
}

