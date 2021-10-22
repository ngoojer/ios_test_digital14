//
//  EventService.swift
//  Digital14
//
//  Created by Narendra Goojer on 20/10/21.
//

import Foundation
import Combine

protocol SeatGeekServiceProtocol {
    var apiSession: APIServiceProtocol { get }
    func fetchEvents(for searchString: String) -> AnyPublisher<Response, Error>
}

extension SeatGeekServiceProtocol {
    func fetchEvents(for searchString: String) -> AnyPublisher<Response, Error> {
        let endpoint = Endpoint.searchEvents(query: searchString)
        return apiSession
            .get(type: Response.self, url: endpoint.url, header: endpoint.headers)
    }
}
