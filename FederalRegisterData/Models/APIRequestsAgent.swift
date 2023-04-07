//
//  Configuration.swift
//  FederalAgencies
//
//  Created by Brent Busby on 3/23/23.
//

import Foundation

struct APIRequestsAgent {
    static let agenciesEndpoint = "https://www.federalregister.gov/api/v1/agencies/"
    static let latestArticlesEndpoint = "https://www.federalregister.gov/api/v1/documents.json?fields[]=body_html_url&fields[]=document_number&fields[]=title&per_page=20&order=newest&conditions[agencies][]="
    static let homePageArticles = "https://www.federalregister.gov/api/v1/documents.json?fields[]=body_html_url&fields[]=document_number&fields[]=title&per_page=20&order=newest"
    
    static let failedNetworkRequestText = "There was an error retrieving the requested data.\n Either the service is down, or you are not connected to wifi or a mobile network.\n Try again later."
    
    static func makeAPICall<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
