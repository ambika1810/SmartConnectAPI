
import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

func configure(_ app: Application) async throws {
    let databaseHost = Environment.get("DATABASE_HOST") ?? "localhost"
    let databasePort = Environment.get("DATABASE_PORT").flatMap { Int($0) }
        ?? SQLPostgresConfiguration.ianaPortNumber
    let databaseUsername = Environment.get("DATABASE_USERNAME") ?? "ambikapatil"
    let databasePassword = Environment.get("DATABASE_PASSWORD") ?? ""
    let databaseName = Environment.get("DATABASE_NAME") ?? "vapor_database"

    let postgresConfiguration = SQLPostgresConfiguration(
        hostname: databaseHost,
        port: databasePort,
        username: databaseUsername,
        password: databasePassword,
        database: databaseName,
        tls: .disable
    )

    app.databases.use(
        DatabaseConfigurationFactory.postgres(
            configuration: postgresConfiguration
        ),
        as: .psql
    )
    app.migrations.add(CreateScan())
    app.migrations.add(CreateLocationRecord())
    try await app.autoMigrate()
    try routes(app)
}
