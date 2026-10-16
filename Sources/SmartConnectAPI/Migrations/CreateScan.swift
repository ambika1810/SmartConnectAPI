//
//  CreateScan.swift
//  SmartConnectAPI
//
//  Created by Ambika Patil on 16/10/26.
//


import Fluent

struct CreateScan: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("scans")
            .id()
            .field("scan_type", .string, .required)
            .field("device_name", .string)
            .field("rssi", .int)
            .field("tag_data", .string)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("scans").delete()
    }
}
