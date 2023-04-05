//
//  Configuration.swift
//  FederalAgencies
//
//  Created by Brent Busby on 3/23/23.
//

import Foundation

struct Configuration {
    static let agenciesEndpoint = "https://www.federalregister.gov/api/v1/agencies/"
    static let latestArticlesEndpoint = "https://www.federalregister.gov/api/v1/documents.json?fields[]=body_html_url&fields[]=document_number&fields[]=title&per_page=10&conditions[agencies][]="
    static let failedNetworkRequestText = "There was an error retrieving the requested data.\n Either the service is down, or you are not connected to wifi or a mobile network.\n Try again later."
}

// make call on AgencyView to latestArticlesEndpoint with agency-slug at end
// then, for each create link to article to link to for browser view
