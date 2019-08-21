//
//  ViewController.swift
//  PromisePlayground
//
//  Created by H5266 on 2019/08/02.
//  Copyright © 2019 Kakeru. All rights reserved.
//

import UIKit
import PromiseKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "HH:mm:ss"

        firstly {
            a()
        }.then {
            log("end")
        }.catch { error in
            log("error")
        }

    }

    func a() -> Promise<Void> {
        return Promise<Void> { fulfill, reject in
            firstly {
                Waiter([1]).wait()
            }.then { result -> Promise<([TimeInterval], [TimeInterval])> in
                when(fulfilled:
                        Waiter(result).wait(),
                    Waiter([-1]).wait()
                )
            }.then { _ in
                fulfill(())
            }.catch { error in
                reject(error)
            }
        }
    }
}


enum PromiseError: Error {
    case invalid
}

class Waiter {
    private let second: [TimeInterval]
    init(_ second: [TimeInterval]) {
        self.second = second
    }

    func wait() -> Promise<[TimeInterval]> {
        if second.first! < 0 {
            return Promise(error: PromiseError.invalid)
        }

        return Promise<[TimeInterval]> { fulfill, reject in
            DispatchQueue.main.asyncAfter(deadline: .now() + self.second.first!) {
                log("fulfill: " + self.second.description)
                fulfill(self.second)
            }
        }
    }
}

func log(_ text: String) {
    print(now + " " + text)
}

var now: String {
    return formatter.string(from: Date())
}

let formatter = DateFormatter()
