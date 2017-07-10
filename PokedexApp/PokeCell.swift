//
//  PokeCell.swift
//  PokedexApp
//
//  Created by TAE experts on 10/04/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImageView : UIImageView!
    @IBOutlet weak var pokeNameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    //Customise the cell abit
    //Round the corners
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        //Creat a Pokemon Object
        self.pokemon = pokemon
        
        //Grab pokemon name
        pokeNameLbl.text = self.pokemon.name.capitalized
        //Pokedex ID is same as imagename
        pokeImageView.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
    }
    
}
