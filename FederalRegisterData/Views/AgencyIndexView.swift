//
//  AgencyIndexView.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 4/6/23.
//

import SwiftUI

struct AgencyIndexView: View {
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    let errorView = ErrorView(errorMessage: APIRequestsAgent.failedNetworkRequestText)
    @State var agencies = [Agency]()
    @State var connectionError = false
    @State var requestInProgress = true
    var body: some View {
        Text("All Agencies").font(.title)
        ScrollView {
            LazyVGrid(columns: columns) {
                if (self.connectionError) {
                    errorView.body
                }
                
                if (requestInProgress) {
                    ProgressView("Retrieving Data...")
                    ProgressView()
                }
                ForEach(agencies) { agency in
                    NavigationLink {
                        AgencyView(agency: agency)
                    } label: {
                        VStack {
                            Text(agency.name)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .fontDesign(.monospaced)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            requestInProgress = true
            let url = URL(string: APIRequestsAgent.agenciesEndpoint)!
            APIRequestsAgent.makeAPICall(url: url) { (result: Result<[Agency], Error>) in
                switch result {
                case .success(let fetchedAgencies):
                    agencies = fetchedAgencies
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

struct AgencyIndexView_Previews: PreviewProvider {
    static var previews: some View {
        AgencyIndexView()
    }
}
