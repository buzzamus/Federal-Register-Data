//
//  Agency.swift
//  FederalAgencies
//
//  Created by Brent Busby on 3/22/23.
//

import Foundation

struct Agency: Codable, Identifiable {
    let agency_url: String?
    let description: String?
    let id: Int
    let name: String
    let slug: String
    let url: String
    
    init(agency_url: String?, description: String?, id: Int, name: String, slug: String, url: String) {
        self.agency_url = agency_url ?? "N/A"
        self.description = description ?? "N/A"
        self.id = id
        self.name = name
        self.slug = slug
        self.url = url
    }
}
