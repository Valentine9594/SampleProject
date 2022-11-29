//
//  Constants.swift
//  SampleProject
//
//  Created by Neosoft on 28/11/22.
//

import Foundation

enum NodesStatus: String {
    case added = "Nodes Added"
    case removed = "Nodes Removed"
    case notFound = "Nodes Not Found In Hit List"
    
    func printStatus() {
        print(self.rawValue)
    }
}
