//
//  Route.swift
//  Board
//
//  Created by max on 2024-11-09.
//

import Foundation

struct Route: Identifiable {
    let id: String
    let name: String
    let grade: String
    let setter: String
    let holdSequence: HoldSequence
    let metadata: RouteMetadata
}

struct HoldSequence {
    let startHolds: [Hold]
    let handHolds: [Hold]
    let footHolds: [Hold]
    let topHolds: [Hold]
}

struct Hold: Identifiable {
    let id: String
    let x: Int
    let y: Int
}

struct RouteMetadata {
    let dateSet: Date
    let ascentCount: Int
    let averageRating: Double?
    let userRating: Double?
    let userAscent: Bool
}
