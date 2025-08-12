//
//  Prophet.swift
//  ICSCon2025_withSwiftDataAndTesting
//
//  Created by Steve Spigarelli on 8/12/25.
//

import Foundation
import SwiftData

@Model
final class Prophet {
    var name: String
    var born: Date
    var died: Date?
    var apostleCalled: Date?
    var prophetCalled: Date
    var imageUrl: URL?
    var notableQuotes: [String]

    init(name: String, born: Date, died: Date? = nil, apostleCalled: Date? = nil, prophetCalled: Date, imageUrl: String, notableQuotes: [String] = []) {
        self.name = name
        self.born = born
        self.died = died
        self.apostleCalled = apostleCalled
        self.prophetCalled = prophetCalled
        self.imageUrl = URL(string: imageUrl)
        self.notableQuotes = notableQuotes
    }
}