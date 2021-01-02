//
//  File.swift
//  WhitehousePetitions
//
//  Created by Hai Nguyen on 2/1/21.
//

import Foundation

struct Petition: Codable {
    let id: String
    let title: String
    let body: String
    let signatureCount: Int    
}
