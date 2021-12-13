//
//  ViewController.swift
//  EnvFile
//
//  Created by 坂本龍哉 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let env = ProcessInfo.processInfo.environment
        print(#function, env["TWITTER_CONSUMER_KEY"], env["TWITTER_CONSUMER_SECRET"])
    }


}

