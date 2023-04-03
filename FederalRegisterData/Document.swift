//
//  Documents.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 4/2/23.
//

import Foundation

struct Document: Codable, Identifiable {
    var id: String { document_number }
    let body_html_url: String
    let document_number: String
    let title: String
}
