//
//  LocationRecord.swift
//  SmartConnectAPI
//
//  Created by Ambika Patil on 16/10/26.
//


import Fluent
import Vapor

final class LocationRecord: Model, Content, @unchecked Sendable {
    static let schema = "location_records"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "latitude")
    var latitude: Double

    @Field(key: "longitude")
    var longitude: Double

    @OptionalField(key: "accuracy")
    var accuracy: Double?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        latitude: Double,
        longitude: Double,
        accuracy: Double? = nil
    ) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.accuracy = accuracy
    }
}
