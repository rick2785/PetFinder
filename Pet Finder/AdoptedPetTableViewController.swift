//
//  AdoptedPetTableViewController.swift
//  Pet Finder
//
//  Created by Rickey Hrabowskie on 4/28/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class AdoptedPetTableViewController: UITableViewController {

  // MARK: - Properties
  let dataProvider = PetsDataProvider.sharedProvider

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.rowHeight = 110
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    tableView.reloadData()
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowPet",
      let controller = segue.destination as? PetViewController,
      let tableViewCell = sender as? UITableViewCell,
      let selectedPetIndex = tableView.indexPath(for: tableViewCell)?.row {
        let pet = dataProvider.pets[selectedPetIndex]
        controller.pet = pet
    }
  }
}

// MARK: - UITableViewDatasource
extension AdoptedPetTableViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataProvider.adoptedPets.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritePetCell", for: indexPath)
    let pet = dataProvider.adoptedPets[indexPath.row]
    cell.imageView?.image = UIImage(named: pet.imageName)
    cell.imageView?.layer.masksToBounds = true
    cell.imageView?.layer.cornerRadius = 5

    cell.detailTextLabel?.text = dataProvider.adoptedPets[indexPath.row].type

    cell.textLabel?.text = dataProvider.adoptedPets[indexPath.row].name

    return cell
  }
}
