

import Fluent
import Vapor

struct CreateScanRequest: Content {
    let scanType: String
    let deviceName: String?
    let rssi: Int?
    let tagData: String?
}

struct ScanController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let scans = routes.grouped("api", "scans")

        // GET /api/scans — retrieve saved scans
        scans.get { req async throws -> [Scan] in
            try await Scan.query(on: req.db)
                .sort(\.$createdAt, .descending)
                .all()
        }

        // POST /api/scans — save a new scan
        scans.post { req async throws -> Scan in
            let input = try req.content.decode(CreateScanRequest.self)

            let scan = Scan(
                scanType: input.scanType,
                deviceName: input.deviceName,
                rssi: input.rssi,
                tagData: input.tagData
            )

            try await scan.save(on: req.db)
            return scan
        }
    }
}
