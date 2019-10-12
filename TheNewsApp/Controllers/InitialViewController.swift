//
//  InitialViewController.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/24/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colors: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
    }
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWeather", sender: self)
    }
    @IBAction func newsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToNews", sender: self)
    }
}
