//
//  PokemonDetailViewController.swift
//  PokedexApp
//
//  Created by TAE experts on 11/04/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var recievedPokemon: Pokemon!
    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var descriptionTxt: UILabel!
    
    @IBOutlet var typeLbl: UILabel!
    
    @IBOutlet var defenseLbl: UILabel!
    
    @IBOutlet var baseLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var idLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    
    
    @IBOutlet var nextEvoLbl: UILabel!
    @IBOutlet var currentEvoImg: UIImageView!
    @IBOutlet var nextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLbl.text = recievedPokemon.name
        
        let img = UIImage(named: "\(recievedPokemon.pokedexID)")
        
        mainImage.image = img
        currentEvoImg.image = img
        idLbl.text = "\(recievedPokemon.pokedexID)"
        
        
        recievedPokemon.downloadPokemonData { 
            //Whatever we do here will only be called after network call is complete
            print("hello")
            self.updateUI()

        }
        
        
    }
    
    
    func updateUI() {
        
        baseLbl.text = recievedPokemon.attack
        defenseLbl.text = recievedPokemon.defense
        heightLbl.text = recievedPokemon.height
        weightLbl.text = recievedPokemon.weight
        typeLbl.text = recievedPokemon.type
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
