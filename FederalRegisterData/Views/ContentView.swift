//
//  ContentView.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    @State var documents = [Document]()
    @State var connectionError = false
    @State var requestInProgress = true
    let errorView = ErrorView(errorMessage: APIRequestsAgent.failedNetworkRequestText)
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    VStack {
                        NavigationLink {
                            AgencyIndexView()
                        } label: {
                            Text("View all Agencies")
                        }
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                        Spacer()
                        Text("Latest Federal Register Articles")
                            .font(.body)
                        
                        if (self.connectionError) {
                            errorView.body
                        }
                        
                        if (requestInProgress) {
                            ProgressView("Retrieving Data...")
                            ProgressView()
                        }
                        DocumentsView(documents: documents)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    .navigationTitle("Federal Register Data").font(.title)
                }
            }
            .onAppear {
                requestInProgress = true
                let url = URL(string: APIRequestsAgent.homePageArticles)!
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
