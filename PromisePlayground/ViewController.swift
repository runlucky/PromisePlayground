//
//  ViewController.swift
//  PromisePlayground
//
//  Created by H5266 on 2019/08/02.
//  Copyright © 2019 Kakeru. All rights reserved.
//

import UIKit
import PromiseKit
import ObjectiveC

class ViewController: UIViewController {

    private func hoge() -> Int { return 1 }
    private func hoge() -> String { return "" }

    @IBOutlet private weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "private label" + hoge()

        firstly {
            hoge()
        }.then { result -> Promise<Int> in
            if result == "aa" {
                print("a")
                return Promise(  Promise(value: 10)
            }

            return self.hoge2()
        }.done { x in
            print("done + " + x.description)
        }
    }

    func hoge() -> Promise<String> {
        return Promise<String> { resolver in
            print("hoge")
            resolver.fulfill("aaa")
        }
    }

    func hoge2() -> Promise<Void> {
        return Promise<Void> { resolver in
            print("hoge2")
//            resolver.fulfill(())
        }
    }

}

