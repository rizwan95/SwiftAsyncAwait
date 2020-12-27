//
//  ViewController.swift
//  AsyncAwait
//
//  Created by Rizwan Ahmed on 25/12/20.
//  Contact me at rizwan@ohmyswift.com
//

import UIKit

class ViewController: UIViewController {

    var playerNames: [String] = []
    var gamePlayers: [Players] = Players.allCases
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPlayerNames {
            print("Printing names from a completion handler ", self.playerNames)
        }
        self.performAsyncAwait()
    }
    
    internal func getPlayerNames(completion: (() -> Void)? = nil) {
        DispatchQueue.global().async {
            self.playerNames = self.gamePlayers.map {
                return $0.name
            }
            completion?()
        }
    }
    
    internal func refreshPlayers() async {
        self.playerNames = await self.getNames()
    }
    
    internal func getNames() async -> [String] {
        return self.gamePlayers.map{$0.name}
    }
    
    @asyncHandler internal func performAsyncAwait() {
        await self.refreshPlayers()
        print("Printing names from a async await function ", playerNames)
    }

}

enum Players: CaseIterable {
    case ramesh
    case akhil
    case suresh
    case ahmed
}

extension Players {
    var name: String {
        switch self {
        case .ramesh:
            return "Ramesh Kumar"
        case .akhil:
            return "Akhil"
        case .suresh:
            return "Suresh Kumar"
        case .ahmed:
            return "Ahmed"
        }
    }
}
