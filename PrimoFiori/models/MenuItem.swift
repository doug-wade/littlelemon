//
//  MenuItem.swift
//  PrimoFiori
//
//  Created by Doug Wade on 2/29/24.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id = UUID()

    let title: String
    let price: String
    let image: String
}
