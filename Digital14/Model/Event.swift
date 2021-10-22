//
//  Event.swift
//  Digital14
//
//  Created by Narendra on 20/10/21.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let events: [Event]
    let meta: Meta
}

// MARK: - Event
struct Event: Codable {
    let type: String
    let id: Int
    let datetimeUTC: String
    let venue: Venue
    let datetimeTbd: Bool
    let performers: [Performer]
    let isOpen: Bool
    let datetimeLocal: String
    let timeTbd: Bool
    let shortTitle, visibleUntilUTC: String
    let url: String
    let score: Double
    let announceDate: String
    let createdAt: String
    let dateTbd: Bool
    let title: String
    let popularity: Double
    let eventDescription: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case datetimeUTC = "datetime_utc"
        case venue
        case datetimeTbd = "datetime_tbd"
        case performers
        case isOpen = "is_open"
        case datetimeLocal = "datetime_local"
        case timeTbd = "time_tbd"
        case shortTitle = "short_title"
        case visibleUntilUTC = "visible_until_utc"
        case url, score
        case announceDate = "announce_date"
        case createdAt = "created_at"
        case dateTbd = "date_tbd"
        case title, popularity
        case eventDescription = "description"
        case status
    }
}

// MARK: - Performer
struct Performer: Codable {
    let type: String
    let name: String
    let image: String
    let id: Int
    let images: Images
    let hasUpcomingEvents: Bool
    let primary: Bool?
    let imageAttribution: String
    let url: String
    let score: Double
    let slug: String
    let homeVenueID: Int
    let shortName: String
    let numUpcomingEvents: Int
    let imageLicense: String
    let popularity: Int
    let homeTeam: Bool?
    let location: Location
    let awayTeam: Bool?

    enum CodingKeys: String, CodingKey {
        case type, name, image, id, images
        case hasUpcomingEvents = "has_upcoming_events"
        case primary
        case imageAttribution = "image_attribution"
        case url, score, slug
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case imageLicense = "image_license"
        case popularity
        case homeTeam = "home_team"
        case location
        case awayTeam = "away_team"
    }
}

// MARK: - Images
struct Images: Codable {
    let huge: String
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double
}

// MARK: - Venue
struct Venue: Codable {
    let state: String
    let nameV2, postalCode, name: String
    let timezone: String
    let url: String
    let score: Double
    let location: Location
    let address: String
    let country: String
    let hasUpcomingEvents: Bool
    let numUpcomingEvents: Int
    let city, slug, extendedAddress: String
    let id, popularity: Int
    let metroCode, capacity: Int
    let displayLocation: String

    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, timezone, url, score, location, address, country
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case id, popularity
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let total, took, page, perPage: Int
    enum CodingKeys: String, CodingKey {
        case total, took, page
        case perPage = "per_page"
    }
}
