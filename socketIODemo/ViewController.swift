//
//  ViewController.swift
//  socketIODemo
//  server:
//  node app.js
//
//  Created by wwwins on 2016/9/1.
//  Copyright © 2016年 wwwins. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

  var socket: SocketIOClient?

  @IBOutlet weak var textViewForReceive: UITextView!
  @IBOutlet weak var textFieldForSend: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated);

    textViewForReceive.text = "";

    socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:8080")!, config: [.Log(true), .ForcePolling(true)])
    addHandlers()
    socket?.connect()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func addHandlers() {
    socket?.on("connect") {data, ack in
      print("### socket connected ###");

    }

    socket?.on("error") {data, ack in
      print("### socket error ###")

    }

    socket?.on("startgame") {data, ack in
      print("### startgame ###")
      self.showMessage(data);

    }

    socket?.on("msg") {data, ack in
      self.showMessage(data);
    }

  }

  func showMessage(data:[AnyObject]) {
    if let msg = data[0] as? String {
      textViewForReceive.text = textViewForReceive.text + msg + "\r"
    }
  }

  @IBAction func sendMessage(sender: AnyObject) {
    if textFieldForSend.text?.characters.count > 0 {
      socket?.emit("msg", textFieldForSend.text!)
      textFieldForSend.text = ""
    }
  }
}

