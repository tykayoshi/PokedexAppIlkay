//
//  ViewController.swift
//  PokedexApp
//
//  Created by TAE experts on 10/04/2017.
//  Copyright © 2017 IlkayHamit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    //Create Pokemon Array
    var pokemonArray = [Pokemon]()
    var filteredArray = [Pokemon]()
    
    //Check we are searching
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set sources to view controller, DONT FORGET
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    //Filter results when key strokes are done
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text == nil || searchBar.text == "") {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        } else if ((searchBar.text?.characters.count)! >= 2) {
            
            inSearchMode = true
            print("lets search!")
            
            let lower = searchBar.text!.lowercased()
            
            //$0 looks a every object in the array.
            //Take the name in lowercase and if it's there put it in the filtered array
            filteredArray = pokemonArray.filter({ $0.name.range(of: lower) != nil })
            
            //Reload the table
            collection.reloadData()
        }
        
    }
    
    //Parse CSV Data
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            
            for row in rows {
                
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(name: name, pokedexID: pokeID)
                pokemonArray.append(pokemon)
            }
            
            
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = filteredArray[indexPath.row]
                cell.configureCell(pokemon)
                
            } else {
                pokemon = pokemonArray[indexPath.row]
                cell.configureCell(pokemon)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //When pokemon is selected do this
        //Segue to detail view
        let pokemon: Pokemon!
        
        if inSearchMode {
            pokemon = filteredArray[indexPath.row]
            
        } else {
            pokemon = pokemonArray[indexPath.row]
        }
        
        //Perform segue and send pokemon which is selected
        performSegue(withIdentifier: "showDetail", sender: pokemon)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredArray.count
        } else {
            return pokemonArray.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 104, height: 101)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the segue is of showDetail, make the destination the detail VC
        //Send the pokemon object.
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                if let pokemon = sender as? Pokemon {
                    detailVC.recievedPokemon = pokemon
                }
            }
        }
    }


}

