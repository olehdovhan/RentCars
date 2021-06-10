//
//  Car+CoreDataProperties.swift
//  RentCars
//
//  Created by Oleh Dovhan on 10.06.2021.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var lastStarted: Date?
    @NSManaged public var mark: String?
    @NSManaged public var model: String?
    @NSManaged public var rating: Double
    @NSManaged public var timesDriven: Int16

}

extension Car : Identifiable {

}
