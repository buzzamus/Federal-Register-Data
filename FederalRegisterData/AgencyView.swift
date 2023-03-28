//
//  AgencyView.swft.swift
//  FederalAgencies
//
//  Created by Brent Busby on 3/22/23.
//

import SwiftUI

struct AgencyView: View {
    let agency: Agency
    var body: some View {
        ScrollView {
            Text(agency.name)
            Text(agency.description ?? "No Info Available")
            Link(" \(agency.name) Federal Register Web Page", destination: URL(string: agency.url)!)
            
            if (agency.agency_url != nil) {
                Divider()
                Link("\(agency.name)'s website", destination: URL(string: agency.agency_url!)!)
            }
        }
    }
}

struct AgencyView_Previews: PreviewProvider {
    static var previews: some View {
        let testAgency = Agency(agency_url: "www.myURL.com", description: "Test Description of a completely fake Agency. They started in 1998 to cut down on fake agencies", id: 2, name: "Fake Agency", slug: "fake-Agency", url: "fake-agency.gov.uk")
        AgencyView(agency: testAgency)
    }
}
