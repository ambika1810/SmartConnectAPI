//
//  CreateLocationRecord.swift
//  SmartConnectAPI
//
//  Created by Ambika Patil on 16/10/26.
//


import Fluent

struct CreateLocationRecord: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("location_records")
            .id()
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .field("accuracy", .double)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("location_records").delete()
    }
}
