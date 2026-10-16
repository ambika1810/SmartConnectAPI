//
//  Scan.swift
//  SmartConnectAPI
//
//  Created by Ambika Patil on 16/10/26.
//


import Fluent
import Vapor

final class Scan: Model, Content, @unchecked Sendable {
    static let schema = "scans"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "scan_type")
    var scanType: String

    @OptionalField(key: "device_name")
    var deviceName: String?

    @OptionalField(key: "rssi")
    var rssi: Int?

    @OptionalField(key: "tag_data")
    var tagData: String?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        scanType: String,
        deviceName: String? = nil,
        rssi: Int? = nil,
        tagData: String? = nil
    ) {
        self.id = id
        self.scanType = scanType
        self.deviceName = deviceName
        self.rssi = rssi
        self.tagData = tagData
    }
}
