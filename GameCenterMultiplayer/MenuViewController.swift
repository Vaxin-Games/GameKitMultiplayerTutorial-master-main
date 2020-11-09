//
//  ViewController.swift
//  GameCenterMultiplayer
//
//  Created by Pedro Contine on 29/06/20.
//

import UIKit
import GameKit

class MenuViewController: UIViewController {

    @IBOutlet weak var buttonMultiplayer: UIButton!
    
    private var gameCenterHelper: GameCenterHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init button
        buttonMultiplayer.isEnabled = false
        buttonMultiplayer.layer.cornerRadius = 10
        
        // Activate GameCenter
        gameCenterHelper = GameCenterHelper()
        gameCenterHelper.delegate = self
        gameCenterHelper.authenticatePlayer()
        
        // Implement Gamekit Access Point
        GKAccessPoint.shared.location = .topLeading     // Sets the position of the icon
        GKAccessPoint.shared.showHighlights = true      // Shows the notifications
        GKAccessPoint.shared.isActive = true
    }

    @IBAction func buttonMultiplayerPressed() {
        gameCenterHelper.presentMatchmaker()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? GameViewController,
              let match = sender as? GKMatch else { return }
        
        vc.match = match
    }
}

extension MenuViewController: GameCenterHelperDelegate {
    func didChangeAuthStatus(isAuthenticated: Bool) {
        buttonMultiplayer.isEnabled = isAuthenticated
    }
    
    func presentGameCenterAuth(viewController: UIViewController?) {
        guard let vc = viewController else {return}
        self.present(vc, animated: true)
    }
    
    func presentMatchmaking(viewController: UIViewController?) {
        guard let vc = viewController else {return}
        self.present(vc, animated: true)
    }
    
    func presentGame(match: GKMatch) {
        performSegue(withIdentifier: "showGame", sender: match)
    }
}

