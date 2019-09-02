//
//  RNEsriRouter.swift
//  app
//
//  Created by GT4W on 8/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import ArcGIS
import Foundation

public class RNEsriRouter {
  private var parameters: AGSRouteParameters?
  private let routeTask: AGSRouteTask
  
  public init(routeUrl: URL) {
    routeTask = AGSRouteTask(url: routeUrl)
    routeTask.defaultRouteParameters { [weak self](defaultParameters, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      self?.parameters = defaultParameters!
      self?.parameters?.outputSpatialReference = AGSSpatialReference.wgs84()
    }
    routeTask.load { (error) in
      if let error = error {
        print("RNAGSMapView - An Error Occurred: \(error.localizedDescription)")
        return
      }
      print("RNAGSMapView -  Route task loaded")
    } // End Load
  }
  
  /**
   Creates a route for the given map view using the graphics within the specified overlay. Note that the order in which the graphics were added is the order the function will route them.
   - Parameter overlay: The Graphic overlay.
   - Parameter mapView: The map view.
   - Parameter completion: The callback for when the route calculation has completed.
   */
  public func createRoute(withGraphicOverlay overlay: AGSGraphicsOverlay, excludeGraphics: [NSString]?, completion: @escaping (AGSRouteResult?, Error?) -> Void) {
    // Clear stops
    let excludeGraphics = excludeGraphics ?? []
    guard parameters != nil else {
      print("No route parameters specified")
      return
    }
    self.parameters!.clearStops()
    
    // Add the stops
    var stops = [AGSStop]()
    for graphic in overlay.graphics as! [AGSGraphic] {
      if let graphicsId = graphic.attributes["referenceId"] as? NSString, !excludeGraphics.contains(graphicsId) {
        stops.append(AGSStop(point: graphic.geometry as! AGSPoint))
      }
    }
    self.parameters!.setStops(stops)
    // Execute the load
    routeTask.solveRoute(with: self.parameters!, completion: completion)
  }
}
