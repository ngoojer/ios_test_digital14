//
//  EndPoints.swift
//  Digital14
//
//  Created by Narendra Goojer on 20/10/21.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.seatgeek.com"
        components.path = "/2" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }

    var headers: Header {
        let authData = Constants.clientID.data(using: .utf8)!.base64EncodedString()
        let basicAuth = "Basic \(authData)"
        return ["Authorization": basicAuth]
    }
}

extension Endpoint {
    static func searchEvents(query: String) -> Self {
        return Endpoint(path: "/events",
                        queryItems: [
                            URLQueryItem(name: "q",
                                         value: "\(query)")
            ]
        )
    }
}

