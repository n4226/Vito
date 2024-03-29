//
//  Fitbit.swift
//  Vito
//
//  Created by Andreas Ink on 3/15/22.
//

import Foundation

class Fitbit: ObservableObject {
    
    var session = URLSession.shared
    @Published var accessToken: String?
    init() {
//        Task {
//            let res = (try await authorize(Data(), to: URL(string: "https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=2389P9&redirect_uri=https%3A%2F%2Fandreasink.web.app&scope=heartrate%20sleep&expires_in=604800")!, type: "GET"))
//            print(res.1)
//            print(String(data: res.0, encoding: .utf8))
//            print(try await getHeartrate())
//           
//        }
    }
    
    func getHeartrate(start: String, end: String) async throws -> FitbitData? {
        if let accessToken = accessToken {
            
            var request = URLRequest(url: URL(string: "https://api.fitbit.com/1/user/-/activities/heart/date/\(start)/\(end).json")!)
   //
            print("ACCESS TOKEN")
            print(accessToken)
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
           // request.setValue("application/json", forHTTPHeaderField: "Accept")
        print(request)
            let res = try await session.upload(
                 for: request,
                 from: Data()
                    
             )
            print(res.1)
            let jsonDecoder = JSONDecoder()
            print(String(data: res.0, encoding: .utf8)!)
            //print(try? jsonDecoder.decode(FitbitData.self, from: res.0))
            return try jsonDecoder.decode(FitbitData.self, from: res.0)
        } else {
             //fatalError()
            return nil
        }
        //return nil
    //
    }
    func authorize(_ data: Data, to url: URL, type: String = "POST") async throws -> (Data, URLResponse)  {
        var request = URLRequest(url: url)
   //
        
        return try await session.upload(
             for: request,
             from: data
                
         )
    }

}
