//
//  ViewController.swift
//  OperationQueueTuto
//
//  Created by Tejora on 17/01/20.
//  Copyright © 2020 Tejora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var block1 = false
    var block2 = false
    let operationQueue: OperationQueue = OperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downloadDetails()
        
    }

    func downloadDetails(){

        let operation1 = BlockOperation() { [weak self] in
        guard let strongSelf = self else {
                return
            }
        DispatchQueue.main.async {
               // strongSelf.handleResponse()
        }

        let operation2 = BlockOperation() { [weak self] in

                guard let strongSelf = self else {
                    return
                }
                for i in 1...1000 {
                    print("operation2 @@@@@ block index is \(i)")
                }
                strongSelf.block1 = true

                DispatchQueue.main.async {
                    strongSelf.handleResponse()
                }
            }
            let operation3 = BlockOperation() { [weak self] in

                guard let strongSelf = self else {
                    return
                }
                for i in 1...1000 {
                    print("operation3 ***** block index is \(i)")
                }
                strongSelf.block2 = true

                DispatchQueue.main.async {
                    strongSelf.handleResponse()
                }
            }
            strongSelf.operationQueue.addOperation(operation2)
            strongSelf.operationQueue.addOperation(operation3)
        }

        self.operationQueue.addOperation(operation1)
         print("OPERATIONS COUNT: \(self.operationQueue.operations.count)")
    }

    func handleResponse() {
        print("OPERATIONS IN PROGRESS: \(self.operationQueue.operations.count)")
        if self.operationQueue.operations.count == 0 {
            print("ALL OPERATIONS ARE COMPLETE")
            if block2 && block1 {
              print("true")
            } else {
                
            }
        }
    }

    func cancelOperation() {
        self.operationQueue.cancelAllOperations()
    }
}

