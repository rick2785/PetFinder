//
//  Pet.swift
//  Pet Finder
//
//  Created by Rickey Hrabowskie on 4/28/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import Foundation

struct Pet {
  let name: String
  let type: String
  let imageName: String
}

// MARK: - Equatable
extension Pet: Equatable {

  static func == (lhs: Pet, rhs: Pet) -> Bool {
    return lhs.name == rhs.name && lhs.type == rhs.type
  }
}
