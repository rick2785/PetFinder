//
//  PetsDataProvider.swift
//  Pet Finder
//
//  Created by Rickey Hrabowskie on 4/28/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//


import Foundation

class PetsDataProvider {

  // MARK: - Properties
  static let sharedProvider = PetsDataProvider()
  
  let pets: [Pet]
  private(set) var adoptedPets: [Pet] = []

  // MARK: - Initializers
  init() {
    self.pets = [Pet(name: "Rusty", type: "Golden Retriever", imageName: "pet0"),
                 Pet(name: "Max", type: "Mixed Terrier", imageName: "pet1"),
                 Pet(name: "Lucifer", type: "Freaked Out", imageName: "pet2"),
                 Pet(name: "Tiger", type: "Sensitive Whiskers", imageName: "pet3"),
                 Pet(name: "Widget", type: "Mouse Catcher", imageName: "pet4"),
                 Pet(name: "Wiggles", type: "Border Collie", imageName: "pet5"),
                 Pet(name: "Clover", type: "Mixed Breed", imageName: "pet6"),
                 Pet(name: "Snow White", type: "Black Cat", imageName: "pet7")]
  }

  // MARK: - Internal
  func adopt(pet: Pet) {
    if !adoptedPets.contains(pet) {
      adoptedPets.append(pet)
    }
  }
}
