// 
//  SPConnectViewController.swift
//  Seena Patient
//
//  Created by Ahmed Khalifa on 09/06/2022.
//  Copyright © 2022 RKAnjel. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class SPConnectViewController: UIViewController, SPConnectViewProtocol {
    // MARK: - Outlets
    
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var recievedMsgLabel: UILabel!
    // MARK: - Attributes
	var presenter: SPConnectPresenterProtocol!
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    // MARK: - Life Cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupMultipeerConnectivity()
    }
    func setupMultipeerConnectivity(){
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
    }

    @IBAction func sendMessage(_ sender: Any) {
        if mcSession.connectedPeers.count > 0 {
                do {
                    let data = Data(messageTextfield.text?.utf8 ?? "Seena PAY".utf8
                    )

                    try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                    
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(SPConnectViewController.self)  release from memory")
    }
}

// MARK: - Setup UI
extension SPConnectViewController {
    
    func setupUI() {
    }
}
extension SPConnectViewController : MCSessionDelegate, MCBrowserViewControllerDelegate {
    // your view controller here
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {

    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {

    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {

    }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")

        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")

        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let str = String(decoding: data, as: UTF8.self)
        DispatchQueue.main.async {
            self.recievedMsgLabel.text = str

        }

    }
    
   @IBAction func startHosting() {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "seenapay", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
    }

    @IBAction func joinSession() {
        let mcBrowser = MCBrowserViewController(serviceType: "seenapay", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
}
