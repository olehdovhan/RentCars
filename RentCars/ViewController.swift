//
//  ViewController.swift
//  RentCars
//
//  Created by Oleh Dovhan on 09.06.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
  var car: RentedCar!
  lazy var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .short
    df.timeStyle = .none
    return df
  }()
  @IBOutlet var markLabel: UILabel!
  @IBOutlet var modelLabel: UILabel!
  @IBOutlet var carImageView: UIImageView!
  @IBOutlet var lastTimeStartedLabel: UILabel!
  @IBOutlet var numberOfTripsLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var segmentedControl: UISegmentedControl! {
    didSet {
      getDataFromFile()
      updateSegmentedControl()
    }
  }
  @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
    updateSegmentedControl()
  }
  
  @IBAction func startTripPressed(_ sender: UIButton) {
    car.timesDriven += 1
    car.lastStarted = Date()
    
    do {
      try context.save()
      insertDataFrom(selectedCar: car)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  @IBAction func ratePressed(_ sender: UIButton) {
    let alertController = UIAlertController(title: "Rate it", message: "Rate this car please", preferredStyle: .alert)
    let rateAction = UIAlertAction(title: "Rate", style: .default) { action in
      if let text = alertController.textFields?.first?.text {
        self.update(rating: (text as NSString).doubleValue)
      }
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    alertController.addTextField { textField in
      textField.keyboardType = .numberPad
    }
    alertController.addAction(rateAction)
    alertController.addAction(cancelAction)
    
   present(alertController, animated: true, completion: nil)
    
  }
  
  private func update(rating: Double) {
    car.rating = max(min(10,rating),0)
    do {
      try context.save()
      insertDataFrom(selectedCar: car)
    } catch let error as NSError {
      let alertController = UIAlertController(title: "Wrong value", message: "Wrong input", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default)

      alertController.addAction(okAction)
      present(alertController, animated: true)
      print(error.localizedDescription)
    }
    
  }
  
  
  private func insertDataFrom(selectedCar car: RentedCar) {
    carImageView.image = UIImage(data: car.imageData!)
    markLabel.text = car.mark
    modelLabel.text = car.model
    ratingLabel.text = "Rating: \(car.rating) / 10"
    numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
    
    lastTimeStartedLabel.text = "Last time started: \(dateFormatter.string(from: car.lastStarted!))"
  }
  
  private func getDataFromFile() {
    let fetchRequest: NSFetchRequest<RentedCar> = RentedCar.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "mark != nil")
    
    var records = 0
    
    do {
      records = try context.count(for: fetchRequest)
      print("Is Data there already?")
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    
    guard records == 0 else { return }
    
    
    guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
          let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
    
    for dictionary in dataArray {
      let entity = NSEntityDescription.entity(forEntityName: "RentedCar", in: context)
      let car = NSManagedObject(entity: entity!, insertInto: context) as! RentedCar
      
      let carDictionary = dictionary as! [String : AnyObject]
      car.mark = carDictionary["mark"] as? String
      car.model = carDictionary["model"] as? String
      car.rating = carDictionary["rating"] as! Double
      car.lastStarted = carDictionary["lastStarted"] as? Date
      car.timesDriven = carDictionary["timesDriven"] as! Int16
      
      let imageName = carDictionary["imageName"] as? String
      let image = UIImage(named: imageName!)
      let imageData = image!.pngData()
      car.imageData = imageData
    }
  }
  
  private func updateSegmentedControl() {
    let fetchRequest: NSFetchRequest<RentedCar> = RentedCar.fetchRequest()
    let mark = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
    
    do {
      let results = try context.fetch(fetchRequest)
      car = results.first
      insertDataFrom(selectedCar: car!)
    } catch let error as NSError {
      print(error.localizedDescription)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

