//
//  Board.swift
//  Board
//
//  Created by max on 2024-11-09.
//

enum BoardType: String, Codable {
    case kilter
    case moon
    case tension
}

struct BoardConfiguration {
    let width: Int
    let height: Int
    let angleOptions: [Int]
    let defaultAngle: Int
}
