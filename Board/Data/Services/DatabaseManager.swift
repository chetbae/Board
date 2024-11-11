//
//  DatabaseError.swift
//  Board
//
//  Created by max on 2024-11-10.
//

import Foundation
import SQLite
import OSLog

enum DatabaseError: Error {
    case databaseNotFound
    case copyFailed
    case validationFailed(String)
}

class DatabaseManager {
    static let shared = DatabaseManager()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Database")
    
    private let fileManager = FileManager.default
    
    private var documentsURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var dbURL: URL {
        documentsURL.appendingPathComponent("kilter.db")
    }
    
    func initializeDatabase() throws {
        logger.info("Initializing database...")
        
        if fileManager.fileExists(atPath: dbURL.path) {
            logger.info("Database already exists at: \(self.dbURL.path)")
        } else {
            logger.info("Database not found, copying from bundle...")
            guard let bundleDB = Bundle.main.url(forResource: "kilter", withExtension: "db") else {
                logger.error("Failed to find database in bundle")
                throw DatabaseError.databaseNotFound
            }
            
            do {
                try fileManager.copyItem(at: bundleDB, to: dbURL)
                logger.info("Successfully copied database to: \(self.dbURL.path)")
            } catch {
                logger.error("Failed to copy database: \(error.localizedDescription)")
                throw DatabaseError.copyFailed
            }
        }
        
        // Verify database
        try validateDatabase()
    }
    
    private func validateDatabase() throws {
        logger.info("Validating database schema...")
        
        do {
            let db = try Connection(dbURL.path)
            
            // Check required tables
            let requiredTables = ["climbs", "climb_cache_fields"]
            let tableQuery = "SELECT name FROM sqlite_master WHERE type='table'"
            
            let existingTables = try db.prepare(tableQuery).map { row in
                row[0] as? String ?? ""
            }
            
            logger.info("Found tables: \(existingTables.joined(separator: ", "))")
            
            for table in requiredTables {
                if !existingTables.contains(table) {
                    logger.error("Missing required table: \(table)")
                    throw DatabaseError.validationFailed("Missing required table: \(table)")
                }
            }
            
            // Verify climbs table schema
            let climbsColumns = try db.prepare("PRAGMA table_info(climbs)").map { row in
                row[1] as? String ?? ""
            }
            
            let requiredColumns = ["uuid", "name", "setter_username", "created_at", "frames", "angle"]
            for column in requiredColumns {
                if !climbsColumns.contains(column) {
                    logger.error("Missing required column in climbs table: \(column)")
                    throw DatabaseError.validationFailed("Missing required column: \(column)")
                }
            }
            
            logger.info("Database validation successful")
            
            // Log some basic stats
            if let climbCount = try db.scalar("SELECT COUNT(*) FROM climbs") as? Int64 {
                logger.info("Total climbs in database: \(climbCount)")
            }
            
        } catch {
            logger.error("Database validation failed: \(error.localizedDescription)")
            throw error
        }
    }
}
