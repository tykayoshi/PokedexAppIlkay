//
//  Pokemon.swift
//  PokedexApp
//
//  Created by TAE experts on 10/04/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvoText: String!
    private var _pokemonURL: String!
    
    var nextEvoText: String {
        
        if _nextEvoText == nil {
            
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }
    
    var type: String {
        
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        
        return _description
    }

    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_POKEMON)\(self.pokedexID)/"
        
    }
    
    func downloadPokemonData(completed: @escaping DownloadComplete) {
        
    Alamofire.request(_pokemonURL).responseJSON { (response) in
        
        //Grab data
        if let dict = response.result.value as? Dictionary<String, AnyObject>{
            
            if let weight = dict["weight"] as? String {
                self._weight = weight
            }
            
            if let height = dict["height"] as? String {
                self._height = height
            }
            
            if let attack = dict["attack"] as? Int {
                self._attack = "\(attack)"
            }
            
            if let defense = dict["defense"] as? Int {
                self._defense = "\(defense)"
            }
            
            if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                
                if let name = types[0]["name"] {
                    
                    self._type = name.capitalized
                }
                
                //If there is more than 1 type find the rest
                if types.count > 1 {
                    
                    for x in 1..<types.count {
                        if let name = types[x]["name"] {
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                    
                }
            
            } else {
                self._type = ""
            }
            
            if let descArra = dict["descriptions"] as? [Dictionary<String, String>] , descArra.count > 0 {
                
                if let url = descArra[0]["resource_uri"] {
                    
                    let descURL = "http://pokeapi.co\(url)"
                    
                    Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                        
                        if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                            
                        }
                        
                    })
                    
                }
                
            }
            
        }
        
        completed()

    }
}
}
