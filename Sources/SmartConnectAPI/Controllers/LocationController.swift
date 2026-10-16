//
//  LocationController.swift
//  SmartConnectAPI
//
//  Created by Ambika Patil on 16/10/26.
//


import Fluent
import Vapor

struct CreateLocationRequest: Content {
    let latitude: Double
    let longitude: Double
    let accuracy: Double?
}

struct LocationController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let locations = routes.grouped("api", "locations")

        // GET /api/locations
        locations.get { req async throws -> [LocationRecord] in
            try await LocationRecord.query(on: req.db)
                .sort(\.$createdAt, .descending)
                .all()
        }

        // POST /api/locations
        locations.post { req async throws -> LocationRecord in
            let input = try req.content.decode(CreateLocationRequest.self)

            guard (-90...90).contains(input.latitude),
                  (-180...180).contains(input.longitude) else {
                throw Abort(.badRequest, reason: "Invalid latitude or longitude.")
            }

            let record = LocationRecord(
                latitude: input.latitude,
                longitude: input.longitude,
                accuracy: input.accuracy
            )

            try await record.save(on: req.db)
            return record
        }
    }
}
