//
//  AgencyView.swft.swift
//  FederalAgencies
//
//  Created by Brent Busby on 3/22/23.
//

import SwiftUI

struct AgencyView: View {
    let agency: Agency
    let errorView = ErrorView(errorMessage: "The agency information could not be retrieved at this time.\n Either the service is down, or you are not connected to wifi or a mobile network.\n Try again later.")
    @State var documents = [Document]()
    @State var connectionError = false
    var body: some View {
        ScrollView {
            Text(agency.name)
                .font(.title)
            Divider()
            Text(agency.description ?? "No Info Available")
            Divider()
            Link("\(agency.name) Federal Register Web Page", destination: URL(string: agency.url)!)
            
            Divider()
            Text("Latest published articles")
                .font(.title)
            Divider()
            if (documents.isEmpty) {
                errorView.body
            }
            ForEach(documents) { document in
                Text(document.title)
                Link("Read Full Article", destination: URL(string: document.body_html_url)!)
                Divider()
            }
        }
        .task {
            await retrieveData()
        }
    }
    
    //Todo: too much in common with ContentView retrieveData method.
    // Make a separate method in a shared location that handles differences
    func retrieveData() async {
        let fullDocumentsUrl = Configuration.latestArticlesEndpoint + agency.slug
        guard let url = URL(string: fullDocumentsUrl) else {
            fatalError("Invalid Federal Register Documents Endpoint")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let agencyData = try? JSONDecoder().decode(DocumentResult.self, from: data) {
                documents = agencyData.results
            }
        } catch {
            print("Error Retrieving Data")
            connectionError = true
        }
    }
}

struct AgencyView_Previews: PreviewProvider {
    static var previews: some View {
        let testAgency = Agency(agency_url: "www.myURL.com", description: "Test Description of a completely fake Agency. They started in 1998 to cut down on fake agencies", id: 2, name: "Fake Agency", slug: "agriculture-department", url: "fake-agency.gov.uk")
        AgencyView(agency: testAgency)
    }
}
