//
//  ViewController.swift
//  RandomCatPicture
//
//  Created by 김태형 on 2020/03/30.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit
import Alamofire

struct CatResponse : Decodable {
    let id : String?
    let url : String?
    let width : Int?
    let height : Int?
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imgViewCat: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionChangeCat(_ sender: Any) {
        getRandomCatPicture()
    }
    func getRandomCatPicture(){
        let parameters: Parameters = [
            "x-api-key" : Network.apiKey
        ]
        Network.shared.getRandomCatPicture(parameters: parameters, completion: { (data) -> (Void) in
            do {
                let res = try JSONDecoder().decode([CatResponse].self, from : data)
                print("cat picture url : \(res[0].url ?? "no url")")
                self.loadCatImage(res[0].url)
            }catch {
                print(error)
            }
        })
    }
    func loadCatImage(_ url : String?){
        let downloadQueue = DispatchQueue(__label: url,attr: nil)
        downloadQueue.async(){
            let data = NSData(contentsOf: NSURL(string: url!)! as URL)
            var image: UIImage?
            if (data != nil){
                image = UIImage(data: data! as Data)
            }
            DispatchQueue.main.async {
                self.imgViewCat.image = image
            }
        }
    }
    
}


