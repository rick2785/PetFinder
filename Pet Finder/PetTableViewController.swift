//
//  PetTableViewController.swift
//  Pet Finder
//
//  Created by Rickey Hrabowskie on 4/28/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//


import UIKit

class PetTableViewController: UITableViewController {

  // MARK: - Properties
  let dataProvider = PetsDataProvider.sharedProvider

  // MARK; - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.rowHeight = 110

    let titleImageView = UIImageView(image: UIImage(named:"catdog"))
    titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    titleImageView.contentMode = .scaleAspectFit
    navigationItem.titleView = titleImageView

    let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
    navigationItem.rightBarButtonItem = searchButton

    let settingsButton = UIBarButtonItem(image: UIImage(named:"settings"), style: .plain, target: self, action: #selector(settings))
    navigationItem.leftBarButtonItem = settingsButton
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
      controller.delegate = self
    }
  }
}

// MARK: - Actions
private extension PetTableViewController {

  @objc func search() {
    guard let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController") else {
      return
    }

    searchViewController.modalPresentationStyle = .popover
    searchViewController.modalTransitionStyle = .coverVertical
    searchViewController.popoverPresentationController?.delegate = self
    present(searchViewController, animated: true)
  }

  @objc func settings() {
    guard let settingsViewController = storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController") else {
      return
    }

    settingsViewController.modalPresentationStyle = .popover
    settingsViewController.modalTransitionStyle = .coverVertical
    settingsViewController.popoverPresentationController?.delegate = self
    present(settingsViewController, animated: true)
  }
}

// MARK: - UITableViewDatasource
extension PetTableViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataProvider.pets.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath)
    let pet = dataProvider.pets[indexPath.row]
    cell.imageView?.image = UIImage(named: pet.imageName)
    cell.imageView?.layer.masksToBounds = true
    cell.imageView?.layer.cornerRadius = 5

    cell.detailTextLabel?.text = dataProvider.pets[indexPath.row].type

    cell.textLabel?.text = dataProvider.pets[indexPath.row].name

    return cell
  }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension PetTableViewController: UIPopoverPresentationControllerDelegate {

  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.overCurrentContext
  }

  func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    return UINavigationController(rootViewController: controller.presentedViewController)
  }
}

// MARK: - PetViewControllerDelegate
extension PetTableViewController: PetViewControllerDelegate {

  func petViewController(_ controller: PetViewController, didAdoptPet pet: Pet) {
    dataProvider.adopt(pet: pet)
  }
}
