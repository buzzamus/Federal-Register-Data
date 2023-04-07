//
//  AgencyView.swft.swift
//  FederalAgencies
//
//  Created by Brent Busby on 3/22/23.
//

import SwiftUI

struct AgencyView: View {
    let agency: Agency
    @State var documents = [Document]()
    @State var connectionError = false
    @State var requestInProgress = false
    var body: some View {
        ScrollView {
            Text(agency.name)
            Divider()
            Text(agency.description ?? "No Info Available")
            Divider()
            Group {
                Link("Federal Register Web Page", destination: URL(string: agency.url)!)
                    .padding(.vertical, 5)
                
            }
            Divider()
            Text("Latest published articles")
                .font(.title)
            Divider()
            if (requestInProgress) {
                ProgressView("Retrieving Data...")
                ProgressView()
            }
            DocumentsView(documents: documents)
        }
        .padding(.horizontal, 5)
        .onAppear {
            requestInProgress = true
            let url = URL(string: APIRequestsAgent.latestArticlesEndpoint + agency.slug)!
            APIRequestsAgent.makeAPICall(url: url) { (result: Result<DocumentResult, Error>) in
                switch result {
                case .success(let fetchedDocuments):
                    documents = fetchedDocuments.results
                    requestInProgress = false
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    connectionError = true
                    requestInProgress = false
                }
            }
        }
    }
}

struct AgencyView_Previews: PreviewProvider {
    static var previews: some View {
        let testAgency = Agency(agency_url: "www.myURL.com", description: "Test Description of a completely fake Agency. They started in 1998 to cut down on fake agencies", id: 2, name: "Fake Agency", slug: "agriculture-department", url: "fake-agency.gov.uk")
        AgencyView(agency: testAgency)
    }
}
